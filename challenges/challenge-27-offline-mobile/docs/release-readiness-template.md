# Release Readiness

Complete this checklist during Stage 4. Add evidence or a short reason for each
decision.

## Data and Synchronization

- [ ] Jobs, drafts, and queued actions survive an app restart
- [ ] Queue ordering and idempotency behavior are tested
- [ ] Conflict behavior is visible to the technician and does not lose work
- [ ] Corrupt or incompatible local data has a recovery path

## Device and Degraded Modes

- [ ] Camera denial, blocking, and unavailability have useful alternatives
- [ ] Location denial, blocking, and unavailability have useful alternatives
- [ ] The inspection can be completed without optional device capabilities

## Accessibility

- [ ] Screen reader names, roles, values, and state changes are checked
- [ ] Touch targets, text scaling, focus order, and contrast are checked
- [ ] Offline, queued, failed, and conflicted states do not rely on color alone

## Test and Release Evidence

- [ ] State and queue tests pass in Node
- [ ] Azure Functions contract and network fixtures pass validation
- [ ] At least one end-to-end synchronization journey is covered
- [ ] Known limitations, telemetry needs, rollback, and support ownership are recorded
