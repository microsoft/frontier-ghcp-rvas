# Phase 3: Changelog and Release Notes

[Back to Living Documentation Track](../bonus-living-docs-track.md)

**Duration:** 1-1.5 hours

**Focus:** Building a prompt that generates changelogs and stakeholder summaries from code diffs

## Tasks

1. **Update the existing changelog.** The `docs/CHANGELOG.md` stopped at v2.0. By reading the code, identify what was added in v2.3 (warehouse transfers, stock movements) and v2.5 (volume discounts, reorder reports). Write the missing changelog entries.

2. **Build a changelog prompt.** Create `.github/prompts/generate-changelog.prompt.md` that takes a code diff (or a set of changed files) and produces a structured changelog entry. The prompt should:
   - Group changes by category (Features, Bug Fixes, Breaking Changes, Deprecations)
   - Write in past tense ("Added", "Fixed", "Removed")
   - Include affected components (which controller, which endpoint)
   - Flag breaking changes prominently

3. **Build a stakeholder summary prompt.** Create `.github/prompts/stakeholder-summary.prompt.md` that takes the same diff and produces a non-technical summary. This is for product owners and business stakeholders who do not read code. The prompt should:
   - Explain what changed in business terms (not technical terms)
   - Highlight user-facing impact
   - Call out anything that requires business communication (pricing changes, new limits)

4. **Test both prompts.** Make a small code change (add a new endpoint or modify a business rule), then run both prompts against the diff. Verify the changelog is accurate and the stakeholder summary is understandable by a non-developer.

## Verification

- [ ] Missing changelog entries added for v2.3 and v2.5
- [ ] Changelog generation prompt created and tested
- [ ] Stakeholder summary prompt created and tested
- [ ] Both prompts produce accurate output for a test diff
- [ ] Stakeholder summary is genuinely non-technical (no code references, no jargon)

---

Previous: [Phase 2: Architecture Diagrams](phase-2-diagrams.md) | Next: [Phase 4: PR Documentation Agent](phase-4-pr-agent.md)
