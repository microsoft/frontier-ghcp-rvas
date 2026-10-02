# Stage 1: Code Archaeology

**Duration:** 45 minutes
**Focus:** Trace one transfer workflow before changing its implementation

## Tasks

Keep your repository instructions open for the target stack and COBOL
conventions. Use the COBOL Archaeologist agent where the transfer logic is
unclear, and run your business-rule documentation skill as you trace it.

1. Get oriented in the COBOL divisions, paragraphs, and copybook fields used
   by `programs/BNKTXN.cbl`. Trace `PROCESS-TRANSFER` and the paragraphs it calls.
2. Identify the account and transaction record layouts. Record balance
   precision, account status/type checks, and the fields changed by a transfer.
3. Follow successful transfer and rejected-input paths from prompts to file
   writes. Check same-account handling, account eligibility, amount limits,
   and insufficient funds against the source.
4. Compare actual file operations with comments about locking. Distinguish
   implemented behavior from claims in comments; do not assume atomicity.
5. Keep one short source-linked note for the transfer workflow. List observed
   outputs and uncertainties that Stage 2 must check. Preserve the COBOL files.

## Verification

- The note identifies the transfer entry point, relevant record layouts, and
  called paragraphs
- Each claimed rule has a source reference
- Successful and rejected paths are traced through their observable effects
- Open questions distinguish suspected defects from behavior to preserve

## Stretch Tasks

Map every program and ISAM file, trace deposit and end-of-day batch workflows,
and build a broader technical-debt inventory. Keep this outside the core.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can explain paragraphs and propose a workflow map. You decide whether
the explanation matches the actual file operations. A plausible summary is
not evidence that a transfer is safe or atomic.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Characterization Testing](stage-2-testing.md)
