export type JobStatus = "assigned" | "in-progress" | "complete";
export type InspectionResult = "pass" | "repair-needed";

export interface TechnicianJob {
  id: string;
  assetLabel: string;
  customerName: string;
  address: string;
  scheduledFor: string;
  status: JobStatus;
  serverVersion: number;
  notes?: string;
}

export interface InspectionDraft {
  jobId: string;
  result?: InspectionResult;
  meterReading: string;
  notes: string;
  photoUri?: string;
  coordinates?: {
    latitude: number;
    longitude: number;
  };
  updatedAt: string;
}

export type OfflineAction =
  | {
      id: string;
      type: "save-inspection";
      jobId: string;
      baseVersion: number;
      createdAt: string;
      payload: InspectionDraft;
    }
  | {
      id: string;
      type: "complete-job";
      jobId: string;
      baseVersion: number;
      createdAt: string;
      payload: { completedAt: string };
    };

export interface SyncConflict {
  action: OfflineAction;
  serverJob: TechnicianJob;
  reason: "version-mismatch";
}

export interface NetworkFixture {
  id: "online" | "offline" | "flaky" | "conflict";
  label: string;
  online: boolean;
  latencyMs: number;
  failureRate: number;
  forceConflict?: boolean;
}
