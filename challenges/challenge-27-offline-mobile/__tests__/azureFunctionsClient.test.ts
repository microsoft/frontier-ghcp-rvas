import type { NetworkFixture, OfflineAction } from "../src/domain/types";
import {
  AzureFunctionsClient,
  NetworkUnavailableError,
  SyncConflictError
} from "../src/services/azureFunctionsClient";

const online: NetworkFixture = {
  id: "online",
  label: "Stable connection",
  online: true,
  latencyMs: 0,
  failureRate: 0
};

const action: OfflineAction = {
  id: "action-1",
  type: "complete-job",
  jobId: "JOB-1042",
  baseVersion: 3,
  createdAt: "2026-08-07T11:00:00.000Z",
  payload: { completedAt: "2026-08-07T11:00:00.000Z" }
};

test("matches the mocked Azure Functions happy path", async () => {
  const receipt = await new AzureFunctionsClient(online).syncAction(action);
  expect(receipt).toMatchObject({ actionId: "action-1", serverVersion: 4 });
});

test("exposes offline failures for queue handling", async () => {
  const client = new AzureFunctionsClient({ ...online, id: "offline", online: false });
  await expect(client.syncAction(action)).rejects.toBeInstanceOf(
    NetworkUnavailableError
  );
});

test("returns a typed conflict when the server version changed", async () => {
  const client = new AzureFunctionsClient({
    ...online,
    id: "conflict",
    forceConflict: true
  });
  await expect(client.syncAction(action)).rejects.toBeInstanceOf(
    SyncConflictError
  );
});
