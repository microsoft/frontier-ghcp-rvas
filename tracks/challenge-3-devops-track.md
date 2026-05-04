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

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [Containerization and Local Development](challenge-3-devops-track/stage-1-containerization.md) | ⭐⭐ | 60-75 min | Multi-stage Dockerfile, Docker Compose, security scan |
| 2 | [Kubernetes Orchestration](challenge-3-devops-track/stage-2-kubernetes.md) | ⭐⭐ | 60-90 min | Deployment, Service, ConfigMap, HPA, NetworkPolicy |
| 3 | [Terraform Infrastructure](challenge-3-devops-track/stage-3-terraform.md) | ⭐⭐⭐ | 60-90 min | Azure RG, ACR, AKS with variables and remote state |
| 4 | [Observability and Security Hardening](challenge-3-devops-track/stage-4-observability.md) | ⭐⭐⭐ | 60-90 min | Fix broken Key Vault module, pod security, metrics endpoint |
| 5 | [CI/CD Pipeline and Deployment Strategy](challenge-3-devops-track/stage-5-cicd.md) | ⭐⭐⭐ | 60-90 min | GitHub Actions, blue/green deployment, DR runbook |

The application is already complete -- your job is the infrastructure. Copilot generates valid Dockerfile, YAML, and HCL syntax, but Stage 4 requires debugging broken Terraform and Stage 5 requires deployment strategy decisions that need operational judgment.

> **Short on time?** Skip NetworkPolicy in Stage 2, skip remote state in Stage 3, do only the Key Vault debug in Stage 4, and focus on the GitHub Actions workflow only in Stage 5.

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
