# Getting Started

These steps apply to every track. Start with a clean workspace, inspect the
challenge, and then prepare the Copilot customizations you will use during the
session.

**Challenge 30 exception:** follow its baseline stage for setup and Spec Kit
initialization. It uses supplied Spec Kit skills; authoring custom agents and
skills is optional. Complete cleanup before initialization, never afterward.

## 1. Start from a Clean Workspace

### Open in a DevContainer (Recommended)

Each challenge has its own devcontainer configuration under `.devcontainer/`.
When you open the repository in a devcontainer through Codespaces or VS Code
Dev Containers, pick the configuration that matches your challenge.

The devcontainer automatically:

- Installs all tools and dependencies for your challenge
- Removes challenge folders, track files, and devcontainer configurations you
  do not need
- Clears `.github/copilot-instructions.md` so you start fresh
- Removes sample agents and skills from `.github/`
- Detaches the git remote so you do not accidentally push to the template
  repository

After the container finishes building, your workspace contains only the files
relevant to your track. Continue with step 2.

### Manual Setup (Without a DevContainer)

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

The script performs the same cleanup as the devcontainer. It removes unrelated
challenges, tracks, and devcontainer configurations and resets `.github/`. You
still need to install language-specific dependencies yourself, such as with
`npm install` or `pip install`.

## 2. Open and Inspect the Challenge

Follow the **Open the Challenge** link in your track. Before creating any
customizations, inspect the starter code, tests, configuration, and supporting
documentation. Identify the outcome, project conventions, constraints, and
work that the challenge leaves for you.

Each track provides a tailored brief and durable search terms for finding
relevant patterns and documentation. Use those as investigation guides, not as
ready-to-paste prompts, agents, skills, or instructions. When a challenge
includes cloud examples, use Azure only.

## 3. Draft the Customization Trio

Set aside 20--30 minutes to draft three challenge-specific artifacts. They
serve different purposes and should not repeat the same content.

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

## 4. Learn from Examples, Then Write Your Own

Inspect [github/awesome-copilot](https://github.com/github/awesome-copilot)
and its [Learning Hub](https://awesome-copilot.github.com/) to see how other
teams structure customizations. Use the examples to understand the available
patterns, then author artifacts that fit your challenge. Installing a
community artifact does not complete this exercise.
