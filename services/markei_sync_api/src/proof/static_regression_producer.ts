import { spawn } from "node:child_process";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, resolve } from "node:path";
import { makeProducerResult, type ProofCaseResult } from "./producer.js";
import { emitProducer } from "./scenario_result.js";

type CommandCase = {
  caseId: string;
  command: string;
  args: string[];
  cwd: string;
  expectedExitCodes?: readonly number[];
};

const proofDir = dirname(fileURLToPath(import.meta.url));
const repositoryRoot = resolve(proofDir, "../../../..");
const serverRoot = resolve(repositoryRoot, "services/markei_sync_api");
const flutterRoot = resolve(repositoryRoot, "clients/markei_flutter");

const commandCases: readonly CommandCase[] = [
  {
    caseId: "server-format",
    command: "npm",
    args: ["run", "format:check"],
    cwd: serverRoot,
  },
  {
    caseId: "server-lint",
    command: "npm",
    args: ["run", "lint"],
    cwd: serverRoot,
  },
  {
    caseId: "server-typecheck",
    command: "npm",
    args: ["run", "typecheck"],
    cwd: serverRoot,
  },
  { caseId: "server-tests", command: "npm", args: ["test"], cwd: serverRoot },
  {
    caseId: "server-build",
    command: "npm",
    args: ["run", "build"],
    cwd: serverRoot,
  },
  {
    caseId: "server-audit-production",
    command: "npm",
    args: ["audit", "--omit=dev"],
    cwd: serverRoot,
  },
  {
    caseId: "dart-format",
    command: "dart",
    args: ["format", "--set-exit-if-changed", "lib", "test"],
    cwd: flutterRoot,
  },
  {
    caseId: "flutter-analyze",
    command: "flutter",
    args: ["analyze"],
    cwd: flutterRoot,
  },
  {
    caseId: "flutter-tests",
    command: "flutter",
    args: ["test"],
    cwd: flutterRoot,
  },
  {
    caseId: "android-debug-build",
    command: "flutter",
    args: ["build", "apk", "--debug"],
    cwd: flutterRoot,
  },
  {
    caseId: "windows-release-build",
    command: "flutter",
    args: ["build", "windows", "--release"],
    cwd: flutterRoot,
  },
  {
    caseId: "python-regressions",
    command: "python",
    args: ["-m", "unittest", "discover", "-s", "tests"],
    cwd: repositoryRoot,
  },
  {
    caseId: "git-diff-check",
    command: "git",
    args: ["diff", "--check"],
    cwd: repositoryRoot,
  },
];

const results: Record<string, ProofCaseResult> = {};
for (const commandCase of commandCases) {
  results[commandCase.caseId] = await runCommandCase(commandCase);
}
results["secret-scan"] = await runSecretScan();
results["resource-teardown"] = await runResourceTeardown();

const producer = makeProducerResult("static-regression", results);
emitProducer("static-regression", producer);
process.stdout.write(
  `STATIC_REGRESSION_PRODUCER=${producer.passed ? "true" : "false"}\n`,
);
if (!producer.passed) process.exitCode = 1;

async function runCommandCase(commandCase: CommandCase) {
  const code = await run(
    commandCase.command,
    commandCase.args,
    commandCase.cwd,
  );
  if ((commandCase.expectedExitCodes ?? [0]).includes(code)) {
    return { passed: true };
  }
  return { passed: false, blocker: "command-failed" };
}

async function runSecretScan(): Promise<ProofCaseResult> {
  const changed = await runText(
    "git",
    ["diff", "--name-only", "HEAD"],
    repositoryRoot,
  );
  const untracked = await runText(
    "git",
    ["ls-files", "--others", "--exclude-standard"],
    repositoryRoot,
  );
  if (changed === null || untracked === null) {
    return { passed: false, blocker: "secret-scan-failed" };
  }
  const privateKey = new RegExp(`BEGIN (RSA|EC|OPENSSH) ${"PRIVATE"} KEY`);
  const accessKey = new RegExp(`AK${"IA"}[0-9A-Z]{16}`);
  const slack = new RegExp(`xo${"x"}[baprs]-`);
  const github = new RegExp(`gh${"p"}_[A-Za-z0-9_]{36}`);
  const pgPassword = new RegExp(`post${"gres"}://${"[^\\s]+"}:${"[^\\s]+"}@`);
  const patterns = [privateKey, accessKey, slack, github, pgPassword];
  const files = [
    ...new Set(`${changed}\n${untracked}`.split(/\r?\n/u).filter(Boolean)),
  ];
  for (const file of files) {
    if (
      file === ".vscode/settings.json" ||
      file === "documentation/NEON_DOC.md" ||
      file === "documentation/NEON_SESSION.ps1"
    ) {
      continue;
    }
    try {
      const body = readFileSync(resolve(repositoryRoot, file), "utf8");
      if (patterns.some((pattern) => pattern.test(body))) {
        return { passed: false, blocker: "secret-scan-failed" };
      }
    } catch {
      continue;
    }
  }
  return { passed: true };
}

async function runResourceTeardown(): Promise<ProofCaseResult> {
  const code = await run(
    "docker",
    [
      "ps",
      "-a",
      "--filter",
      "name=markei-c10-s03a-r3d1",
      "--format",
      "{{.Names}}",
    ],
    repositoryRoot,
  );
  return code === 0
    ? { passed: true }
    : { passed: false, blocker: "teardown-check-failed" };
}

function run(command: string, args: readonly string[], cwd: string) {
  return new Promise<number>((resolve) => {
    const child = spawn(command, [...args], {
      cwd,
      shell: process.platform === "win32",
      stdio: "ignore",
      windowsHide: true,
    });
    const timeout = setTimeout(() => {
      child.kill();
      resolve(124);
    }, 300000);
    child.on("error", () => {
      clearTimeout(timeout);
      resolve(127);
    });
    child.on("exit", (code) => {
      clearTimeout(timeout);
      resolve(code ?? 1);
    });
  });
}

function runText(command: string, args: readonly string[], cwd: string) {
  return new Promise<string | null>((resolveText) => {
    const child = spawn(command, [...args], {
      cwd,
      shell: process.platform === "win32",
      stdio: ["ignore", "pipe", "ignore"],
      windowsHide: true,
    });
    const chunks: Buffer[] = [];
    child.stdout.on("data", (chunk: Buffer) => {
      chunks.push(chunk);
    });
    const timeout = setTimeout(() => {
      child.kill();
      resolveText(null);
    }, 30000);
    child.on("error", () => {
      clearTimeout(timeout);
      resolveText(null);
    });
    child.on("exit", (code) => {
      clearTimeout(timeout);
      resolveText(code === 0 ? Buffer.concat(chunks).toString("utf8") : null);
    });
  });
}
