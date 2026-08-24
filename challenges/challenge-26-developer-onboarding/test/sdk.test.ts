import assert from "node:assert/strict";
import test from "node:test";

import {
  createSetupPlan,
  getProfile,
  listProfiles
} from "../src/sdk.js";

test("lists all developer profiles", () => {
  assert.deepEqual(
    listProfiles().map((profile) => profile.id),
    ["api", "web"]
  );
});

test("filters profiles by audience", () => {
  const profiles = listProfiles({ audience: "frontend" });
  assert.equal(profiles.length, 1);
  assert.equal(profiles[0]?.id, "web");
});

test("returns an independent profile copy", () => {
  const profile = getProfile("api");
  assert.ok(profile);
  profile.tools.push("Changed by test");
  assert.equal(getProfile("api")?.tools.includes("Changed by test"), false);
});

test("creates a setup plan", () => {
  const plan = createSetupPlan("web");
  assert.equal(plan.profile.name, "Web developer");
  assert.deepEqual(plan.commands, [
    "corepack enable",
    "npm install",
    "npm run build"
  ]);
});

test("rejects an unknown profile", () => {
  assert.throws(() => createSetupPlan("mobile"), /Unknown profile: mobile/);
});
