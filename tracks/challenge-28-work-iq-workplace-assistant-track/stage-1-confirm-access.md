# Stage 1: Confirm Access and Set the Boundary

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

## Tasks

Use the Customization Trio from the start. Put the stable boundaries in
repository instructions, ask the Scope Guardian agent to review the scope, and
run the Scoped Workplace Retrieval skill before making a Work IQ request.

1. Complete
   `docs/preflight-checklist.md` with the participant, delivery lead, and
   tenant administrator where needed. Mark items owned outside the delivery
   team.
2. Select one project and a recent time range. Record the business question the
   handoff needs to answer, the sources in scope, the output location, and the
   reviewer.
3. Install the supported Work IQ plugin for GitHub Copilot CLI and complete
   Microsoft Entra authentication. Check that the Work IQ MCP server and its
   skills are available.
4. Issue a small read-only request against a source the participant is already
   allowed to access. Record whether the result and source references are
   enough for a reviewer to use.
5. Record access failures, consent prompts, policy blocks, or missing source
   access as blockers. Do not seek workarounds that bypass Microsoft 365
   permissions or tenant policy.

## Verification

- The preflight checklist shows that billing, consent, and participant access
  are ready, or clearly identifies the blocker owner
- The project boundary names a project, time range, approved sources, output
  audience, and reviewer
- GitHub Copilot CLI can discover the Work IQ MCP integration
- One read-only retrieval succeeds against data the participant is allowed to
  access
- No credentials, access tokens, or workplace content are committed to the
  repository

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can test availability and help organize the boundary. You decide if the
information belongs in the handoff and if the audience should receive it.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Retrieve Evidence and Map the Handoff](stage-2-retrieve-evidence.md)
