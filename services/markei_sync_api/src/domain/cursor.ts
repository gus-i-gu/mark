export const originCursor = "c10b:0";

export function encodeCursor(value: number): string {
  if (!Number.isInteger(value) || value < 0) {
    throw new Error("cursor value must be a non-negative integer");
  }
  return `c10b:${value}`;
}

export function decodeCursor(cursor: string | undefined | null): number {
  if (!cursor || cursor === originCursor) {
    return 0;
  }
  const match = /^c10b:(\d+)$/.exec(cursor);
  if (!match) {
    throw new Error("unsupported cursor token");
  }
  return Number(match[1]);
}
