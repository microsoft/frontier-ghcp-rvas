import { startAllMocks, stopAllMocks } from "../mocks/services.js";

const running = await startAllMocks();

for (const mock of running) {
  console.log(`${mock.name} mock listening on http://127.0.0.1:${mock.port}`);
}

async function shutdown() {
  await stopAllMocks(running);
  process.exit(0);
}

process.on("SIGINT", shutdown);
process.on("SIGTERM", shutdown);
