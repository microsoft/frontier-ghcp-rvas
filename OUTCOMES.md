# Outcome Taxonomy

This document defines the outcome categories for the hackathon and maps every
challenge to one or more outcomes. These are **work/business outcomes** -- a
shipped deliverable or measurable capability improvement -- not learning
objectives. The `TRACK_STRUCTURE.md` prohibition on "Learning Outcomes" sections
in track files remains in effect; this taxonomy lives in metadata and framing
only.

## Outcome Categories

### modernize-legacy

**Name:** Modernize Legacy Systems

**Description:** Reverse-engineer, characterize, and migrate legacy or
undocumented codebases to modern platforms using AI-assisted comprehension.

**Definition of done:** Legacy code has characterization tests, recovered
business-logic documentation, and a working replacement service on a modern
runtime. The old system can be retired or wrapped.

---

### ship-features

**Name:** Ship Product Features Faster

**Description:** Move from requirements or specifications to working, demoable
software -- covering planning, implementation, and integration across the stack.

**Definition of done:** A functional feature (API endpoint, UI component, or
full-stack flow) is running, tested, and demoable to stakeholders. The
requirement-to-delivery cycle time is measurably compressed.

---

### raise-quality

**Name:** Raise Quality and Confidence

**Description:** Improve test coverage, accessibility, documentation accuracy,
or reliability of an existing system through systematic quality engineering.

**Definition of done:** Measurable quality artifacts are produced -- test suites,
accessibility audit results, generated documentation, or reliability metrics --
and integrated into the development workflow.

---

### automate-delivery

**Name:** Automate Delivery and Ops Toil

**Description:** Replace manual, repetitive delivery or operations work with
repeatable automated pipelines, scripts, or AI-assisted tooling.

**Definition of done:** A previously manual process (build, deploy, incident
triage, documentation generation, or system administration) runs automatically
or with a single trigger. Manual steps are documented and eliminated.

---

### platform-foundation

**Name:** Stand Up Cloud Platform Foundations

**Description:** Provision and harden Azure infrastructure baselines with
proper state management, identity, networking, and policy guardrails.

**Definition of done:** Azure resources are provisioned via Infrastructure as
Code, state is managed remotely, identity and access are configured, and CI
validates plans before apply. The platform is ready to host workloads.

---

### build-ai

**Name:** Build AI-Powered Capabilities

**Description:** Develop and ship machine learning models, intelligent agents,
or AI-driven features integrated into a production-ready application.

**Definition of done:** An AI capability (trained model, agent, or intelligent
workflow) is functional, produces verifiable outputs, and is integrated into an
application or automation pipeline.

## Challenge-to-Outcome Mapping

Every challenge maps to at least one outcome. Multi-valued mappings indicate
the challenge produces deliverables in multiple categories.

| Challenge | Title | Outcomes |
|-----------|-------|----------|
| challenge-0 | Product Planning | `ship-features` |
| challenge-1 | Web API | `ship-features`, `raise-quality` |
| challenge-2 | ML & AI | `build-ai` |
| challenge-3 | DevOps | `automate-delivery`, `platform-foundation` |
| challenge-4 | Frontend | `ship-features`, `raise-quality` |
| challenge-5 | QA & Testing | `raise-quality` |
| challenge-6 | Agentic Workflows | `automate-delivery`, `build-ai` |
| challenge-7 | Copilot SDK Developer | `build-ai` |
| challenge-8 | Full-Stack Flight Delay Predictor | `ship-features`, `build-ai` |
| challenge-9 | Cross-Functional Team Sprint | `ship-features` |
| challenge-10 | Technical Team Sprint | `ship-features` |
| challenge-11 | Legacy MUMPS Modernization | `modernize-legacy` |
| challenge-12 | Legacy Code Modernization | `modernize-legacy` |
| challenge-13 | Living Documentation | `raise-quality`, `automate-delivery` |
| challenge-14 | Pipeline Factory | `automate-delivery` |
| challenge-15 | Backlog Generator | `ship-features`, `automate-delivery` |
| challenge-16 | Ops Assistant | `automate-delivery` |
| challenge-17 | Spec-to-Ship Accelerator | `ship-features`, `automate-delivery` |
| challenge-18 | Legacy COBOL Banking Modernization | `modernize-legacy` |
| challenge-19 | Legacy WCF Banking Modernization | `modernize-legacy` |
| challenge-20 | PowerShell Automation | `automate-delivery`, `modernize-legacy` |
| challenge-21 | Azure Terraform | `platform-foundation` |

### Coverage Verification

- **modernize-legacy** (5 challenges): 11, 12, 18, 19, 20
- **ship-features** (8 challenges): 0, 1, 4, 8, 9, 10, 15, 17
- **raise-quality** (4 challenges): 1, 4, 5, 13
- **automate-delivery** (8 challenges): 3, 6, 13, 14, 15, 16, 17, 20
- **platform-foundation** (2 challenges): 3, 21
- **build-ai** (4 challenges): 2, 6, 7, 8

All 22 challenges are mapped. Every outcome has at least two challenges.

### Classification Notes

- **Challenge 20 (PowerShell Automation)** maps to both `automate-delivery` and
  `modernize-legacy`. The scripting work automates ops toil, but PowerShell
  modernization of legacy admin processes also fits the modernization outcome.
- **Challenge 3 (DevOps)** spans delivery automation (CI/CD pipelines) and
  platform foundations (Terraform, containers). Both outcomes apply.
- **Challenge 15 (Backlog Generator)** ships a feature (the generator itself)
  while also automating the delivery pipeline from spec to backlog. Both apply.

## Data-Model Contract

This section specifies the exact implementation contract for the website and
metadata. The existing `category` field and the 5-category color scheme are
**preserved unchanged**. The new `outcomes` facet is additive and non-breaking.

### Relationship: category vs outcomes

| Facet | Purpose | Cardinality | Values |
|-------|---------|-------------|--------|
| `category` | Visual color grouping on the site | Single-valued (one per challenge) | `core-tracks`, `team-sprints`, `legacy-modernization`, `workflow-automation`, `azure-platform` |
| `outcomes` | Business-outcome classification | Multi-valued (list) | `modernize-legacy`, `ship-features`, `raise-quality`, `automate-delivery`, `platform-foundation`, `build-ai` |

These are independent dimensions. A challenge's `category` controls its color
badge; its `outcomes` list describes what work result it produces. They may
overlap conceptually (e.g. `legacy-modernization` category challenges are likely
`modernize-legacy` outcome) but are not derived from each other.

### meta.yml schema addition

Each `challenges/*/meta.yml` gains one new field:

```yaml
outcomes:
  - ship-features
  - raise-quality
```

The field is a YAML list of one or more outcome IDs from the set above.
Validation: every entry must be a key in `OUTCOME_CONFIG`.

### web/build.js addition

Add an `OUTCOME_CONFIG` constant with the canonical outcome definitions:

```javascript
const OUTCOME_CONFIG = {
  'modernize-legacy': {
    name: 'Modernize Legacy Systems',
    description: 'Reverse-engineer, characterize, and migrate legacy codebases to modern platforms.'
  },
  'ship-features': {
    name: 'Ship Product Features Faster',
    description: 'Move from requirements to working, demoable software across the stack.'
  },
  'raise-quality': {
    name: 'Raise Quality and Confidence',
    description: 'Improve test coverage, accessibility, documentation, or reliability.'
  },
  'automate-delivery': {
    name: 'Automate Delivery and Ops Toil',
    description: 'Replace manual delivery or operations work with automated pipelines and tooling.'
  },
  'platform-foundation': {
    name: 'Stand Up Cloud Platform Foundations',
    description: 'Provision and harden Azure infrastructure with IaC, identity, and policy guardrails.'
  },
  'build-ai': {
    name: 'Build AI-Powered Capabilities',
    description: 'Develop and ship ML models, agents, or AI-driven features into production.'
  }
};
```

Build-time validation: every `meta.yml` `outcomes[]` entry must be a key in
`OUTCOME_CONFIG`. Fail the build if an unknown outcome ID appears.

### platform.json emission

Each challenge object in the generated `platform.json` includes:

```json
{
  "outcomes": ["ship-features", "raise-quality"]
}
```

The top-level `platform.json` gains an `outcomeConfig` key containing the full
`OUTCOME_CONFIG` map so the frontend can render labels without hardcoding.
