import type { NetworkFixture, OfflineAction } from "../src/domain/types";
import { appReducer, type AppState } from "../src/state/appReducer";

const network: NetworkFixture = {
  id: "offline",
  label: "No signal",
  online: false,
  latencyMs: 0,
  failureRate: 1
};

const state: AppState = {
  jobs: [],
  drafts: {},
  queue: [],
  conflicts: [],
  network,
  loading: false
};

test("saving a draft appends an offline action", () => {
  const draft = {
    jobId: "JOB-1042",
    result: "pass" as const,
    meterReading: "42.5",
    notes: "Stable",
    updatedAt: "2026-08-07T11:00:00.000Z"
  };
  const action: OfflineAction = {
    id: "action-1",
    type: "save-inspection",
    jobId: draft.jobId,
    baseVersion: 3,
    createdAt: draft.updatedAt,
    payload: draft
  };

  const next = appReducer(state, { type: "draft-saved", draft, action });

  expect(next.drafts[draft.jobId]).toEqual(draft);
  expect(next.queue).toEqual([action]);
});
