# Challenge 3 Track: DevOps: Stages

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [Containerization and Local Development](stage-1-containerization.md) | ⭐⭐ | 60-75 min | Multi-stage Dockerfile, Docker Compose, security scan |
| 2 | [Kubernetes Orchestration](stage-2-kubernetes.md) | ⭐⭐ | 60-90 min | Deployment, Service, ConfigMap, HPA, NetworkPolicy |
| 3 | [Terraform Infrastructure](stage-3-terraform.md) | ⭐⭐⭐ | 60-90 min | Azure RG, ACR, AKS with variables and remote state |
| 4 | [Observability and Security Hardening](stage-4-observability.md) | ⭐⭐⭐ | 60-90 min | Fix broken Key Vault module, pod security, metrics endpoint |
| 5 | [CI/CD Pipeline and Deployment Strategy](stage-5-cicd.md) | ⭐⭐⭐ | 60-90 min | GitHub Actions, blue/green deployment, DR runbook |

The application is already complete -- your job is the infrastructure. Copilot generates valid Dockerfile, YAML, and HCL syntax, but Stage 4 requires debugging broken Terraform and Stage 5 requires deployment strategy decisions that need operational judgment.

> **Short on time?** Skip NetworkPolicy in Stage 2, skip remote state in Stage 3, do only the Key Vault debug in Stage 4, and focus on the GitHub Actions workflow only in Stage 5.

---

Previous: [Track Overview](../challenge-3-devops-track.md) | Next: [Stage 1: Containerization and Local Development](stage-1-containerization.md)
