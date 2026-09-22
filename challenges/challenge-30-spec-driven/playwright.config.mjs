import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "./test/browser",
  workers: 1,
  use: { baseURL: "http://127.0.0.1:5081" },
  webServer: {
    command: "node dist/src/server.js",
    env: { HOST: "127.0.0.1", PORT: "5081" },
    url: "http://127.0.0.1:5081",
    reuseExistingServer: false,
  },
});
