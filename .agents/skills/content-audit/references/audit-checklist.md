# Audit Checklist

Detailed checks for the content-audit skill. Use these when running a full audit or when the user asks about a specific category. Record evidence for every finding so nothing is changed on a guess.

## Verify Against Official Sources

When a claim cannot be confirmed from memory with high confidence, fetch the primary source before changing anything. Preferred sources by topic:

| Claim type | Primary source |
|---|---|
| Azure service names, SKUs, regions, limits | Microsoft Learn / Azure docs |
| Azure CLI commands and flags | `az` reference on Microsoft Learn |
| `azd` (Azure Developer CLI) behavior | Azure Developer CLI docs |
| .NET / C# versions and APIs | Microsoft Learn .NET docs and release notes |
| Node.js versions, LTS schedule | nodejs.org releases |
| Python versions and stdlib | docs.python.org |
| Java / Spring Boot versions | official project docs and release notes |
| npm / NuGet / PyPI package versions | the package registry page |
| Tool/SDK latest version | the project's GitHub releases |

Record the source URL and the value you confirmed next to each finding. If a source is unreachable, mark the item "unverified" rather than changing it.

## Hallucination Surfaces

Read these with extra suspicion. They are where invented content tends to appear.

- CLI subcommands and flags that look plausible but do not exist.
- SDK methods, class names, namespaces, or import paths.
- Package names and their version numbers.
- Azure resource types, portal navigation paths, and ARM/Bicep resource identifiers.
- Configuration keys, environment variable names, and file paths referenced in prose that must match the actual starter code.
- Specific quantitative claims (quotas, limits, pricing, "supports up to N") with no citation.

For each suspect item: confirm it exists, correct it, or remove the unsupported claim.

## Pacing Rubric

Target: each challenge is completable in 4 to 6 hours by its stated audience.

- Count the stages/tasks and estimate effort per task including reading, setup, and debugging.
- Add provisioning overhead (Azure resource creation, devcontainer build, dependency install).
- Subtract nothing for "the agent will do it" — assume realistic human-in-the-loop time.

Flag and recommend an action:

- Under ~1 hour total: too thin. Suggest added depth or a stretch stage.
- Over ~8 hours total: too heavy. Suggest concrete scope cuts or splitting.
- Difficulty or time metadata that does not match the actual work: correct the metadata.

## Link Integrity

- Internal links resolve to an existing file.
- Heading-anchor links match a real heading in the target file.
- Track-to-challenge references point at files that exist in the challenge folder.
- External links return a live page; replace dead or redirected URLs with the current canonical one.

## Convention Compliance (repo-specific)

From [.github/copilot-instructions.md](../../../copilot-instructions.md) and [tracks/TRACK_STRUCTURE.md](../../../../tracks/TRACK_STRUCTURE.md):

- Azure only. No AWS, GCP, or other cloud providers anywhere.
- No `README.md` inside any challenge folder; instructions live in the track file.
- Every challenge has a devcontainer config and is referenced from its track.
- Track and challenge starter code stay in sync; structural changes update the root README.
- Track files follow the required section order and stage-file format.

## Markdown Style and Lint

- No emoji in headings.
- Minimal emoji in prose (only the exceptions allowed by copilot-instructions).
- No em-dashes; use `--` or rephrase.
- Every code fence has a language tag.
- Blank lines above and below headings; no trailing whitespace.
- No hype language and no AI sign-offs.
- Must pass markdownlint with the repo's `.markdownlint.json`.

## Severity Mapping

- **Critical**: wrong facts, hallucinated commands/APIs, broken required Azure steps, dead required links.
- **Major**: outdated versions, pacing outside the 4-6h budget, track/challenge/README out of sync.
- **Minor**: style and lint issues, weak wording, optional-link rot.

## Report Format

For each finding, capture:

```text
[Severity] file/path.md (section or line)
  Problem: what is wrong
  Evidence: file content or official source URL + confirmed value
  Fix: the concrete change to apply
```

Present the report grouped by severity, fix mechanical issues directly, and confirm scope-changing fixes with the user before applying.
