# Challenge 23 Track: Merger Integration Architecture

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Turning conflicting merger evidence into defensible system boundaries, integration contracts, Azure architecture decisions, and a sequenced transition plan

## Who Is This For

- Solution and enterprise architects working across organizational boundaries
- Senior engineers moving from implementation decisions into architecture ownership
- Integration, identity, data, and platform leads
- Technical program leads who need architecture decisions tied to delivery waves

## Prerequisites

- Comfort reading API or event contracts
- Familiarity with context and container diagrams
- Basic knowledge of distributed systems failure modes
- Working knowledge of Azure integration, identity, data, and observability services
- No Azure subscription or application implementation experience is required

## Technology and Artifacts

This challenge is local-first and architecture-first. You will work with:

- Markdown and CSV evidence
- Mermaid diagram source
- OpenAPI and AsyncAPI evidence
- Architecture Decision Records
- A structured YAML integration contract
- Azure service choices described in diagrams and decisions
- Python validation scripts that run without an Azure account

You will not deploy resources or build an integration service. The hard part is deciding where responsibilities belong, what each system may assume, and how the combined company can move without a big-bang cutover.

## Getting Started

Follow the [common setup steps](getting-started.md) first.

### Open and Inspect the Challenge

Open [`challenges/challenge-23-merger-architecture/`](../challenges/challenge-23-merger-architecture/) in its dedicated devcontainer at `.devcontainer/challenge-23-merger-architecture/`.

Run the starter validation before changing anything:

```bash
cd challenges/challenge-23-merger-architecture
./scripts/validate.sh --starter
```

The check covers evidence files, CSV columns, contract shape, and Mermaid source. It does not judge the architecture.

### Repository Instructions for This Track

Your repository instructions should tell Copilot that this is a merger architecture exercise, not an implementation task. Capture the two organizations, the required deliverables, Azure-only constraint, evidence-first decision rule, diagram and ADR conventions, and the need to preserve identity and data authority boundaries.

Use the instructions from the first evidence pass onward. Refine them after Stage 2 if Copilot collapses unlike capabilities, treats target state as immediate, or recommends services without tying them to an NFR.

### Suggested Custom Agents

- **Boundary Analyst Agent** -- Challenges capability ownership and system boundaries. Give it a capability map or ownership conflict; it returns ambiguous authority, accidental coupling, and places where one shared model would erase a business distinction. Use it in Stages 1 and 2, not as a system inventory generator.
- **Contract Reviewer Agent** -- Reviews one integration contract against failure evidence, volumes, SLOs, privacy rules, and ownership. Give it the draft contract and supporting evidence; it returns gaps and contradictions without rewriting the contract. Use it in Stage 3.

### Suggested Custom Skills

- **Transition Risk Skill** -- Checks each migration wave for entry criteria, exit measures, rollback, dual-running risk, data reconciliation, and accountable ownership. Run it on every roadmap revision in Stage 4.
- **ADR Consistency Skill** -- Compares a proposed ADR with the capability map, diagrams, integration contract, and earlier decisions. It flags conflicting ownership, assumptions, or transition states before the ADR is accepted. Run it as each Stage 3 decision is drafted.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms such as "solution architect agent", "ADR review skill", and "Azure architecture instructions" before drafting your own.

## Scenario

Harbor & Pine Commerce and Northstar Market Network have merged. One is a retailer built around synchronous APIs and shared reporting data. The other is a marketplace built around events, separate identity types, and immutable analytical history.

Both companies have customer, order, identity, refund, and reporting capabilities. The names overlap. The responsibilities do not.

The board wants one customer experience within nine months and a useful first release in 90 days. Finance needs a reconciled combined close. Security will not accept a merged authorization boundary for retail support and seller administration. Neither organization can stop normal delivery while the architecture is rebuilt.

## Evidence Pack

Read the evidence in this order:

1. `evidence/merger-brief.md`
2. `evidence/system-inventory.csv`
3. `evidence/capability-overlap.csv`
4. `evidence/ownership-conflicts.csv`
5. `evidence/stakeholder-priorities.md`
6. `evidence/nfr-and-compliance.md`
7. `evidence/volumes-and-slos.csv`
8. `evidence/integration-failure-evidence.md`
9. `evidence/contracts/`

The files disagree in places. That is intentional. An architect has to make uncertainty visible instead of smoothing it away.

## Required Deliverables

Create a `deliverables/` directory from the provided templates. Your final pack must contain:

```text
deliverables/
├── capability-boundary-map.md
├── architecture-context.mmd
├── architecture-containers.mmd
├── integration-contract.yaml
├── migration-roadmap.md
└── adrs/
    ├── ADR-0001-short-title.md
    ├── ADR-0002-short-title.md
    └── ADR-0003-short-title.md
```

You may add a fourth ADR. Keep each ADR short enough to review in one sitting. The decisions should cover the architecture's few consequential choices rather than documenting every Azure service.

Your diagrams must show the Azure target, retained source systems, identity or trust boundaries, data movement, and operational visibility. They must also show at least one transition state. A clean target-only picture is not enough.

## Working Principles

- Start from capabilities and authority, not Azure icons.
- Treat identity linking and authorization as separate concerns.
- Compare integration patterns against the same criteria.
- Keep source-system facts distinct from target decisions.
- Show degraded and partial-result behavior in contracts.
- Tie every migration wave to a business outcome and rollback condition.
- Record assumptions where the evidence does not support certainty.
- Use Copilot to challenge and compare. You remain responsible for the decisions.

## Validation

Run the final checks from the challenge directory:

```bash
./scripts/validate.sh
```

The script checks the expected artifact structure, Mermaid source, ADR count and consistency, required contract fields, roadmap sections, and unresolved placeholders. Passing it means the pack is reviewable. It does not mean the architecture is sound.

## Resources

- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)
- [Azure integration services](https://learn.microsoft.com/azure/architecture/integration/integration-services-overview)
- [Azure API Management](https://learn.microsoft.com/azure/api-management/)
- [Azure Service Bus](https://learn.microsoft.com/azure/service-bus-messaging/)
- [Microsoft Entra architecture](https://learn.microsoft.com/entra/architecture/architecture)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)

---

Next: [Stages](challenge-23-merger-architecture-track/stages.md)
