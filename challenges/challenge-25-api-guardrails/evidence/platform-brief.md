# API Platform Brief

Three product teams are ready to publish their APIs through Azure API
Management. Each service works today, but consumers have to learn a different
set of conventions for every integration.

The API platform team owns the rules at the boundary. Product teams still own
their service code and business behavior. Your work should define what an API
must look like before it enters the shared platform, how exceptions are
handled, and what Azure API Management applies consistently at runtime.

## Constraints

- Existing mock behavior must remain available while proposals are reviewed.
- Consumers need a documented migration path before a contract is retired.
- Identity guidance must use Microsoft Entra ID and Azure API Management.
- Local checks are the required path. Azure deployment is optional.
- Policies and examples must not contain credentials, tokens, subscription
  keys, tenant IDs, or real service URLs.
- Teams need an exception route for cases where a standard cannot be met.

## Boundary with Application Delivery

This is not an API implementation exercise. Do not rebuild handlers, databases,
or domain logic. Challenge 1 covers building an application API. This challenge
governs contracts from several teams and adds controls above those teams.
