export function evaluateResourceTeardown(
  exitCode: number,
  stdout: string,
): boolean {
  return exitCode === 0 && stdout.trim() === "";
}
