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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

**What to include:**

- Cloud provider and services in use (Azure)
- Infrastructure as Code tool preferences (Terraform)
- Naming conventions and tagging standards
- Security requirements and compliance needs

### Suggested Agents

**Agents to consider creating:**

- **Terraform Expert Agent** -- Specialized in IaC best practices, module design, and Azure resources
- **Kubernetes Engineer Agent** -- Focused on container orchestration, manifests, and Helm charts
- **Security Reviewer Agent** -- Expert in infrastructure security and compliance

### Open the Challenge

Navigate to `challenges/challenge-3-devops/`. Explore the starter code: `app/` has the working application, `kubernetes/` and `terraform/` have minimal scaffolds. Work through the stages in order.

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
