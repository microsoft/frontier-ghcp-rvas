import type { OfflineAction, SyncConflict } from "../domain/types";
import {
  AzureFunctionsClient,
  NetworkUnavailableError,
  SyncConflictError
} from "../services/azureFunctionsClient";

export interface FlushResult {
  remaining: OfflineAction[];
  syncedActionIds: string[];
  conflicts: SyncConflict[];
}

export async function flushQueue(
  queue: OfflineAction[],
  client: AzureFunctionsClient
): Promise<FlushResult> {
  const result: FlushResult = {
    remaining: [],
    syncedActionIds: [],
    conflicts: []
  };

  for (const action of queue) {
    try {
      await client.syncAction(action);
      result.syncedActionIds.push(action.id);
    } catch (error) {
      if (error instanceof SyncConflictError) {
        result.conflicts.push(error.conflict);
        result.remaining.push(action);
        continue;
      }

      if (error instanceof NetworkUnavailableError) {
        result.remaining.push(action);
        continue;
      }

      throw error;
    }
  }

  // The starter has no retry schedule, ordering guarantees, idempotency
  // strategy, or conflict resolution policy. Participants supply those.
  return result;
}
