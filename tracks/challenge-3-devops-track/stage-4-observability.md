# Stage 4: Observability and Security Hardening

[Back to Challenge 3: DevOps Track](../challenge-3-devops-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

This stage includes a broken Terraform module that you must debug.

## Tasks

1. **Bug hunt**: Open `stage-4-broken/keyvault.tf`. It contains a Terraform module for Azure Key Vault integration with 3 bugs: a wrong access policy reference, a missing dependent resource, and an incorrect AKS identity configuration. Fix all three and integrate the module into your main Terraform configuration.
2. Add pod security context to the Kubernetes deployment: `runAsNonRoot: true`, `readOnlyRootFilesystem: true`, drop ALL Linux capabilities.
3. Add a Prometheus-style metrics endpoint to the Node.js app: `GET /metrics` returning request count and latency histogram in Prometheus text format.
4. Create `kubernetes/cronjob.yaml`: a CronJob that periodically checks the application health endpoint and logs the result.

## Verification

- All 3 Key Vault Terraform bugs identified and fixed
- Pods run as non-root with read-only filesystem
- `/metrics` returns Prometheus-formatted data
- CronJob manifest is valid and runs on schedule

## What Copilot Helps With vs. What Requires Your Judgment

Copilot generates Terraform resources, pod security contexts, and CronJob manifests well. But debugging the broken Key Vault module requires understanding Azure identity models and Terraform resource dependencies -- Copilot may generate plausible but incorrect fixes if the root cause is not identified first.

---

Previous: [Stage 3: Terraform Infrastructure](stage-3-terraform.md) | Next: [Stage 5: CI/CD Pipeline and Deployment Strategy](stage-5-cicd.md)
