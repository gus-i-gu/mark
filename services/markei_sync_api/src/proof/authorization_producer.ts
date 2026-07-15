import { spawn } from "node:child_process";
import pg from "pg";

const containerName = "markei-c10-s03a-r3d1-auth-pg";
const port = 55439;
const adminUrl = `postgres://postgres@127.0.0.1:${port}/postgres`;
const dbName = "markei_r3d1_auth";

try {
  await startContainer();
  await provision();
  const output = await runHarness();
  const line = output
    .split(/\r?\n/u)
    .find((item) => item.startsWith("PROOF_PRODUCER authorization-race "));
  if (!line) throw new Error("missing authorization producer");
  process.stdout.write(`${line}\n`);
  process.stdout.write("AUTHORIZATION_RACE_MATRIX=partial\n");
  process.exitCode = 1;
} catch {
  process.stdout.write("AUTHORIZATION_RACE_MATRIX=partial\n");
  process.exitCode = 1;
} finally {
  await run("docker", ["rm", "-f", containerName], [0, 1]).catch(() => 1);
}

async function startContainer() {
  await run("docker", ["rm", "-f", containerName], [0, 1]);
  const started = await run(
    "docker",
    [
      "run",
      "--name",
      containerName,
      "-e",
      "POSTGRES_HOST_AUTH_METHOD=trust",
      "-p",
      `127.0.0.1:${port}:5432`,
      "-d",
      "postgres:18-alpine",
    ],
    [0],
  );
  if (started !== 0) throw new Error("postgres unavailable");
  for (let attempt = 0; attempt < 30; attempt++) {
    if (
      (await run(
        "docker",
        ["exec", containerName, "pg_isready", "-U", "postgres"],
        [0, 1],
      )) === 0
    ) {
      return;
    }
    await new Promise((resolve) => setTimeout(resolve, 1000));
  }
  throw new Error("postgres unavailable");
}

async function provision() {
  const admin = new pg.Pool({ connectionString: adminUrl, max: 1 });
  try {
    await admin.query("create role markei_runtime");
    await admin.query("create role lab_migrator login createrole createdb");
    await admin.query("create role lab_runtime login");
    await admin.query("grant markei_runtime to lab_runtime");
    await admin.query(`create database ${dbName} owner lab_migrator`);
  } finally {
    await admin.end();
  }
}

function runHarness() {
  return runText("npm", ["run", "test:hosted-local"], {
    LAB_MIGRATOR_URL: `postgres://lab_migrator@127.0.0.1:${port}/${dbName}`,
    LAB_RUNTIME_URL: `postgres://lab_runtime@127.0.0.1:${port}/${dbName}`,
  });
}

function run(
  command: string,
  args: readonly string[],
  allowed: readonly number[],
) {
  return new Promise<number>((resolve) => {
    const child = spawn(command, [...args], {
      shell: process.platform === "win32",
      stdio: "ignore",
      windowsHide: true,
    });
    const timeout = setTimeout(() => {
      child.kill();
      resolve(124);
    }, 120000);
    child.on("error", () => {
      clearTimeout(timeout);
      resolve(127);
    });
    child.on("exit", (code) => {
      clearTimeout(timeout);
      const exit = code ?? 1;
      resolve(allowed.includes(exit) ? 0 : exit);
    });
  });
}

function runText(
  command: string,
  args: readonly string[],
  env: Record<string, string>,
) {
  return new Promise<string>((resolve, reject) => {
    const child = spawn(command, [...args], {
      cwd: process.cwd(),
      env: { ...process.env, ...env },
      shell: process.platform === "win32",
      stdio: ["ignore", "pipe", "ignore"],
      windowsHide: true,
    });
    const chunks: Buffer[] = [];
    child.stdout.on("data", (chunk: Buffer) => chunks.push(chunk));
    const timeout = setTimeout(() => {
      child.kill();
      reject(new Error("timeout"));
    }, 180000);
    child.on("error", (error) => {
      clearTimeout(timeout);
      reject(error);
    });
    child.on("exit", () => {
      clearTimeout(timeout);
      resolve(Buffer.concat(chunks).toString("utf8"));
    });
  });
}
