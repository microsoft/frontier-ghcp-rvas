# Challenge 3 Track: DevOps

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Infrastructure as Code, containerization, and deployment automation with GitHub Copilot

## Who is this for

- DevOps Engineers and Platform Engineers
- Site Reliability Engineers (SRE)
- Cloud Engineers
- Infrastructure Architects

## Prerequisites

- **Azure subscription** for Terraform provisioning, Key Vault, and CI/CD deployment in Stages 3-5
- **Azure Kubernetes Service (AKS)** access or ability to create one (Stage 3 provisions it, Stages 4-5 use it)
- Basic understanding of Azure cloud platform
- Familiarity with Docker containers
- Understanding of infrastructure concepts
- Basic knowledge of YAML and HCL (Terraform)
- CI/CD concepts

> ⚠️ **No Azure subscription?** Stages 1 (Docker) and 2 (Kubernetes with a local cluster like minikube or kind) can be completed without Azure. For Stages 3-5, you need a valid Azure subscription with permissions to create resource groups, ACR, and AKS resources.

## Technology stack

- **Terraform** -- Infrastructure as Code
- **Docker** -- Containerization
- **Kubernetes** -- Container orchestration
- **GitHub Actions** -- CI/CD pipelines
- **Azure** -- Cloud platform

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-3-devops/`. Explore the starter code: `app/` has the working application, `kubernetes/` and `terraform/` have minimal scaffolds. Read through the existing scaffolds before writing any instructions, then work through the stages in order.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Cloud provider and services in use (Azure only)
- Infrastructure as Code tool preferences (Terraform)
- Naming conventions and tagging standards
- Security requirements and compliance needs
- Non-negotiable: no secrets in source control, and least-privilege IAM by default

### Suggested custom agents

- Use a Terraform Expert Agent to propose module boundaries, variables, and state choices for Azure resource requirements. Use it for module design rather than one-off `apply` runs.
- Use a Kubernetes Engineer Agent to recommend resource limits, probes, and replica settings for a workload's manifests or Helm charts.
- Use a Security Reviewer Agent before merging to check Terraform and Kubernetes files for least-privilege IAM, image pinning, and secret handling.

### Suggested custom skills

- A Pipeline Stage Scaffolding Skill keeps new CI/CD jobs consistent, including inputs from prior stages and required secrets and permissions.
- A Drift Detection Skill compares the last applied Terraform state with the current configuration and explains changes. Run it before each apply.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "terraform review agent", "kubernetes manifest skill", and "azure IaC instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Describe your infrastructure goal as a comment block before generating HCL or YAML. The comment doubles as documentation.
- Specify resource limits, probe paths, and replica counts before generating Kubernetes manifests.
- When generating CI/CD pipelines, list the stages in order as comments. Copilot follows the sequence you lay out.
- Review generated Dockerfiles and Terraform carefully for security defaults (non-root users, least-privilege IAM, image pinning). Copilot gets the structure right but sometimes skips hardening.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-3-devops-track/stages.md)
