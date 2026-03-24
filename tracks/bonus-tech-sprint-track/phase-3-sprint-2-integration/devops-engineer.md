# Phase 3: Sprint 2 -- DevOps Engineer Tasks

[Back to Phase 3 Overview](../phase-3-sprint-2-integration.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: Full 2 hours**

## Tasks

1. **Deploy to Azure:**
   - Apply the Terraform or Bicep config to create Azure resources
   - Build and push Docker images (to Azure Container Registry or GitHub Container Registry)
   - Deploy backend and frontend to Azure App Service, Container Apps, or AKS
   - Verify the deployed application loads and APIs respond

2. **Configure the production environment:**
   - Set environment variables in Azure (database connection, API URL, CORS origins)
   - Enable HTTPS
   - Configure CORS so the frontend can call the backend

3. **Set up monitoring basics:**
   - Health check endpoint monitoring (Azure Monitor or Application Insights)
   - Ensure container logs are accessible for debugging

4. **Update the CI pipeline** -- Add a deployment step that deploys to a staging or production environment on merge to main.

## Verification

- [ ] Application deployed to Azure and accessible via a public URL
- [ ] CI pipeline includes a deployment step
- [ ] Health check or monitoring baseline in place

---

Previous: [Phase 2 -- DevOps Engineer Tasks](../phase-2-sprint-1-build/devops-engineer.md) | Next: [Phase 4 -- DevOps Engineer Tasks](../phase-4-deploy-demo/devops-engineer.md)
