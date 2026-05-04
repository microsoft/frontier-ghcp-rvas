# Stage 5: CI/CD Pipeline and Deployment Strategy

[Back to Challenge 3: DevOps Track](../challenge-3-devops-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

Automate everything and plan for failure.

## Tasks

1. Create a GitHub Actions workflow in `.github/workflows/deploy.yml`: lint Dockerfile, build and push image to ACR, scan image for vulnerabilities, run `terraform plan` on PRs and `terraform apply` on merge to main, deploy to AKS.
2. Blue/green deployment: create `kubernetes/deployment-blue.yaml` and `kubernetes/deployment-green.yaml`. Configure the service to point to one color at a time. Document the switchover procedure.
3. Add Terraform cost estimation using `infracost` as a step in the GitHub Actions workflow.
4. Write a disaster recovery runbook in `docs/disaster-recovery-runbook.md` covering: backup procedures for application data and Terraform state, restore steps, RTO/RPO targets with justification, and rollback process for each deployment type.

## Verification

- GitHub Actions YAML is valid (test with `actionlint` or a YAML linter)
- Blue/green deployment manifests are complete with switchover documentation
- DR runbook covers all required scenarios with specific procedures

---

Previous: [Stage 4: Observability and Security Hardening](stage-4-observability.md)
