# Stage 4: Full-stack modernization

**Duration:** 165 minutes, including a 15--25 minute UI review
**Focus:** One local account-transfer API and React journey

## Tasks

Use the Modernization agent for the target design and the Behavior Parity
Check skill after each transfer-rule change. Impeccable is already installed
through the shared setup; do not add the former frontend-design skill.

1. Define a small API contract for account selection and transfer submission.
   Choose local storage and a module structure that fit the target language.
   Keep the original account eligibility and amount rules.
2. Implement the transfer path and necessary data access. Reuse the Stage 2
   tests. Keep observed COBOL behavior and suspected defects separate; do not
   silently fix a quirk while translating it.
3. Build a React view for source/destination selection and amount entry. Show
   validation errors without losing input. Display resulting balances and
   transaction evidence only after the backend reports success.
4. Walk through `fixtures/transfer-ui-cases.json` with synthetic test data.
   Include rejected input and a failed request. A failed backend operation
   must not produce a successful-transfer message.
5. **Review one teller journey with Impeccable's `critique`.** Focus on readable
   account selection and confirmation, including a narrow viewport and
   keyboard use. Fix one concrete finding and capture the same state before
   and after. Preserve the API contract and characterized rules.
6. Rerun affected tests and the browser journey. Record the review decision
   and parity evidence in the existing pull request or working note. State
   which comparisons ran against COBOL and which rely on source inspection.

The demo is local, uses synthetic records, and needs no Azure subscription.
Real authentication and full-system migration are outside the core. Do not
present a one-workflow demo as a production banking replacement.

## Verification

- The transfer API and React view work together
- Characterization checks cover successful and rejected transfers
- Balances and transaction evidence match the agreed original behavior
- Validation and failed requests preserve entered values without false success
- One UI review has before-and-after evidence and a documented decision
- Keyboard use works and the UI change preserves the characterized rules

## Stretch tasks

Add account management or customer search, then translate other workflows
with their own characterization tests. Login, loan screens, reports, and an
admin panel are optional. Scope any technical-debt fix separately and update
its tests before changing the original expectation.

## What Copilot helps with vs. what requires your judgment

Copilot can scaffold API and React code. Impeccable can identify confusing
feedback. You decide whether the result preserves the original behavior and
whether the evidence justifies a successful-transfer message.

---

Previous: [Stage 3: Feature Evolution (Optional)](stage-3-evolution.md)
