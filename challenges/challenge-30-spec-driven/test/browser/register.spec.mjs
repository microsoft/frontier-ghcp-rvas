import { test, expect } from "@playwright/test";

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
});

test("keeps the register and form usable on a narrow screen", async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto("/");
  await expect(page.getByLabel("Demo identity")).toBeEnabled();
  await expect(page.getByRole("heading", { name: "Request register" })).toBeVisible();
  await expect(page.getByLabel("Title", { exact: true })).toBeVisible();
  expect(await page.evaluate(() => document.documentElement.scrollWidth)).toBeLessThanOrEqual(390);
});
