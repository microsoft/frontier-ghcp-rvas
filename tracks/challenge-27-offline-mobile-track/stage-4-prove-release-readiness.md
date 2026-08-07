# Stage 4: Prove Release Readiness

**Difficulty:** ⭐⭐⭐ | **Time:** 60-75 min

## Tasks

1. Add reducer and state tests for draft edits, local saves, queue status,
   successful sync, retryable failure, and conflict resolution.
2. Add integration tests across storage, queue, and the mocked Azure Functions
   client. Include restart, partial flush, duplicate retry, and server version
   mismatch.
3. Test permission adapters with fakes rather than a real camera or location
   service. Cover each degraded mode and the state shown to the technician.
4. Validate all network fixtures and the contract fixture from a clean install.
   Keep the required command path independent of an emulator and Azure access.
5. Complete `docs/release-readiness-template.md`. Record known limitations,
   telemetry needs, support ownership, rollback expectations, and any optional
   native-device checks still outstanding.
6. Run the Release Evidence Pass and review its output. Fix failed evidence
   rather than editing the checklist to hide it.

## Verification

- `npm run validate:fixtures` passes
- `npm run typecheck` passes
- `npm test` passes with meaningful state and integration coverage
- Tests prove restart safety, queue idempotency, and conflict behavior
- Permission and degraded-mode behavior are covered without an emulator
- The release-readiness checklist contains evidence and exact limitations

## What Copilot Helps With vs. What Requires Your Judgment

Copilot is useful for test tables and fixture setup. You decide whether the
evidence matches the real risks. A large test count does not compensate for a
missing restart, duplicate-action, or conflict case.

---

Previous: [Stage 3: Handle Field Failures](stage-3-handle-field-failures.md)
