import type {
  InspectionDraft,
  NetworkFixture,
  OfflineAction,
  SyncConflict,
  TechnicianJob
} from "../domain/types";

export interface AppState {
  jobs: TechnicianJob[];
  selectedJobId?: string;
  drafts: Record<string, InspectionDraft>;
  queue: OfflineAction[];
  conflicts: SyncConflict[];
  network: NetworkFixture;
  loading: boolean;
  message?: string;
}

export type AppAction =
  | { type: "jobs-loaded"; jobs: TechnicianJob[] }
  | { type: "job-selected"; jobId: string }
  | { type: "draft-saved"; draft: InspectionDraft; action: OfflineAction }
  | { type: "network-changed"; network: NetworkFixture }
  | {
      type: "sync-finished";
      remaining: OfflineAction[];
      conflicts: SyncConflict[];
      syncedCount: number;
    }
  | { type: "message-cleared" };

export function appReducer(state: AppState, action: AppAction): AppState {
  switch (action.type) {
    case "jobs-loaded":
      return { ...state, jobs: action.jobs, loading: false };
    case "job-selected":
      return { ...state, selectedJobId: action.jobId, message: undefined };
    case "draft-saved":
      return {
        ...state,
        drafts: { ...state.drafts, [action.draft.jobId]: action.draft },
        queue: [...state.queue, action.action],
        message: "Inspection saved on this device."
      };
    case "network-changed":
      return { ...state, network: action.network };
    case "sync-finished":
      return {
        ...state,
        queue: action.remaining,
        conflicts: action.conflicts,
        message: `${action.syncedCount} action(s) synchronized.`
      };
    case "message-cleared":
      return { ...state, message: undefined };
    default:
      return state;
  }
}
