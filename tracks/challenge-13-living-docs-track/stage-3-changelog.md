# Stage 3: Changelog and Release Notes

**Duration:** 1-1.5 hours

**Focus:** Building skills that generate changelogs and stakeholder summaries from code diffs

## Tasks

1. **Update the existing changelog.** The `docs/CHANGELOG.md` stopped at v2.0. By reading the code, identify what was added in v2.3 (warehouse transfers, stock movements) and v2.5 (volume discounts, reorder reports). Write the missing changelog entries.

2. **Extend your changelog skill.** Use `.github/skills/changelog-reconciliation/SKILL.md` for the Changelog Reconciliation skill from setup. Alongside backfilling release history, it should accept a code diff (or a set of changed files) and produce a structured changelog entry. Define the expected output:
   - Group changes by category (Features, Bug Fixes, Breaking Changes, Deprecations)
   - Write in past tense ("Added", "Fixed", "Removed")
   - Include affected components (which controller, which endpoint)
   - Flag breaking changes prominently

3. **Build a stakeholder summary skill.** Create or refine `.github/skills/stakeholder-summary/SKILL.md` for a workflow that reviews the same diff and produces a non-technical summary. Use the Release Communicator agent to assess what matters to product owners and business stakeholders. The summary should:
   - Explain what changed in business terms (not technical terms)
   - Highlight user-facing impact
   - Call out anything that requires business communication (pricing changes, new limits)

4. **Test both skills.** Make a small code change (add a new endpoint or modify a business rule), then use both skills against the diff. Verify the changelog against the changed code and check that a non-developer can understand the stakeholder summary. Refine the relevant skill if either output misses an important change.

## Verification

- [ ] Missing changelog entries added for v2.3 and v2.5
- [ ] Changelog entry matches the test diff and identifies affected components
- [ ] Breaking changes and business communication needs are flagged when present
- [ ] Both workflows produce accurate output for a test diff
- [ ] Stakeholder summary is genuinely non-technical (no code references, no jargon)

---

Previous: [Stage 2: Architecture Diagrams](stage-2-diagrams.md) | Next: [Stage 4: PR Documentation Agent](stage-4-pr-agent.md)
