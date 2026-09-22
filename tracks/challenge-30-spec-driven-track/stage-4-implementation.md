# Stage 4: Implement and Verify

**Duration:** 105 minutes

## Tasks

1. **Use `/speckit-implement` on the reviewed task list.** Work in small enough
   changes to inspect the generated code. Keep the starter's existing
   validation and explicit error responses.

2. **Check behavior at the API boundary.** Exercise an eligible manager's
   decision and denied actions. In particular, prove that an employee cannot
   decide and that a manager cannot approve their own request. Inspect tests
   for assertions about persisted in-memory state after a rejected operation,
   not just the response status.

3. **Finish the browser flow.** A manager should be able to find a submitted
   request and record a decision. The requester should see the outcome and
   decision evidence. Display server failures instead of showing success
   prematurely. Exercise the rejection policy agreed in Stage 2.

   Remove or update the starter's message saying approval is unavailable once
   it is implemented.

4. **Run the app's checks from the repository root.**

   ```bash
   npm --prefix challenges/challenge-30-spec-driven test
   npm --prefix challenges/challenge-30-spec-driven run test:ui
   ```

   Add feature tests to these suites. Preserve baseline tests unless an
   explicit, reviewed requirement changes their expectation. Do not weaken an
   assertion merely to make a generated implementation pass.

5. **Use `/speckit-converge`.** Inspect each reported gap. If it adds legitimate
   tasks, implement them and repeat the checks. If a finding reflects a wrong
   assumption, correct the relevant artifact rather than expanding scope.
   Use the optional Acceptance Evidence skill here only if you authored it.

6. **Review and commit the first working feature.** Review the specification
   alongside its code and tests. Keep important decisions in the feature
   artifacts; a separate completion report is not required.

## Verification

- Eligible managers can approve or reject submitted requests through the UI.
- The server rejects forbidden actors and invalid or repeated decisions
  without changing the request.
- Decision evidence is visible to the requester.
- The agreed rejection/resubmission behavior is implemented and tested.
- Baseline and feature tests pass, and no material convergence gap remains.

---

Previous: [Stage 3: Plan Against the Existing App](stage-3-plan.md) | Next: [Stage 5: Change the Rules](stage-5-change.md)
