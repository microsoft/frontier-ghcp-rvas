# Stage 5: Change the Rules

**Duration:** 60 minutes

## Tasks

1. **Read the new requirement after completing the first feature.**

   > Requests costing more than USD 1,000 now need two approvals from distinct
   > managers. Neither approver can be the requester. A first approval must not
   > make a high-cost request appear fully approved.

   | Fixed rule | Expected behavior |
   |------------|-------------------|
   | Threshold | Exactly USD 1,000 still needs one approval; USD 1,000.01 needs two |
   | Eligibility | Both approvers are managers, and neither is the requester |
   | Distinct decisions | Repeating an approval from the same manager cannot satisfy the second approval |
   | Rejection | An eligible rejection before completion rejects the request, following the agreed reason policy |
   | Completed requests | Previously completed decisions remain final; do not reopen them |
   | Pending requests | Requests still awaiting a final decision follow the new rule |

2. **Change the living specification first.** Update the existing feature's
   `spec.md`, directly or through `/speckit-clarify`. Add scenarios for
   below/equal/above the threshold and intermediate approval state. Do not ask
   Copilot to patch the code while leaving the old rule in the specification.

   **Facilitator guide:** ask participants what a requester should see after
   the first high-cost approval. Let them choose the state name and UI wording,
   provided it clearly means a decision is still pending. If they allowed
   resubmission, require them to define which old decisions remain history
   and which approvals count toward the new attempt.

3. **Reconcile the existing plan and tasks.** Revise them or rerun the relevant
   Spec Kit skills. Preserve decisions that still matter. Use
   `/speckit-analyze` to find references to the old one-approval rule.
   Do not create an unrelated feature directory to hide the contradiction.

4. **Implement the change and extend the tests.** Cover a repeated approver,
   self-approval, and rejection after the first approval. Confirm that a
   low-cost request still completes after one eligible approval. Demonstrate
   the pending state and final decision in the browser.

   The demo restarts with seeded data, so production migration is outside
   scope. Use test fixtures to verify the rule for previously completed and
   pending requests. Do not claim a restart tested preservation of history.

5. **Run both test suites and use `/speckit-converge` again.** Review any new
   tasks, fix genuine gaps, and rerun the affected checks. Reuse the optional
   Acceptance Evidence skill if it helped in Stage 4.

6. **Review the final diff.** Show the revised acceptance criterion and the
   test that proves it. Explain one decision the model could not make safely
   without clarification. Commit the updated specification with its code.

## Verification

- The existing specification and derived artifacts agree on the revised rule.
- Costs of 99,999, 100,000, and 100,001 cents produce the required approval
  counts.
- Two different eligible managers are required for a high-cost request.
- The first approval is visibly pending; repeated or forbidden approvals do
  not advance it.
- Completed decisions remain final, with fixture-based regression evidence.
- The application works through the UI, all tests pass, and no material
  convergence gap remains.

---

Previous: [Stage 4: Implement and Verify](stage-4-implementation.md)
