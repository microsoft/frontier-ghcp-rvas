import assert from "node:assert/strict";
import { once } from "node:events";
import type { AddressInfo } from "node:net";
import { test, type TestContext } from "node:test";
import { createApp } from "../src/app.js";

async function client(t: TestContext) {
  const server = createApp().listen(0, "127.0.0.1");
  await once(server, "listening");
  t.after(() => new Promise<void>((resolve, reject) => {
    server.close((error) => error ? reject(error) : resolve());
    server.closeAllConnections();
  }));
  const base = `http://127.0.0.1:${(server.address() as AddressInfo).port}`;
  return (path: string, method = "GET", body?: unknown, actor = "employee-1") =>
    fetch(`${base}${path}`, {
      method,
      headers: { "Content-Type": "application/json", "x-demo-user-id": actor },
      ...(body !== undefined ? { body: JSON.stringify(body) } : {}),
    });
}

const valid = { title: " Desk lamp ", description: " A lamp for the shared desk. ", costCents: 4599 };

test("serves the UI, demo users, and seeded request details", async (t) => {
  const request = await client(t);
  const page = await request("/");
  assert.equal(page.status, 200);
  assert.match(await page.text(), /Request register/);
  assert.equal((await request("/app.js")).status, 200);
  const users = await (await request("/api/users")).json();
  assert.equal(users.length, 5);
  const list = await (await request("/api/requests")).json();
  assert.equal(list.length, 3);
  const detail = await (await request("/api/requests/SR-001")).json();
  assert.equal(detail.status, "draft");
  assert.equal(detail.costCents, 24900);
});

test("creates a draft, trims text, and submits it exactly once", async (t) => {
  const request = await client(t);
  const response = await request("/api/requests", "POST", valid);
  assert.equal(response.status, 201);
  const created = await response.json();
  assert.equal(created.title, "Desk lamp");
  assert.equal(created.description, "A lamp for the shared desk.");
  assert.equal(created.requesterId, "employee-1");
  assert.equal(created.status, "draft");
  assert.equal(created.costCents, 4599);
  assert.equal(response.headers.get("location"), `/api/requests/${created.id}`);
  const submitted = await request(`/api/requests/${created.id}/submit`, "POST");
  assert.equal(submitted.status, 200);
  assert.equal((await submitted.json()).status, "submitted");
  assert.equal((await request(`/api/requests/${created.id}/submit`, "POST")).status, 409);
});

test("rejects invalid input without creating requests", async (t) => {
  const request = await client(t);
  for (const body of [
    null, [], {}, { ...valid, title: " " }, { ...valid, title: "a".repeat(101) },
    { ...valid, description: "" }, { ...valid, description: "a".repeat(1001) },
    { ...valid, costCents: -1 }, { ...valid, costCents: 1.5 },
    { ...valid, costCents: "100" }, { ...valid, costCents: Number.MAX_SAFE_INTEGER + 1 },
  ]) {
    const response = await request("/api/requests", "POST", body);
    assert.equal(response.status, 400);
    assert.equal(typeof (await response.json()).error, "string");
  }
  assert.equal((await (await request("/api/requests")).json()).length, 3);
  assert.equal((await request("/api/requests", "POST", { ...valid, costCents: 0 })).status, 201);
});

test("validates actors and preserves state after forbidden submissions", async (t) => {
  const request = await client(t);
  for (const actor of ["", "unknown"]) {
    assert.equal((await request("/api/requests", "POST", valid, actor)).status, 400);
    assert.equal((await request("/api/requests/SR-001/submit", "POST", undefined, actor)).status, 400);
  }
  assert.equal((await request("/api/requests/SR-001/submit", "POST", undefined, "manager-1")).status, 403);
  assert.equal((await (await request("/api/requests/SR-001")).json()).status, "draft");
  assert.equal((await request("/api/requests/SR-999/submit", "POST")).status, 404);
  assert.equal((await request("/api/requests/SR-999")).status, 404);
  assert.equal((await request("/api/missing")).status, 404);
});

test("each application gets independent demo data", async (t) => {
  const first = await client(t);
  const second = await client(t);
  await first("/api/requests/SR-001/submit", "POST");
  assert.equal((await (await second("/api/requests/SR-001")).json()).status, "draft");
});

test("oversized JSON produces an explicit error", async (t) => {
  const request = await client(t);
  const response = await request("/api/requests", "POST", { ...valid, description: "a".repeat(17000) });
  assert.equal(response.status, 413);
  assert.match((await response.json()).error, /16 KB/);
});

test("malformed JSON produces a useful response without changing state", async (t) => {
  const request = await client(t);
  const initial = await request("/api/requests");
  const response = await fetch(initial.url, {
    method: "POST",
    headers: { "Content-Type": "application/json", "x-demo-user-id": "employee-1" },
    body: '{"title":',
  });
  assert.equal(response.status, 400);
  assert.equal((await response.json()).error, "Invalid JSON body.");
  assert.equal((await (await request("/api/requests")).json()).length, 3);
});
