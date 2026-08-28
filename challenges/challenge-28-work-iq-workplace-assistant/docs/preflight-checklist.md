# Work IQ Preflight Checklist

Complete this checklist before starting. The workflow uses live Microsoft 365
data, so a local devcontainer alone is not enough.

## Tenant and Billing

- [ ] The Microsoft Entra tenant is enabled for Work IQ.
- [ ] A Copilot Studio usage-based billing plan is connected to an Azure
  subscription and resource group.
- [ ] The participant is assigned to that billing plan.
- [ ] An administrator has granted consent for the Work IQ application.

## Participant Access

- [ ] The participant has a Microsoft 365 account in the enabled tenant.
- [ ] The participant can access the project emails, meetings, Teams messages,
  and documents selected for the challenge.
- [ ] The participant has GitHub Copilot CLI access.
- [ ] The participant can complete Microsoft Entra sign-in in a browser from
  their development environment.

## Device and Network

- [ ] Node.js is available.
- [ ] The device uses a supported Windows, Linux, macOS, or WSL environment.
- [ ] The network allows access to Microsoft Entra authentication and the Work
  IQ service endpoint.

## Data Safety

- [ ] The delivery lead has named the project scope and time range.
- [ ] The group has agreed where the reviewed handoff may be stored.
- [ ] The group understands that Work IQ honors the signed-in user's Microsoft
  365 permissions, sensitivity labels, and tenant policies.
- [ ] The group has chosen a reviewer who approves the handoff before any
  write action is attempted.

If a Tenant and Billing or Participant Access item is incomplete, stop here.
Work with the tenant administrator before scheduling the challenge.
