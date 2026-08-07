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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Open the folder `challenges/challenge-7-copilot-sdk/` in your workspace. Read through the starter files before writing any instructions -- this track has no stage scaffolding beyond the SDK itself, so the structure you find is the structure you work with.

A dedicated devcontainer is provided at `.devcontainer/challenge-7-copilot-sdk/`. It includes Node.js LTS, Copilot CLI, and GitHub CLI. Open the command palette (`F1` > **Dev Containers: Reopen in Container**) and select **challenge-7-copilot-sdk** when prompted.

### Install and Run

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

### Research the SDK First

Before writing any code, use the `/research` slash command in Copilot Chat to gather current documentation for `@github/copilot-sdk`. The SDK is new enough that Copilot's built-in training may be incomplete, and researching it upfront gives you accurate material to build your custom instructions from. Stage 1 walks through this in detail -- it is the first task and everything else builds on it.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- That you are building "ship-it", a Release Notes Agent, with `@github/copilot-sdk` in Node.js/TypeScript, backed by the Copilot CLI over JSON-RPC
- The session and streaming event model the SDK uses, so Copilot reasons about your code with the right vocabulary
- Your tool schema conventions: how tools are named, what each returns, and how errors propagate back into the conversation
- That the deployment target is Azure only (App Service or Container Apps)
- That categorization and changelog logic must stay correctable through conversation, not hardcoded silently

### Suggested Custom Agents

The custom agent you create here helps you write and debug the SDK application itself. It is not ship-it, the Release Notes Agent your code builds and runs through the SDK -- that one is the project's deliverable and lives in your application's runtime, not in `.github/agents/`.

- **SDK Pairing Agent** -- Knows the `@github/copilot-sdk` session and event model well enough to help design tool schemas and handler wiring. Give it a tool description; it proposes the schema and event flow for you to review. Use it while building the CLI application, not while it's running.
- **Changelog Style Agent** -- Applies judgment on categorization and tone for generated release notes: what counts as a breaking change, how to phrase a migration note, and what belongs in highlights. Give it a batch of categorized PRs; it drafts notes for you to adjust. Use it when tuning ship-it's output, not its plumbing.

### Suggested Custom Skills

- **SDK Research Skill** -- A fixed sequence for gathering current documentation with the `/research` command before writing code: pull the docs, note API surface that differs from Copilot's training data, and turn findings into your custom instructions. Run it once at the start, during Stage 1.
- **Tool Registration Skill** -- A repeatable pattern for adding a new tool to the agent: define the schema, register the handler, wire it into the session, and verify it appears in a test conversation. Use it every time ship-it needs a new capability.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "copilot sdk", "typescript agent tool", and "release notes automation" before you draft your own.

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

For SDK cookbook patterns and language-specific instruction examples, use the
[shared examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own)
and search for "copilot sdk cookbook" or the SDK language you are using.

### GitHub Documentation

- [Copilot CLI Installation](https://docs.github.com/en/copilot/how-tos/copilot-cli/install-copilot-cli)
- [Copilot SDK Overview](https://docs.github.com/en/copilot/how-tos/copilot-sdk)
- [Premium Requests and Billing](https://docs.github.com/en/copilot/concepts/billing/copilot-requests)

### General

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-7-copilot-sdk-track/stages.md)
