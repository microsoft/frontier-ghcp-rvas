# Phase 4: PR Documentation Agent

[Back to Living Documentation Track](../bonus-living-docs-track.md)

**Duration:** 2-3 hours

**Focus:** Building a Copilot agent that reviews code changes for documentation completeness

## Tasks

1. **Define documentation completeness criteria.** Before building the agent, decide what "complete documentation" means for your team. At minimum:
   - Every public class has a class-level javadoc
   - Every public method has a method-level javadoc with parameter and return descriptions
   - Any new or changed REST endpoint is reflected in the API documentation
   - Business rule changes are documented in the relevant javadoc or a rules document
   - The changelog has an entry for the change

2. **Create the documentation review agent.** Create `.github/agents/doc-reviewer.agent.md` that:
   - Accepts a set of changed files (pointed to via `#file` references)
   - Checks each changed file against the documentation completeness criteria
   - Produces a checklist of what is documented and what is missing
   - Suggests specific javadoc or documentation text for missing items

3. **Test the agent on a simulated PR.** Make a code change that adds a new endpoint or modifies a business rule. Point the agent at the changed files and verify it correctly identifies the missing documentation.

4. **Test the agent on a documentation-complete change.** Make a change where you also update the javadoc, changelog, and any other relevant docs. Run the agent and verify it reports everything as complete.

5. **Refine and iterate.** If the agent produces false positives (flagging things that do not need documentation) or false negatives (missing documentation gaps), adjust the agent's instructions until it is reliable.

## Verification

- [ ] Documentation completeness criteria defined
- [ ] Doc reviewer agent created (`.github/agents/doc-reviewer.agent.md`)
- [ ] Agent correctly identifies missing documentation on an undocumented change
- [ ] Agent correctly reports completeness on a well-documented change
- [ ] Agent refined based on at least one round of false positive/negative correction

---

Previous: [Phase 3: Changelog and Release Notes](phase-3-changelog.md)
