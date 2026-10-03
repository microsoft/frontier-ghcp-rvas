# Challenge 7 Track: Copilot SDK Developer

**Duration:** 8-12 hours (Advanced)

**Difficulty:** ⭐⭐⭐

**Focus:** Building a Release Notes Agent from scratch using the GitHub Copilot SDK

> ⚠️ **Challenge 7 takes longer than the standard 4-6 hour tracks.** It requires experience from a standard track or equivalent work. You will build an application with Copilot's agent runtime.

## Who is this for

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

## Technology stack

- **Runtime:** Node.js (LTS) with TypeScript
- **SDK:** `@github/copilot-sdk` for sessions, streaming, and custom tools in Copilot's agent runtime
- **GitHub API:** `@octokit/rest` to query PRs, releases, tags, commits, and CI status
- **Copilot CLI:** Required backend server, connected to the SDK over JSON-RPC
- **Deployment:** Azure (App Service or Container Apps) for the final application

## What you are building

Build "ship-it", a Release Notes Agent. Given a repository and a reference point (a tag, a date, or a commit SHA), it analyzes merged pull requests, categorizes changes, generates a changelog, and can publish a draft GitHub Release. A team lead reviews the notes through conversation and requests adjustments ("move this PR to the highlights section", "add a migration guide for the breaking change"). Once satisfied, they say "publish it" and the agent creates the release.

Use SDK tools to fetch repository data and let the user correct generated categories and summaries before publication.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Open `challenges/challenge-7-copilot-sdk/` and read the starter files before writing instructions. There is no stage scaffolding beyond the SDK.

A dedicated devcontainer is provided at `.devcontainer/challenge-7-copilot-sdk/`. It includes Node.js LTS, Copilot CLI, and GitHub CLI. Open the command palette (`F1` > **Dev Containers: Reopen in Container**) and select **challenge-7-copilot-sdk** when prompted.

### Install and run

```bash
cd challenges/challenge-7-copilot-sdk
npm install
npx tsx index.ts
```

### Authenticate

The SDK needs a valid GitHub identity to create sessions. Run:

```bash
copilot
```

and then do a `/login` command in Copilot Chat to login into GitHub Copilot.

The SDK manages the CLI process lifecycle automatically. You do not need to start the CLI server manually.

### Research the SDK first

Before writing code, use `/research` in Copilot Chat to gather current documentation for `@github/copilot-sdk`. Copilot's training may not cover the current SDK. Use the research to write accurate custom instructions. This is the first task in Stage 1.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- That you are building "ship-it", a Release Notes Agent, with `@github/copilot-sdk` in Node.js/TypeScript, backed by the Copilot CLI over JSON-RPC
- The session and streaming event model the SDK uses, so Copilot reasons about your code with the right vocabulary
- Your tool schema conventions: how tools are named, what each returns, and how errors propagate back into the conversation
- That the deployment target is Azure only (App Service or Container Apps)
- That categorization and changelog logic must stay correctable through conversation, not hardcoded silently

### Suggested custom agents

Your custom agent helps you write and debug the SDK application. The Release Notes Agent, ship-it, runs through the SDK in your application, not in `.github/agents/`.

- Use an SDK Pairing Agent to propose tool schemas and handler event flows using the `@github/copilot-sdk` session model while building the CLI.
- Use a Changelog Style Agent to review categories and release note wording, including breaking changes, migration notes, and highlights.

### Suggested custom skills

- An SDK Research Skill gathers current documentation with `/research` and identifies API changes to record in custom instructions. Run it at the start of Stage 1.
- A Tool Registration Skill adds tools consistently and verifies that each is available in a test conversation, with its schema and handler connected to the session.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "copilot sdk", "typescript agent tool", and "release notes automation" before you draft your own.

---

## Tips for using Copilot on this track

- Use `/explain` on the SDK types to understand the session event model before writing handlers.
- Start with a concrete tool schema ("a tool that fetches merged PRs between two refs") rather than asking Copilot to design the whole architecture at once.
- Describe the tools you need before asking Agent mode to scaffold their schemas, handlers, and session registration.
- Give the changelog formatter a known target, such as Keep a Changelog.

## Resources

### Copilot SDK

- [Copilot SDK Repository](https://github.com/github/copilot-sdk) -- source code, docs, and examples for all languages
- [Getting Started Guide](https://docs.github.com/en/copilot/how-tos/copilot-sdk/sdk-getting-started) -- official quickstart
- [SDK Blog Post](https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/) -- architecture overview and use cases

For SDK cookbook patterns and language-specific instruction examples, use the
[shared examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own)
and search for "copilot sdk cookbook" or the SDK language you are using.

### GitHub documentation

- [Copilot CLI Installation](https://docs.github.com/en/copilot/how-tos/copilot-cli/install-copilot-cli)
- [Copilot SDK Overview](https://docs.github.com/en/copilot/how-tos/copilot-sdk)
- [Premium Requests and Billing](https://docs.github.com/en/copilot/concepts/billing/copilot-requests)

### General

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-7-copilot-sdk-track/stages.md)
