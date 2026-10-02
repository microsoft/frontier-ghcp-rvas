# Stage 2: Characterization Testing

**Duration:** 60 minutes
**Focus:** Capture transfer behavior before translation

## Tasks

1. Create the target-language project in `typescript/` or `java/` and set up
   its test framework. Keep the original COBOL source unchanged.
2. Derive expected outcomes from the source-linked trace. When GnuCOBOL runs,
   compare the original with the target using the same synthetic inputs.
   Label source-derived expectations separately from executed comparisons.
3. Characterize valid transfer, same-account rejection, ineligible accounts,
   nonpositive amount, transfer-limit boundaries, and insufficient funds.
   Check the behavior of both source and destination account types.
4. Check resulting balances and transaction records, including currency
   precision. For each rejected case, inspect whether balances or logs changed
   rather than asserting only an error message.
5. Reuse the Behavior Parity Check skill on the successful and rejected paths.
   If the Modernization agent misses a rule, refine it with the actual source
   and failing case before generating another implementation.

**Do not call target-only tests proof of parity.** Preserve original quirks
unless you explicitly agree to fix one and record the changed expectation.
Use `fixtures/transfer-ui-cases.json` as a list of presentation states, not
as the authority for banking rules.

## Verification

- Tests cover successful transfer and the required rejection cases
- Expected outcomes cite the original code or an observed COBOL run
- Tests inspect balances and transaction evidence, with the original precision
- The working note distinguishes executed parity checks from source-derived
  expectations

## Stretch Tasks

Characterize utilities, customer validation, interest and loan calculations,
batch behavior, and authentication. These are outside the transfer-only core.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can draft test tables and scaffolding. You must check that the expected
result comes from the original program rather than the generated replacement.
That distinction matters before Stage 4 uses these tests as its safety net.

---

Previous: [Stage 1: Code Archaeology](stage-1-archaeology.md) | Next: [Stage 3: Feature Evolution (Optional)](stage-3-evolution.md)
