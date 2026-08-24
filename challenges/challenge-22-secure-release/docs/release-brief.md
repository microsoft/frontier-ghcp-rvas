# Release Candidate Brief

The payments team wants to release this API at the end of the week. It is a
small service, but it sits on a sensitive path: users create payments, support
staff inspect accounts, and administrators review operational events.

The code is intentionally incomplete from a security point of view. All users,
tokens, payments, and configuration values are synthetic and local. Do not use
the demo authentication design outside this challenge.

## Stakeholders

- The product owner wants the current identity and payment flows to keep
  working.
- The security reviewer wants evidence for every release-blocking finding.
- Operations needs useful security events without tokens or configuration
  values appearing in logs.
- The engineering lead will accept a documented residual risk only when it has
  an owner, review date, and compensating control.

## Data and Trust Notes

- The API process is the main trust boundary.
- Callers can be unauthenticated, customer users, or administrators.
- Payment records and user profiles are sensitive local data.
- The payment provider setting is a placeholder, not a real credential.
- Package and scan evidence is captured under `evidence/`.

## Run the Starter

From this challenge directory:

```bash
dotnet restore SecureReleaseReview.sln
dotnet run --project src/SecureRelease.Api
```

In another terminal:

```bash
curl http://localhost:5000/health
```

The port shown by `dotnet run` is authoritative if it differs from `5000`.

## Review Scope

Review the identity, payment, and admin endpoints. Include configuration,
dependencies, and security logging. Keep the work local. Azure deployment is
not required, and no Azure credentials are needed.

Do not add attack automation, credential guessing, persistence, or destructive
requests. A small request that proves a local authorization or validation gap
is enough.
