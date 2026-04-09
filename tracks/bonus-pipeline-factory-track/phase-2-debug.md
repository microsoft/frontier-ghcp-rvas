# Phase 2: Debug Staging

[Back to Pipeline Factory Track](../bonus-pipeline-factory-track.md)

**Duration:** 1-1.5 hours

**Focus:** Finding and fixing 5 deliberate bugs in the broken staging deployment

## Tasks

1. **Compare working vs. broken.** The `stage-broken/server.js` is a copy of the API with 5 deliberate bugs introduced. Use Copilot to compare it against the working `api-service/server.js` and identify discrepancies.

2. **Find and fix all 5 bugs.** The bugs represent common staging environment issues:
   - Configuration problems (missing files, wrong paths)
   - Silent error handling that hides failures
   - Missing validation that exists in the working version
   - Hardcoded values that should use environment variables
   - Health checks that report false positives

3. **Document each bug.** For each bug, write a brief incident note:
   - What the bug is
   - How it manifests (what symptom would an operator see?)
   - What the root cause is
   - How you fixed it
   - How to prevent it in the future (what CI check would catch it?)

4. **Use Copilot's `/fix` command.** Try `/fix` on the broken `server.js` and see how many of the 5 bugs it catches directly. Note which ones it finds and which ones require more context.

5. **Add preventive tests.** Write tests specifically designed to catch these 5 bugs. If the staging code is ever broken in these ways again, the tests should fail.

## Verification

- [ ] All 5 bugs identified and documented
- [ ] All 5 bugs fixed in `stage-broken/server.js`
- [ ] Incident notes written for each bug (symptom, root cause, fix, prevention)
- [ ] `/fix` results documented (which bugs it caught, which it missed)
- [ ] Preventive tests written (at least 3)

---

Previous: [Phase 1: CI Pipeline](phase-1-ci.md) | Next: [Phase 3: Reusable Workflows](phase-3-reusable.md)
