# Challenge 3 Track: DevOps

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Infrastructure as Code, containerization, and deployment automation with GitHub Copilot

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

Go to `challenges/challenge-3-devops/`. `app/` has the working application, and `kubernetes/` and `terraform/` have minimal scaffolds. Read the scaffolds before you write instructions, then work through the stages in order.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Cloud provider and services in use (Azure only)
- Infrastructure as Code tool preferences (Terraform)
- Naming conventions and tagging standards
- Security requirements and compliance needs
- No secrets in source control, and least-privilege IAM by default

### Suggested custom agents

- A Terraform Expert Agent that proposes module boundaries, variables, and state choices for Azure resource requirements. Use it for module design, not one-off `apply` runs.
- A Kubernetes Engineer Agent that recommends resource limits, probes, and replica settings for a workload's manifests or Helm charts.
- A Security Reviewer Agent that checks Terraform and Kubernetes files for least-privilege IAM, image pinning, and secret handling before you merge.

### Suggested custom skills

- A Pipeline Stage Scaffolding Skill that keeps new CI/CD jobs consistent, including inputs from prior stages and required secrets and permissions.
- A Drift Detection Skill that compares the last applied Terraform state with the current configuration and explains the changes. Run it before each apply.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "terraform review agent", "kubernetes manifest skill", and "azure IaC instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Describe your infrastructure goal in a comment block before generating HCL or YAML. It doubles as documentation.
- Specify resource limits, probe paths, and replica counts before generating Kubernetes manifests.
- When generating CI/CD pipelines, list the stages in order as comments.
- Review generated Dockerfiles and Terraform for security defaults (non-root users, least-privilege IAM, image pinning). Copilot may skip hardening.

## Resources

- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-3-devops-track/stages.md)
