# Getting Started

These steps apply to every track and help you prepare your environment to drive an outcome with Copilot. Complete them before starting your first stage.

## 1. Open in a DevContainer (Recommended)

Each challenge has its own devcontainer configuration under `.devcontainer/`. When you open the repo in a devcontainer (Codespaces or VS Code Dev Containers), pick the configuration that matches your challenge.

The devcontainer automatically:

- Installs all tools and dependencies for your challenge
- Removes challenge folders, track files, and devcontainer configs you don't need
- Clears `.github/copilot-instructions.md` so you start fresh
- Removes sample agents and skills from `.github/`
- Detaches the git remote so you don't accidentally push to the template repo

After the container finishes building, your workspace only contains the files relevant to your track. Skip to step 3.

## 2. Manual Setup (Without DevContainer)

If you are **not** using a devcontainer, run the setup script with your challenge name:

**Linux / macOS:**

```bash
./scripts/setup-challenge.sh challenge-1-backend
```

**Windows (PowerShell):**

```powershell
.\scripts\setup-challenge.ps1 -Challenge challenge-1-backend
```

Run the script without arguments to see the full list of challenge names.

This does the same cleanup that the devcontainer does automatically -- removes unrelated challenges, tracks, and devcontainer configs, and resets `.github/`. You still need to install language-specific dependencies yourself (npm install, pip install, etc.) since there is no devcontainer to handle that.

## 3. Create Your Custom Instructions

`.github/copilot-instructions.md` tells Copilot about your project context and preferences. **Your goal is to create your own custom instructions file that helps you drive your outcome.**

Every track involves a different technology stack and outcome, so the specifics vary. At a minimum, include:

- Project context (framework, language, architecture)
- The outcome you're trying to deliver (what "done" looks like)
- Coding standards and conventions
- What kind of output you expect (code style, testing approach, documentation)

Your track file lists suggestions specific to your domain and outcome.

## 4. Create Custom Agents (`.github/agents/`)

Agents are specialized Copilot personas for different tasks. Create `.md` files in `.github/agents/` to define them. **Your goal is to create agents that help you deliver your outcome faster.**

**What to include in each agent:**

- Clear description of the agent's expertise and how it helps drive your outcome
- Specific instructions for the kind of output it should generate
- References to your project's patterns and conventions

Your track file suggests specific agents for your domain and outcome.

> Check out [github/awesome-copilot](https://github.com/github/awesome-copilot) for real-world examples of custom instructions and agent templates.
>
> **Tip**: Reference your agents in chat using `@agent-name` to get specialized assistance.

## 5. Open the Challenge

Each track maps to a challenge folder under `challenges/`. Your track file tells you which folder to navigate to and what files to open first.
