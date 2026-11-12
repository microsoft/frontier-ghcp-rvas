# Stage 3: Build enforceable guardrails

**Difficulty:** ⭐⭐⭐ | **Time:** 90-105 min

Enforce the standard in two places: checks that reject contract drift before
publication, and Azure API Management policies that apply runtime controls.

## Tasks

1. Copy `standards/draft-rules.json` to `standards/rules.json`. Change the
   values to match your approved standards. Extend
   `scripts/check-contracts.js` where your decisions need a rule the starter
   does not cover.
2. Add focused tests under `test/` for every contract rule you make blocking.
   Include a passing case and a failing case with a useful message.
3. Run the checks against your proposals:

   ```bash
   node scripts/check-contracts.js \
     --contracts-dir contracts/proposals \
     --rules standards/rules.json
   ```

4. Create policy files under `policies/platform/` for your approved inbound
   controls, version and deprecation behavior, error handling, and
   observability headers. Use Azure API Management policy syntax. Keep named
   values abstract and commit no credentials.
5. Define where Microsoft Entra ID token validation belongs and which claims
   the platform can check consistently. Keep product authorization decisions
   with service owners unless your standard explicitly assigns them to the
   platform.
6. Add tests or validation logic for the policy structure that matters to your
   design. At minimum, malformed XML and missing APIM policy sections must
   fail.
7. Run `npm run validate:policies`, `npm run validate:openapi`, and
   `npm test`. Optional: import the policies into a non-production Azure API
   Management instance after all local checks pass.

At the midpoint, refine your customizations. Tighten repository instructions
where they let ambiguous artifacts through. Add the failure modes you found to
the APIM Policy Reviewer. Make the Policy Validation skill run your approved
rules and policy paths, not only the starter checks.

## Verification

- The approved proposal directory passes the blocking contract checks
- Each blocking standard has automated coverage or a documented reason for
  manual review
- Invalid OpenAPI and malformed XML cause validation to fail
- APIM policy files contain all four policy sections in valid order
- Policies contain no secrets, keys, tokens, tenant IDs, or live backend URLs
- Identity, versioning, error, and correlation behavior matches the written
  standard
- Mock smoke tests still pass, and the source services remain unchanged

## What Copilot helps with vs. what requires your judgment

Copilot turns a precise rule into a parser check and explains APIM policy
syntax. You review false positives, policy execution order, failure behavior,
and the line between platform and service authorization.

---

Previous: [Stage 2: Set the Platform Standard](stage-2-set-platform-standard.md) | Next: [Stage 4: Package the Paved Road](stage-4-package-paved-road.md)
