# Stage 4: Decision Making Under Constraints

[Back to Challenge 0: Product Planning Track](../challenge-0-product-planning-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

Real product work involves trade-offs, conflicting priorities, and imperfect information. This stage introduces all three.

## Tasks

1. **Write 3 ADRs** -- Copy [docs/adr/0002-template.md](../../challenges/challenge-0-product-planning/docs/adr/0002-template.md) for each. Your ADRs must address real architectural and product decisions:
   - **ADR: Notification delivery mechanism** -- Compare WebSocket, Server-Sent Events, polling, and push notifications. Analyze each on latency, infrastructure cost, battery impact (mobile), implementation complexity, and offline behavior. Pick one and justify.
   - **ADR: Multi-tenancy strategy** -- Compare shared database, database-per-tenant, and schema-per-tenant. Analyze on data isolation, cost per tenant, migration complexity, query performance, and compliance (GDPR data separation). Pick one and justify.
   - **ADR: One additional decision** that emerged from your feature specs (e.g., real-time collaboration protocol, search engine choice, file storage strategy).

2. **Stakeholder conflict resolution** -- Open [docs/stakeholder-requests.md](../../challenges/challenge-0-product-planning/docs/stakeholder-requests.md). It contains 4 conflicting requests from different stakeholders (VP Engineering, CEO, Head of Support, Lead Designer), each with a cost in engineering weeks. The total budget for v2.0 is 16 engineering weeks. The requests total 28 weeks. You must decide what gets funded and what gets cut or deferred. Write a one-page decision document explaining your allocation, what trade-offs you made, and how you would communicate the "no" to each stakeholder whose request was cut.

3. **Buy-vs-build analysis** -- Pick one component from your feature specs that could be built in-house or replaced by a third-party service (e.g., notification delivery via SendGrid/Twilio vs. custom SMTP, search via Algolia vs. Elasticsearch, file storage via S3 vs. custom). Create a comparison table with: estimated build cost (weeks), monthly operating cost, vendor lock-in risk, customization flexibility, time-to-market, and ongoing maintenance burden. Make a recommendation with reasoning.

## Verification

- 3 ADRs exist with at least 3 options each, trade-off analysis across multiple dimensions, and a justified decision
- Stakeholder allocation document exists and accounts for exactly 16 weeks (within 1 week tolerance)
- Buy-vs-build analysis includes a comparison table with at least 5 dimensions and a written recommendation
- All "no" decisions include a communication strategy

## What Copilot Helps With vs. What Requires Your Judgment

Copilot generates thorough pro/con lists for ADRs and can suggest cost comparisons for buy-vs-build. But deciding which stakeholder request to cut (and writing a diplomatic but honest explanation), choosing a multi-tenancy model that fits TaskFlow's specific situation, and making a buy-vs-build call with imperfect cost data are decisions that require product and business judgment.

---

Previous: [Stage 3: Feature Specification and Technical Alignment](stage-3-feature-specs.md) | Next: [Stage 5: Release Planning and Go-to-Market](stage-5-release-planning.md)
