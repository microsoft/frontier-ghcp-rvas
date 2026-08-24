import type {
  InspectionDraft,
  OfflineAction,
  TechnicianJob
} from "../domain/types";

export interface LocalSnapshot {
  jobs: TechnicianJob[];
  drafts: Record<string, InspectionDraft>;
  queue: OfflineAction[];
}

export interface LocalStore {
  load(): Promise<LocalSnapshot | null>;
  save(snapshot: LocalSnapshot): Promise<void>;
}

export class SessionOnlyStore implements LocalStore {
  private snapshot: LocalSnapshot | null = null;

  async load(): Promise<LocalSnapshot | null> {
    return this.snapshot ? structuredClone(this.snapshot) : null;
  }

  async save(snapshot: LocalSnapshot): Promise<void> {
    this.snapshot = structuredClone(snapshot);
  }
}

// This starter deliberately uses memory only. Closing or refreshing the app
// loses jobs, drafts, and queued work. Replace it with durable local storage.
export const localStore: LocalStore = new SessionOnlyStore();
