# Stage 2: Identity, Secrets, and Dependencies

**Difficulty:** ⭐⭐⭐ | **Time:** 70-85 min

Now prove the gaps that could change the release decision. The starter leaves
review leads in code, tests, configuration, and evidence files. Some are more
serious than others.

## Tasks

1. Review session creation and bearer-token handling. Check proof of identity,
   token lifetime assumptions, failure behavior, and log output.
2. Review all protected endpoints for role checks and resource ownership. Use
   small local requests or characterization tests as evidence.
3. Review payment inputs and returned data. Look at amount, currency, account,
   memo, identifiers, and error behavior.
4. Trace the payment provider setting from tracked configuration to runtime
   output. Do not introduce a real secret while testing.
5. Run:

   ```bash
   dotnet list SecureReleaseReview.sln package --vulnerable --include-transitive
   ```

   Confirm whether each reported package is used, direct or transitive, and
   reachable in this application.
6. Review `evidence/security-log-sample.jsonl` and the logging code for missing
   actor context, missing administrative events, and sensitive values.
7. Write `deliverables/prioritized-findings.md`. Give each finding evidence,
   impact, likelihood, confidence, and a release disposition.
8. Write `deliverables/dependency-and-secret-review.md` with commands, output
   summary, configuration flow, and recommended handling.

## Verification

- Findings cover authn, authz, input, configuration, dependency, and logging
- Every release blocker points to code, a request, a test, or command output
- Package findings distinguish advisory presence from actual application use
- Secret review uses only the synthetic starter value
- Priorities explain why one finding ranks above another

## What Copilot Helps With vs. What Requires Your Judgment

Copilot is good at locating route policies and tracing configuration reads. It
can also overstate scanner output. You own severity, reachability, confidence,
and the decision to block or accept a risk.

---

Previous: [Stage 1: Trust Boundaries and Threats](stage-1-trust-boundaries-and-threats.md) | Next: [Stage 3: Targeted Remediations and Security Tests](stage-3-remediations-and-tests.md)
