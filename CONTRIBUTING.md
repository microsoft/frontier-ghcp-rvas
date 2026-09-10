# Contributing

This project welcomes contributions and suggestions. Most contributions require you to
agree to a Contributor License Agreement (CLA) declaring that you have the right to,
and actually do, grant us the rights to use your contribution. For details, visit
<https://cla.microsoft.com>.

When you submit a pull request, a CLA-bot will automatically determine whether you need
to provide a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the
instructions provided by the bot. You will only need to do this once across all repositories using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/)
or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Agentic Workflow Updates

**Keep each gh-aw workflow's compiler and runtime actions on the same version.**
Issue Triage uses v0.86.2; CI Doctor and the maintenance workflow use v0.81.6.
Dependabot updates ordinary GitHub Actions, but ignores gh-aw runtime actions
because changing those pins alone can break generated steps.

Use the matching compiler for the workflow you are changing. For Issue Triage:

```bash
gh aw version
gh aw compile issue-triage-agent --strict
node --test scripts/check-agentic-runtime.test.mjs
node scripts/check-agentic-runtime.mjs
```

When upgrading gh-aw, review the source configuration and regenerate the affected
workflows together. Include `.github/aw/actions-lock.json` when it changes. Review
the maintenance workflow separately so an upgrade does not remove existing cleanup
or repair jobs. Do not bump runtime pins directly in generated YAML.

The runtime check rejects compiler/runtime version mismatches and lockfile pins
that differ from the generated manifest. It runs on workflow pull requests and
does not require an agent token. After merging a repair, start a new workflow run
from the updated branch; rerunning an older run uses its original workflow revision.
