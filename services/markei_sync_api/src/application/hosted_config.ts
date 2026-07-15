export type HostedConfig = {
  nodeEnv: string;
  port: number;
  databaseUrl: string;
  issuer: string;
  audience: string;
  jwksUri: string;
  publicOrigin: string;
  logLevel: "error" | "warn" | "info" | "debug";
  allowHttp: boolean;
};

const keys = [
  "NODE_ENV",
  "PORT",
  "MARKEI_SYNC_DATABASE_URL",
  "MARKEI_AUTH_ISSUER",
  "MARKEI_AUTH_AUDIENCE",
  "MARKEI_PUBLIC_ORIGIN",
  "MARKEI_LOG_LEVEL",
] as const;

export function parseHostedConfig(
  env: NodeJS.ProcessEnv,
  options: { allowLoopbackHttp?: boolean } = {},
): HostedConfig {
  for (const key of keys) requireValue(env, key);
  if (env.MARKEI_SYNC_MIGRATOR_DATABASE_URL) {
    throw new Error("MARKEI_SYNC_MIGRATOR_DATABASE_URL is not accepted");
  }
  const issuer = env.MARKEI_AUTH_ISSUER!;
  const jwksUri = env.MARKEI_AUTH_JWKS_URI ?? deriveJwksUri(issuer);
  const publicOrigin = env.MARKEI_PUBLIC_ORIGIN!;
  const allowHttp = Boolean(options.allowLoopbackHttp);
  requireUrl("MARKEI_AUTH_ISSUER", issuer, allowHttp);
  requireUrl("MARKEI_AUTH_JWKS_URI", jwksUri, allowHttp);
  requireUrl("MARKEI_PUBLIC_ORIGIN", publicOrigin, allowHttp);
  const port = Number(env.PORT);
  if (!Number.isInteger(port) || port < 1 || port > 65535) {
    throw new Error("PORT is malformed");
  }
  const logLevel = env.MARKEI_LOG_LEVEL!;
  if (!["error", "warn", "info", "debug"].includes(logLevel)) {
    throw new Error("MARKEI_LOG_LEVEL is malformed");
  }
  return {
    nodeEnv: env.NODE_ENV!,
    port,
    databaseUrl: env.MARKEI_SYNC_DATABASE_URL!,
    issuer,
    audience: env.MARKEI_AUTH_AUDIENCE!,
    jwksUri,
    publicOrigin,
    logLevel: logLevel as HostedConfig["logLevel"],
    allowHttp,
  };
}

function requireValue(env: NodeJS.ProcessEnv, key: string) {
  if (!env[key]) throw new Error(`${key} is required`);
}

function deriveJwksUri(issuer: string): string {
  const url = new URL(issuer);
  url.pathname = "/.well-known/jwks.json";
  url.search = "";
  url.hash = "";
  return url.toString();
}

function requireUrl(key: string, value: string, allowHttp: boolean) {
  let url: URL;
  try {
    url = new URL(value);
  } catch {
    throw new Error(`${key} is malformed`);
  }
  const loopback = ["127.0.0.1", "::1", "localhost"].includes(url.hostname);
  if (
    url.protocol !== "https:" &&
    !(allowHttp && url.protocol === "http:" && loopback)
  ) {
    throw new Error(`${key} must use HTTPS`);
  }
}
