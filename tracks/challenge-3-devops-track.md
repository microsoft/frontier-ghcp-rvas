# Challenge 3 Track: DevOps

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Infrastructure as Code, containerization, and deployment automation with GitHub Copilot

## Who Is This For

- DevOps Engineers and Platform Engineers
- Site Reliability Engineers (SRE)
- Cloud Engineers
- Infrastructure Architects

## Prerequisites

- **Azure subscription** (required for Stages 3-5 -- Terraform provisioning, Key Vault, CI/CD deployment)
- **Azure Kubernetes Service (AKS)** access or ability to create one (Stage 3 provisions it, Stages 4-5 use it)
- Basic understanding of Azure cloud platform
- Familiarity with Docker containers
- Understanding of infrastructure concepts
- Basic knowledge of YAML and HCL (Terraform)
- CI/CD concepts

> ⚠️ **No Azure subscription?** Stages 1 (Docker) and 2 (Kubernetes with a local cluster like minikube or kind) can be completed without Azure. For Stages 3-5, you need a valid Azure subscription with permissions to create resource groups, ACR, and AKS resources.

## Technology Stack

- **Terraform** -- Infrastructure as Code
- **Docker** -- Containerization
- **Kubernetes** -- Container orchestration
- **GitHub Actions** -- CI/CD pipelines
- **Azure** -- Cloud platform

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-3-devops/`. Explore the starter code: `app/` has the working application, `kubernetes/` and `terraform/` have minimal scaffolds. Read through the existing scaffolds before writing any instructions, then work through the stages in order.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- Cloud provider and services in use (Azure only)
- Infrastructure as Code tool preferences (Terraform)
- Naming conventions and tagging standards
- Security requirements and compliance needs
- Non-negotiable: no secrets in source control, and least-privilege IAM by default

### Suggested Custom Agents

- **Terraform Expert Agent** -- Applies IaC judgment: module boundaries, variable design, and state trade-offs for Azure resources. Give it a resource requirement; it proposes the module shape. Use it when designing or restructuring Terraform, not for one-off `apply` runs.
- **Kubernetes Engineer Agent** -- Reasons about manifest and Helm chart design: resource limits, probes, and replica strategy for a workload. Give it a deployment target; it recommends the manifest structure. Use it when shaping how a service runs in the cluster.
- **Security Reviewer Agent** -- Applies a security and compliance lens to infrastructure code: least-privilege IAM, image pinning, and secret handling. Give it a Terraform or Kubernetes file; it returns findings. Use it before merging infrastructure changes.

### Suggested Custom Skills

- **Pipeline Stage Scaffolding Skill** -- A consistent sequence for adding a new CI/CD stage: define the job, wire its inputs from the prior stage, and add the required secrets and permissions. Use it every time a stage is added so the pipeline stays uniform.
- **Drift Detection Skill** -- A repeatable comparison between the last applied Terraform state and the current configuration, producing a plain-language summary of what changed and why. Run it before every apply, not only when something looks wrong.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "terraform review agent", "kubernetes manifest skill", and "azure IaC instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Describe your infrastructure goal as a comment block before generating HCL or YAML. The comment doubles as documentation.
- For Kubernetes manifests, specify resource limits, probe paths, and replica counts up front -- Copilot will use whatever constraints you give it.
- When generating CI/CD pipelines, list the stages in order as comments. Copilot follows the sequence you lay out.
- Review generated Dockerfiles and Terraform carefully for security defaults (non-root users, least-privilege IAM, image pinning). Copilot gets the structure right but sometimes skips hardening.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)

---

Next: [Stages](challenge-3-devops-track/stages.md)
