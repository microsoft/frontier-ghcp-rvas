# Stage 2: Kubernetes Orchestration

[Back to Challenge 3: DevOps Track](../challenge-3-devops-track.md)

**Difficulty:** ⭐⭐ | **Time:** 60-90 min

Deploy the application to Kubernetes with production-grade configuration.

## Tasks

1. Complete `kubernetes/deployment.yaml`: 3 replicas, resource limits (CPU: 200m, Memory: 256Mi), liveness probe on `/api/quote`, readiness probe on `/health`, rolling update strategy, environment variables from ConfigMap.
2. Complete `kubernetes/service.yaml`: LoadBalancer type, port 80 to targetPort 3000.
3. Complete `kubernetes/configmap.yaml`: externalize application configuration.
4. Create `kubernetes/hpa.yaml`: HorizontalPodAutoscaler scaling between 2-5 replicas based on CPU (target 70%).
5. Create `kubernetes/networkpolicy.yaml`: deny all ingress except traffic from the Service.

## Verification

- `kubectl apply --dry-run=client -f kubernetes/` passes for all manifests
- Deployment shows correct probe configuration in `kubectl describe`
- HPA and NetworkPolicy are syntactically valid

---

Previous: [Stage 1: Containerization and Local Development](stage-1-containerization.md) | Next: [Stage 3: Terraform Infrastructure](stage-3-terraform.md)
