import jobsFixture from "../fixtures/jobs.json";
import type {
  NetworkFixture,
  OfflineAction,
  SyncConflict,
  TechnicianJob
} from "../domain/types";

export interface SyncReceipt {
  actionId: string;
  serverVersion: number;
  syncedAt: string;
}

export class NetworkUnavailableError extends Error {
  constructor() {
    super("The mocked Azure Functions endpoint is unavailable.");
    this.name = "NetworkUnavailableError";
  }
}

export class SyncConflictError extends Error {
  constructor(public readonly conflict: SyncConflict) {
    super(`Job ${conflict.action.jobId} changed on the server.`);
    this.name = "SyncConflictError";
  }
}

const wait = (milliseconds: number) =>
  new Promise((resolve) => setTimeout(resolve, milliseconds));

export class AzureFunctionsClient {
  constructor(
    private readonly fixture: NetworkFixture,
    private readonly random: () => number = Math.random
  ) {}

  async listJobs(): Promise<TechnicianJob[]> {
    await this.checkNetwork();
    return structuredClone(jobsFixture) as TechnicianJob[];
  }

  async syncAction(action: OfflineAction): Promise<SyncReceipt> {
    await this.checkNetwork();
    const serverJob = (jobsFixture as TechnicianJob[]).find(
      (job) => job.id === action.jobId
    );

    if (!serverJob) {
      throw new Error(`Unknown job ${action.jobId}`);
    }

    if (
      this.fixture.forceConflict ||
      action.baseVersion !== serverJob.serverVersion
    ) {
      throw new SyncConflictError({
        action,
        serverJob: structuredClone(serverJob),
        reason: "version-mismatch"
      });
    }

    return {
      actionId: action.id,
      serverVersion: serverJob.serverVersion + 1,
      syncedAt: new Date().toISOString()
    };
  }

  private async checkNetwork() {
    await wait(this.fixture.latencyMs);
    if (!this.fixture.online || this.random() < this.fixture.failureRate) {
      throw new NetworkUnavailableError();
    }
  }
}
