import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import test from "node:test";

const cliPath = new URL("../src/cli.js", import.meta.url);

function invoke(...args: string[]) {
  return spawnSync(process.execPath, [cliPath.pathname, ...args], {
    encoding: "utf8"
  });
}

test("lists profiles as JSON", () => {
  const result = invoke("profile", "list", "--json");
  assert.equal(result.status, 0);
  const profiles = JSON.parse(result.stdout) as Array<{ id: string }>;
  assert.deepEqual(
    profiles.map((profile) => profile.id),
    ["api", "web"]
  );
});

test("prints a bash setup plan", () => {
  const result = invoke("plan", "api");
  assert.equal(result.status, 0);
  assert.match(result.stdout, /API developer setup/);
  assert.match(result.stdout, /npm test/);
});

test("returns an error for an unknown command", () => {
  const result = invoke("workspace", "list");
  assert.equal(result.status, 1);
  assert.match(result.stderr, /Unknown command/);
});
