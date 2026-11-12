# Challenge 21 track: Azure Terraform

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Build and review an Azure Terraform baseline with remote state, reusable modules, identity controls, policy checks, and CI gates

## Prerequisites

- An Azure subscription with permission to create resource groups, storage accounts, networking resources, managed identities, and Key Vault
- Basic familiarity with Terraform workflows (`init`, `fmt`, `validate`, `plan`, `apply`)
- Comfort reading HCL and Azure resource relationships
- Basic GitHub Actions knowledge for the CI stage
- Azure CLI, installed and authenticated, to run plans against a real subscription

> ⚠️ **No Azure subscription?** You can still do most of the track with `terraform fmt`, `terraform validate`, module structure, variable design, and pipeline generation. Treat the live `plan` and `apply` steps as design exercises.

## Technology stack

- **Terraform** -- Infrastructure as Code
- **AzureRM provider** -- Azure resource provisioning
- **Azure Storage** -- remote state backend
- **Azure Container Apps** -- application hosting target
- **Azure Key Vault and Managed Identity** -- secrets and identity
- **GitHub Actions** -- validation and deployment workflow

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Go to `challenges/challenge-21-azure-terraform/`. The challenge is a small internal operations app that needs a clean Azure foundation before it rolls out to multiple regions. Work in `terraform/azure/`, `modules/`, and `docs/`, not the application code.

Use the devcontainer at `.devcontainer/challenge-21-azure-terraform/`. It keeps the Terraform, Azure CLI, and validation tooling separate from the other tracks.

The starter includes constrained Terraform inputs, TFLint configuration, a pull request validation workflow, and evidence under `docs/`. Read them before writing instructions. They are deliberately incomplete: you decide what the team accepts, blocks, or documents.

#### Working scenario

You are taking over infrastructure for an internal operations app. It is not mission-critical yet, but it handles operational data the team does not want exposed. Three stakeholders left you requirements that don't line up:

- The platform lead wants one Terraform pattern that can support dev and prod without a separate rewrite later.
- The application team wants a fast path to a working dev environment and does not want a heavy approval process for every small change.
- Security wants private networking where practical, narrow identity permissions, no secrets in source control, and a clear drift response before production rollout.

Build the smallest responsible Azure baseline and explain the trade-offs. Don't build a full enterprise landing zone, and don't accept generated HCL until you can explain the plan it produces.

#### Required participant artifacts

Create these files under `challenges/challenge-21-azure-terraform/docs/` as you work:

- `platform-notes.md` -- state bootstrap order, naming rules, tags, and open assumptions
- `plan-review.md` -- plan review notes for at least two stages, including one risk you rejected
- `identity-review.md` -- managed identity and Key Vault access decisions
- `environment-promotion.md` -- dev-to-prod differences and approval rules
- `drift-response.md` -- incident steps for drift, failed apply, import, and rollback decisions

Keep the notes short. A reviewer should see why you made each decision without reading every Terraform file.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Your Azure subscription, tenant, and preferred deployment regions
- Naming conventions for resource groups, storage, identities, and tags
- Whether your team prefers system-assigned or user-assigned managed identities by default
- Terraform version and provider pinning rules
- Promotion rules between dev and prod, including who approves applies
- Non-negotiable: no secrets in source control, and no `apply` without a reviewed plan

### Suggested custom agents

- **Terraform Reviewer Agent** -- Reviews module shape, variable hygiene, and plan readability. Give it a module or plan; it returns findings, not a rewrite. Use it before any apply.
- **Azure Identity Agent** -- Checks managed identity, RBAC, and Key Vault access design against least privilege. Give it the identity and access configuration; it flags overly broad grants. Use it when designing or reviewing identity changes.
- **CI Guardrail Agent** -- Reviews GitHub Actions, policy checks, and drift handling for the pipeline. Give it a workflow file; it flags missing gates. Use it when the pipeline itself changes.

### Suggested custom skills

- **Plan Review Skill** -- A fixed sequence: run `terraform plan`, read the diff before accepting it, flag any replacement or destroy operation, and record the decision in `plan-review.md`.
- **Module Variable Audit Skill** -- A repeatable pass over a module's variables checking each has a description, type, validation, and a sensible default before the module gets reused elsewhere.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "terraform review agent", "azure identity skill", and "CI guardrail instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Use Copilot as a reviewer before you use it as a generator. Ask it to compare two designs, find plan risks, and challenge your assumptions.
- Start each Terraform file with a short comment on the resources, naming rules, and environment assumptions. Copilot does better when the intent is explicit.
- Ask Copilot to explain a `terraform plan` diff, then check for accidental replacements and missing dependencies.
- Check generated variables for descriptions, validation, and sensible defaults.
- Have Copilot review modules for implicit dependencies and unnecessary outputs.
- For GitHub Actions, say which steps block merges and which are advisory. Otherwise Copilot treats every check the same.
- If a generated resource looks plausible but unfamiliar, ask which Azure API or provider schema it relies on. That often exposes outdated suggestions.
- Before applying, record one generated suggestion you rejected and why.

## Resources

- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-21-azure-terraform-track/stages.md)
