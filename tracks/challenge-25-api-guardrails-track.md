# Challenge 25 Track: Enterprise API Guardrails

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Governing API contracts across teams with standards, Azure API
Management policies, automated checks, observability, and onboarding

## Who Is This For

- API platform engineers who review contracts from several product teams
- Platform engineers who operate Azure API Management
- Technical leads defining API lifecycle and consumer expectations
- Developer experience engineers building a paved road for API publishers

## Prerequisites

- Comfort reading OpenAPI 3 contracts and HTTP API behavior
- Basic Node.js and command-line experience
- Familiarity with identity, versioning, and API lifecycle concepts
- Basic Azure API Management policy knowledge is useful but not required

An Azure subscription is optional. The required work runs locally. If you have
an Azure API Management instance, you can test deployment after the local
artifacts pass.

## Technology Stack

- **OpenAPI 3.0** for source contracts and normalized proposals
- **Node.js** for mock services, smoke tests, and contract checks
- **XML** for Azure API Management policy artifacts
- **Microsoft Entra ID** for identity standards
- **Azure API Management** for the optional deployment path
- **Azure Monitor and Application Insights** for observability requirements

This challenge starts where an application API challenge stops. You will not
rebuild handlers or domain logic. The product teams keep ownership of their
services. You own the standards, review evidence, runtime controls, and
developer path used before those services enter the shared platform.

## Getting Started

Follow the [common setup steps](getting-started.md) first, then continue below.

### Open and Inspect the Challenge

Open
[`challenges/challenge-25-api-guardrails/`](../challenges/challenge-25-api-guardrails/).
Start with `evidence/`, then compare the three contracts in `contracts/source/`
with the running mocks.

From the challenge directory:

```bash
npm install
npm test
npm run check:contracts:baseline
```

The first command installs local parsers. The test command validates OpenAPI
and XML, then exercises all three mocks. The baseline contract check reports
known conflicts without failing. Those findings are evidence, not the answer.

Use `.devcontainer/challenge-25-api-guardrails/` if you want the repository to
install Node.js and the editor extensions for you.

### Repository Instructions for This Track

Your repository instructions should capture stable facts that apply throughout
the work:

- The platform-team boundary and the rule that service implementation stays
  unchanged
- The approved locations for source contracts, proposals, policies, evidence,
  and onboarding material
- The local commands that must pass before review
- The requirement to use Azure services and Microsoft Entra ID
- The ban on credentials, tokens, real tenant data, and subscription keys in
  examples
- How standards, exceptions, and compatibility decisions should be recorded

Do not turn the instructions into the API standards document. They should
guide the session, while the standards remain a reviewed participant
deliverable.

### Suggested Custom Agents

- **API Governance Reviewer** -- Reviews a contract or change proposal against
  the standards and consumer risks you provide. Use it during inventory and
  proposal review. Keep it focused on findings and trade-offs, not service
  implementation.
- **API Lifecycle Reviewer** -- Examines a versioning or deprecation decision,
  its consumer evidence, and its migration window. Use it before approving a
  breaking change. It should not invent organizational policy.
- **APIM Policy Reviewer** -- Reviews local Azure API Management XML for policy
  order, failure behavior, identity boundaries, and accidental data exposure.
  Use it before optional deployment. It must not request or emit credentials.

### Suggested Custom Skills

- **Contract Comparison Skill** -- Takes a set of OpenAPI files and produces a
  repeatable difference inventory across naming, pagination, errors,
  versioning, identity, and observability. Use it before drafting standards.
- **API Change Classification Skill** -- Applies your compatibility rules to a
  contract diff, records the classification, and lists required consumer
  actions. Use it for every normalized proposal.
- **Policy Validation Skill** -- Runs XML parsing, checks required APIM policy
  sections, executes local contract checks, and records the result. Use it
  before each policy review.

These briefs describe purpose and boundaries. Write the actual customization
artifacts yourself after inspecting the starter.

## Tips for Using Copilot on This Track

- Ask for a comparison table before asking for recommendations. Mixing facts
  and policy too early hides the real conflicts.
- Give Copilot the consumer notes alongside the contracts. A naming difference
  matters because clients pay for it, not because one style is fashionable.
- Make breaking-change classifications explain which consumer behavior fails.
- Ask Copilot to challenge policy ordering and error paths in APIM XML.
- Keep generated identity examples abstract until your team has approved the
  Microsoft Entra ID audience, scopes, and claims model.
- Treat a passing parser as the floor. Review policy intent and contract
  semantics separately.
- Keep exceptions visible. A standard with no exception process usually turns
  into an undocumented exception process.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Azure API Management policy reference](https://learn.microsoft.com/azure/api-management/api-management-policies)
- [Azure API Management policy expressions](https://learn.microsoft.com/azure/api-management/api-management-policy-expressions)
- [OpenAPI Specification](https://spec.openapis.org/oas/latest.html)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-25-api-guardrails-track/stages.md)
