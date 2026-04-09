# Team Routing Guide

When an issue comes in, support needs to route it to the right team. This is the current (informal) routing guide.

| Error Pattern | Responsible Team | Contact Channel |
|---------------|-----------------|-----------------|
| Payment timeouts, payment failures | Payments Team | #payments-oncall |
| Database errors, slow queries, connection pool | Backend Team | #backend-support |
| Authentication failures, JWT errors | Security Team | #security-alerts |
| Email/SMS delivery failures | Infrastructure Team | #infra-ops |
| Warehouse API connectivity | Integrations Team | #integrations |
| UI rendering issues, frontend errors | Frontend Team | #frontend-support |
| Deployment failures, CI/CD issues | Platform Team | #platform-eng |
| Order state machine violations | Backend Team | #backend-support |
| Rate limiting alerts | Backend Team + API consumers | #api-support |
| Health check failures | On-call engineer (rotating) | PagerDuty |

## Escalation Path

1. L1 Support identifies the issue category from logs
2. L1 routes to the appropriate team channel
3. If no response in 15 minutes, escalate to team lead
4. If Critical severity, go directly to PagerDuty

## Current Pain Points

- L1 support often misroutes issues because log messages are technical and hard to interpret
- The "Backend Team" is a catch-all for anything not clearly in another bucket
- There is no automated correlation between error patterns and teams
- Incident post-mortems are written but rarely referenced during new incidents
