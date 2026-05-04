# Stage 3: Terraform Infrastructure

[Back to Challenge 3: DevOps Track](../challenge-3-devops-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

Provision Azure infrastructure using Terraform with proper variable management.

## Tasks

1. Complete `terraform/azure/main.tf`: configure Azure provider, provision Resource Group, Azure Container Registry (Basic SKU), and Azure Kubernetes Service (system node pool, 1-3 nodes).
2. Create `terraform/azure/variables.tf`: all configurable values (region, resource names, SKU, node count, etc.) must be variables with defaults and descriptions.
3. Create `terraform/azure/outputs.tf`: output ACR login server, AKS cluster name, kubeconfig command, and resource group name.
4. Configure a remote state backend using Azure Storage Account.

## Verification

- `terraform validate` passes
- `terraform plan` shows the expected resources (RG, ACR, AKS)
- All configurable values are variables (not hardcoded)
- Outputs are defined and meaningful

---

Previous: [Stage 2: Kubernetes Orchestration](stage-2-kubernetes.md) | Next: [Stage 4: Observability and Security Hardening](stage-4-observability.md)
