# Getting started

These steps apply to every track. Start with a clean workspace, inspect the
challenge, and then prepare the Copilot customizations you will use during the
session.

**Challenge 30 exception:** follow its baseline stage for setup and Spec Kit
initialization. It uses supplied Spec Kit skills; authoring custom agents and
skills is optional. Complete cleanup before initialization, never afterward.

## 1. Start from a clean workspace

### Open in a DevContainer (recommended)

Each challenge has its own devcontainer configuration under `.devcontainer/`.
When you open the repository in a devcontainer through Codespaces or VS Code
Dev Containers, pick the configuration that matches your challenge.

On first setup, the devcontainer:

- Runs the tool and dependency installation for your challenge
- Removes challenge folders, track files, and devcontainer configurations you
  do not need
- Removes the documentation website, full catalog, and facilitator material
- Clears `.github/copilot-instructions.md` so you start fresh
- Removes sample agents and skills from `.github/`
- Creates and switches to `challenge-<id>-<random suffix>` from the current
  commit, keeping all Git remotes and leaving the branch without an upstream

**Open the root README and follow its challenge link.** The selected starter
and track remain, along with shared help and required configuration.

**Check `git remote -v` before pushing.** Setup does not commit or push changes.
Branch creation requires a Git checkout with at least one commit and works
when Codespaces opens a detached commit.

Rebuilding a prepared workspace skips cleanup and preserves your current
branch and files, including installed skills and Copilot customizations. Older prepared
workspaces are also preserved; use a fresh clone to get the slimmer layout.
Use a separate clone to switch challenges.

### Manual setup (without a DevContainer)

If you are not using a devcontainer, run the setup script with your challenge
name.

Linux or macOS:

```bash
./scripts/setup-challenge.sh challenge-1-backend
```

Windows PowerShell:

```powershell
.\scripts\setup-challenge.ps1 -Challenge challenge-1-backend
```

Run the script without arguments to see the full list of challenge names.

The script performs the same first-time cleanup as the devcontainer. Running it
again for the same challenge preserves your work. You still need to install
language-specific dependencies yourself, such as with `npm install` or
`pip install`.

**Do not run `clean-start` after you begin.** It resets Copilot customizations.

## 2. Open and inspect the challenge

Follow the **Open the Challenge** link in your track. Before creating any
customizations, inspect the starter code, tests, configuration, and supporting
documentation. Identify the outcome, project conventions, constraints, and
work that the challenge leaves for you.

Each track provides a tailored brief and durable search terms for finding
relevant patterns and documentation. Use those as investigation guides, not as
ready-to-paste prompts, agents, skills, or instructions. When a challenge
includes cloud examples, use Azure only.

## 3. Draft the Customization Trio

Set aside 20-30 minutes to draft three challenge-specific artifacts. Each has
a different job. Avoid repeating content between them.

### Repository Instructions

Use `.github/copilot-instructions.md` for stable, project-wide context and
constraints. Capture facts and conventions that should apply throughout the
challenge rather than task-specific directions.

See GitHub's
[repository custom instructions documentation](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions)
for current authoring guidance.

### Custom Agent

Create one or more custom agents under `.github/agents/` for specialist judgment. Define
the role that should assess tradeoffs, apply domain expertise, and make
recommendations within the challenge's constraints.

See GitHub's
[custom agent authoring documentation](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/cloud-agent/create-custom-agents-in-your-ide)
for current authoring guidance.

### Custom Skill

Create one or more custom skills under `.github/skills/` for a repeatable, multi-step
workflow. Choose work that benefits from a consistent sequence and can be
reused during the challenge.

Each skill belongs in `.github/skills/<skill-name>/SKILL.md`. Give it a
lowercase, hyphenated name and a description that explains when to use it.
Define the required inputs and expected results, including the checks that
make those results useful. Author the skill yourself; a track's brief describes
the work it should support.

**Reuse the same skill as you progress.** When a stage builds on a skill from
setup, refine that artifact rather than creating another one. Keep reusable
workflows in skills. Use ordinary chat messages for one-off requests.

See GitHub's
[custom skill authoring documentation](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
for current authoring guidance.

## 4. Learn from examples, then write your own

Inspect [github/awesome-copilot](https://github.com/github/awesome-copilot)
and its [Learning Hub](https://awesome-copilot.github.com/) to see how other
teams structure customizations. Use the examples to understand the available
patterns, then author artifacts that fit your challenge. Installing a
community artifact does not complete this exercise.

## 5. Install Impeccable when your track uses it

Challenges **4, 8, 9, 10, 18, 27, 29, and 30** use Impeccable for a focused UI
review. Follow this section only for those tracks. Participants install the
skill themselves; no Impeccable extension or automatic devcontainer install
is required.

Complete clean setup first. From the **repository root**, run the
[official installer](https://github.com/pbakaus/impeccable#installation):

```bash
npx impeccable install --providers=github --scope=project
```

The flags select GitHub Copilot and a project-local installation. You need Node.js
with npm and network access to the skill and engine downloads. The installer adds
`.github/skills/impeccable/`, its engine, supplied agents, and Copilot hooks.
Review these files and requested permissions. Keep the supporting references
with `SKILL.md`; do not install another global or extension copy.

1. Confirm that `.github/skills/impeccable/SKILL.md` exists and inspect its
   command table.
2. Reload VS Code and open Copilot Chat in Agent mode, or restart Copilot CLI.
   Confirm that the installed skill is discoverable.
3. Use the skill's hook management to turn automatic hooks off at the repository
   root. Check the reported status. These tracks use explicit reviews.
4. Request a read-only review of a source file named by your track. Check that
   Copilot reads the installed skill and its references, works in the intended
   application folder, and leaves the source unchanged.

**Facilitators must check the environment participants will use.** Test skill
discovery and launcher execution, including in Codespaces. Resolve failures
before the session.

When using the skill, initialize product context in the application folder,
not the repository's documentation site. Keep the brief focused on the existing
user journey and constraints. Inspect generated context files for accuracy.
In team tracks, preserve the agreed specification or exported prototype.

Budget **15-25 minutes within the stage's existing review time** for one
critique-and-fix cycle. Record the problem and accepted or rejected feedback in
the existing pull request or acceptance evidence. Compare the same state and
viewport before and after a visual change. Preserve behavior and rerun affected
checks. Do not create a separate workshop report or commit runtime caches.

Impeccable's feedback is advisory. Browser checks and automated tests remain
required; a design review does not establish accessibility compliance.
