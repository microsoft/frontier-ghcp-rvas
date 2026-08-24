import type { NetworkFixture, OfflineAction } from "../src/domain/types";
import { AzureFunctionsClient } from "../src/services/azureFunctionsClient";
import { flushQueue } from "../src/sync/offlineQueue";

const action: OfflineAction = {
  id: "action-1",
  type: "complete-job",
  jobId: "JOB-1042",
  baseVersion: 3,
  createdAt: "2026-08-07T11:00:00.000Z",
  payload: { completedAt: "2026-08-07T11:00:00.000Z" }
};

test("keeps actions queued when the connection is unavailable", async () => {
  const fixture: NetworkFixture = {
    id: "offline",
    label: "No signal",
    online: false,
    latencyMs: 0,
    failureRate: 1
  };

  const result = await flushQueue(
    [action],
    new AzureFunctionsClient(fixture)
  );

  expect(result.remaining).toEqual([action]);
  expect(result.syncedActionIds).toEqual([]);
});

test.todo("retries transient failures without reordering dependent actions");
test.todo("applies the chosen conflict policy and records the decision");
