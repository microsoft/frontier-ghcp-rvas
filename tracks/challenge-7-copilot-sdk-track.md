# Challenge 7 Track: Copilot SDK Developer

**Duration:** 8-12 hours (Advanced)

**Difficulty:** ⭐⭐⭐

**Focus:** Building a Release Notes Agent from scratch using the GitHub Copilot SDK

> ⚠️ **Challenge 7 is significantly harder and longer than the standard 4-6 hour tracks.** It is designed for experienced developers who have completed a standard track (or equivalent) and want a deeper challenge that goes beyond using Copilot -- to **building with its engine**.

## Who Is This For

- Developers who finished a standard track and want more
- Backend engineers interested in AI-powered tooling
- Platform/DevEx engineers who want to embed Copilot's agentic capabilities in custom apps
- Anyone curious about programmatic access to Copilot's agent runtime

## Prerequisites

- Completion of at least one standard track (or equivalent experience)
- Solid Node.js and TypeScript skills
- Familiarity with GitHub APIs (Issues, Pull Requests, Releases, Tags)
- Understanding of event-driven and streaming patterns
- Copilot CLI installed and authenticated (`copilot --version` should work)

## Technology Stack

- **Runtime:** Node.js (LTS) with TypeScript
- **SDK:** `@github/copilot-sdk` -- programmatic access to Copilot's agent runtime (sessions, streaming, custom tools)
- **GitHub API:** `@octokit/rest` -- for querying PRs, releases, tags, commits, and CI status
- **Copilot CLI:** Required as the backend server -- the SDK communicates with it via JSON-RPC
- **Deployment:** Azure (App Service or Container Apps) for the final application

## What You Are Building

**"ship-it" -- a Release Notes Agent.** Given a repository and a reference point (a tag, a date, or a commit SHA), this CLI agent analyzes all merged pull requests, categorizes the changes, generates a structured changelog, and can publish a draft GitHub Release. The workflow is conversational -- a team lead can review the generated notes, ask for adjustments ("move this PR to the highlights section", "add a migration guide for the breaking change"), and iterate until they are satisfied. When everything looks right, they say "publish it" and the agent creates the release.

This is the kind of repetitive-but-judgement-requiring task where an agent with tools genuinely outperforms a plain script. Nobody likes writing release notes by hand, but a script can't categorize changes intelligently or draft human-readable summaries. The SDK sits right in the middle.

## Getting Started

### 1. Open the Challenge

Open the folder `challenges/challenge-7-copilot-sdk/` in your workspace.

A dedicated devcontainer is provided at `.devcontainer/challenge-7-copilot-sdk/`. It includes Node.js LTS, Copilot CLI, and GitHub CLI. Open the command palette (`F1` > **Dev Containers: Reopen in Container**) and select **challenge-7-copilot-sdk** when prompted.

### 2. Install and Run

```bash
cd challenges/challenge-7-copilot-sdk
npm install
npx tsx index.ts
```

### 3. Authenticate

The SDK needs a valid GitHub identity to create sessions. Run:

```bash
copilot
```

and then do a `/login` command in Copilot Chat to login into GitHub Copilot.

The SDK manages the CLI process lifecycle automatically. You do not need to start the CLI server manually.

### 4. Research the SDK First

Before writing any code, use the `/research` slash command in Copilot Chat to gather current documentation for `@github/copilot-sdk`. The SDK is new enough that Copilot's built-in training may be incomplete, and researching it upfront gives you accurate material to build your custom instructions from. Phase 1 walks through this in detail -- it is the first task and everything else builds on it.

Also follow the [common setup steps](getting-started.md) for the clean start.

---

## Tips for Using Copilot on This Track

- Use `/explain` on the SDK types to understand the session event model before writing handlers.
- Start with a concrete tool schema ("a tool that fetches merged PRs between two refs") rather than asking Copilot to design the whole architecture at once.
- Agent mode works well for scaffolding tool registration and event handling in one pass -- describe all the tools you need and let it wire up the schemas, handlers, and session registration together.
- For the changelog formatter, ask Copilot for templates matching established formats like Keep a Changelog -- it gives better output with a known target.

## Resources

### Copilot SDK

- [Copilot SDK Repository](https://github.com/github/copilot-sdk) -- source code, docs, and examples for all languages
- [Getting Started Guide](https://docs.github.com/en/copilot/how-tos/copilot-sdk/sdk-getting-started) -- official quickstart
- [SDK Blog Post](https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/) -- architecture overview and use cases
- [Copilot SDK Cookbook](https://github.com/github/awesome-copilot/blob/main/cookbook/copilot-sdk) -- practical recipes for common patterns
- [Node.js Custom Instructions](https://github.com/github/awesome-copilot/blob/main/instructions/copilot-sdk-nodejs.instructions.md) -- Copilot instructions tuned for Node.js SDK development

### GitHub Documentation

- [Copilot CLI Installation](https://docs.github.com/en/copilot/how-tos/copilot-cli/install-copilot-cli)
- [Copilot SDK Overview](https://docs.github.com/en/copilot/how-tos/copilot-sdk)
- [Premium Requests and Billing](https://docs.github.com/en/copilot/concepts/billing/copilot-requests)

### General

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Phases](challenge-7-copilot-sdk-track/phases.md)
