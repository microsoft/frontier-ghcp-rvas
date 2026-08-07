# Stage 3: Azure Automation and Compliance

**Difficulty:** ⭐⭐⭐ | **Time:** 45-60 min

The tagging script in `scripts/Set-AzureResourceTags.ps1` runs interactively with `Connect-AzAccount`, overwrites existing tags without checking them, and provides no feedback. This stage turns it into a safe, automatable compliance script.

## Tasks

1. Replace `Connect-AzAccount` with support for service principal or managed identity authentication. Add a `-UseAzureAD` switch and document when each auth method is appropriate. Use Copilot to generate the conditional auth block and explain the security difference.
2. Add parameter validation: `[ValidatePattern('^[0-9]{4}$')]` on `$CostCenter`, `[ValidateSet('dev','staging','prod')]` on `$Environment`. Ask Copilot to add descriptive error messages that tell the caller what format is expected.
3. Make the script idempotent: only call `Set-AzResource` when the existing tags differ from the target tags. Add a `-WhatIf` switch using `SupportsShouldProcess` so operators can preview changes without applying them.
4. Read the `docs/tagging-policy.md` file and ask Copilot to generate a compliance summary report -- a table listing each resource, its current tags, and whether it is compliant or not -- without modifying any resources.

If your Azure Automation agent or refactor skill produces a broken `-WhatIf` path or generic validation messages, refine that customization before trusting the compliance report.

## Verification

- Running the script with `-WhatIf` prints the resources that would be tagged but makes no changes
- Resources already carrying all four correct tags are skipped (no `Set-AzResource` call)
- Passing an invalid `CostCenter` (e.g., `"abc"`) produces a clear `ParameterBindingValidationException` with a useful message
- The compliance report lists each resource and a `Compliant` column with `true` or `false`

## What Copilot Helps With vs. What Requires Your Judgment

Copilot knows `SupportsShouldProcess` syntax and will generate a correct `$PSCmdlet.ShouldProcess` call. It is less reliable on which permissions a service principal needs to tag resources -- verify the required RBAC role (`Tag Contributor` or `Contributor`) against your organization's least-privilege policy before deploying.

---

Previous: [Stage 2: Adding Error Handling and Logging](stage-2-error-handling.md) | Next: [Stage 4: Pester Tests and Static Analysis](stage-4-pester-tests.md)
