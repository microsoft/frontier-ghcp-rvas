import { test, expect } from "@playwright/test";

async function holdResponse(page, url, method) {
  let release;
  let captured;
  const gate = new Promise((resolve) => { release = resolve; });
  const started = new Promise((resolve) => { captured = resolve; });
  await page.route(url, async (route) => {
    if (route.request().method() !== method) return route.continue();
    const response = await route.fetch();
    captured();
    await gate;
    await route.fulfill({ response });
  });
  return { started, release };
}

test("create and submit a request from the register", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
  await page.getByLabel("Title", { exact: true }).fill("Browser smoke request");
  await page.getByLabel("Description", { exact: true }).fill("A request made through the working UI.");
  await page.getByLabel("Estimated cost (USD)").fill("1000.01");
  await page.getByRole("button", { name: "Create draft" }).click();
  const card = page.getByRole("article").filter({ hasText: "Browser smoke request" });
  await expect(card).toContainText("$1,000.01");
  await expect(card.locator(".status")).toHaveText("draft");
  await page.getByLabel("Demo identity").selectOption("manager-1");
  await expect(card.getByRole("button", { name: "Submit request" })).toBeHidden();
  await page.getByLabel("Demo identity").selectOption("employee-1");
  await card.getByRole("button", { name: "Submit request" }).click();
  await expect(card.locator(".status")).toHaveText("submitted");
  await page.reload();
  await expect(page.getByRole("article").filter({ hasText: "Browser smoke request" }).locator(".status"))
    .toHaveText("submitted");
});

test("shows server errors without losing the draft form", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
  await page.route("**/api/requests", (route) => {
    if (route.request().method() === "POST") {
      return route.fulfill({ status: 500, contentType: "application/json", body: JSON.stringify({ error: "Test server failure." }) });
    }
    return route.continue();
  });
  await page.getByLabel("Title", { exact: true }).fill("Keep this draft");
  await page.getByLabel("Description", { exact: true }).fill("Do not discard this text.");
  await page.getByLabel("Estimated cost (USD)").fill("12.50");
  await page.getByRole("button", { name: "Create draft" }).click();
  await expect(page.getByRole("alert")).toHaveText("Test server failure.");
  await expect(page.getByLabel("Title", { exact: true })).toHaveValue("Keep this draft");
  await expect(page.getByRole("button", { name: "Create draft" })).toBeEnabled();
  await expect(page.getByRole("button", { name: "Refresh", exact: true })).toBeEnabled();
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
});

test("refresh blocks changes until its snapshot is displayed", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
  await page.getByLabel("Title", { exact: true }).fill("Draft after refresh");
  await page.getByLabel("Description", { exact: true }).fill("Keep this request in the register.");
  await page.getByLabel("Estimated cost (USD)").fill("1000.01");
  const pending = await holdResponse(page, "**/api/requests", "GET");
  try {
    await page.getByRole("button", { name: "Refresh", exact: true }).click();
    await pending.started;
    await expect(page.getByRole("button", { name: "Create draft" })).toBeDisabled();
    await expect(page.getByLabel("Demo identity")).toBeDisabled();
    await expect(page.getByRole("button", { name: "Submit request" })).toBeDisabled();
    pending.release();
    await expect(page.getByRole("status")).toHaveText("Register refreshed.");
    await page.getByRole("button", { name: "Create draft" }).click();
    const card = page.getByRole("article").filter({ hasText: "Draft after refresh" });
    await expect(card).toHaveCount(1);
    await page.getByRole("button", { name: "Refresh", exact: true }).click();
    await expect(page.getByRole("status")).toHaveText("Register refreshed.");
    await expect(card).toHaveCount(1);
  } finally {
    pending.release();
  }
});

test("pending creation blocks refresh and duplicate creation", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
  await page.getByLabel("Title", { exact: true }).fill("Create once");
  await page.getByLabel("Description", { exact: true }).fill("Wait for the creation response.");
  await page.getByLabel("Estimated cost (USD)").fill("12.50");
  const pending = await holdResponse(page, "**/api/requests", "POST");
  try {
    await page.getByRole("button", { name: "Create draft" }).click();
    await pending.started;
    await expect(page.getByRole("button", { name: "Refresh", exact: true })).toBeDisabled();
    await expect(page.getByRole("button", { name: "Create draft" })).toBeDisabled();
    await expect(page.getByLabel("Demo identity")).toBeDisabled();
    pending.release();
    await expect(page.getByRole("article").filter({ hasText: "Create once" })).toHaveCount(1);
    await page.getByRole("button", { name: "Refresh", exact: true }).click();
    await expect(page.getByRole("status")).toHaveText("Register refreshed.");
    await expect(page.getByRole("article").filter({ hasText: "Create once" })).toHaveCount(1);
    const requests = await (await page.request.get("/api/requests")).json();
    expect(requests.filter((request) => request.title === "Create once")).toHaveLength(1);
  } finally {
    pending.release();
  }
});

test("pending submission blocks refresh and other changes", async ({ page }) => {
  const response = await page.request.post("/api/requests", {
    headers: { "x-demo-user-id": "employee-1" },
    data: { title: "Submit once", description: "Wait for the submission response.", costCents: 500 },
  });
  expect(response.status()).toBe(201);
  const created = await response.json();
  await page.goto("/");
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
  const card = page.getByRole("article").filter({ hasText: "Submit once" });
  const pending = await holdResponse(page, `**/api/requests/${created.id}/submit`, "POST");
  try {
    await card.getByRole("button", { name: "Submit request" }).click();
    await pending.started;
    await expect(page.getByRole("button", { name: "Refresh", exact: true })).toBeDisabled();
    await expect(page.getByRole("button", { name: "Create draft" })).toBeDisabled();
    await expect(page.getByLabel("Demo identity")).toBeDisabled();
    await expect(card.getByRole("button", { name: "Submit request" })).toBeDisabled();
    pending.release();
    await expect(card.locator(".status")).toHaveText("submitted");
    await page.getByRole("button", { name: "Refresh", exact: true }).click();
    await expect(page.getByRole("status")).toHaveText("Register refreshed.");
    await expect(card.locator(".status")).toHaveText("submitted");
  } finally {
    pending.release();
  }
});

test("keeps the register and form usable on a narrow screen", async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto("/");
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
  await expect(page.getByRole("heading", { name: "Request register" })).toBeVisible();
  await expect(page.getByLabel("Title", { exact: true })).toBeVisible();
  expect(await page.evaluate(() => document.documentElement.scrollWidth)).toBeLessThanOrEqual(390);
});

test("failed initial loading keeps the form disabled and allows retry", async ({ page }) => {
  await page.route("**/api/requests", (route) => route.fulfill({
    status: 503,
    contentType: "application/json",
    body: JSON.stringify({ error: "Register unavailable." }),
  }));
  await page.goto("/");
  await expect(page.getByRole("alert")).toHaveText("Register unavailable.");
  await expect(page.getByRole("button", { name: "Create draft" })).toBeDisabled();
  await expect(page.getByLabel("Demo identity")).toBeDisabled();
  await expect(page.getByRole("button", { name: "Refresh", exact: true })).toBeEnabled();
  await page.unroute("**/api/requests");
  await page.getByRole("button", { name: "Refresh", exact: true }).click();
  await expect(page.getByRole("status")).toHaveText("Register refreshed.");
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
  await expect(page.getByRole("button", { name: "Create draft" })).toBeEnabled();
  await expect(page.getByRole("alert")).toBeHidden();
});
