# GitHub Copilot guide

## What is GitHub Copilot?

GitHub Copilot is an AI assistant built into VS Code. In Agent mode, it reads
files, runs approved terminal commands, and retries after errors. It can work
through tasks that require changes to several files.

## Ways to interact

| Method | Access | Best For |
|--------|--------|----------|
| **Chat View** | `Ctrl+Alt+I` (Win/Linux) / `Cmd+Shift+I` (Mac) | Complex tasks, multi-file changes |
| **Inline Chat** | `Ctrl+I` / `Cmd+I` | Quick edits within a file |
| **Inline Suggestions** | Automatic as you type | Code completions while coding |

## Agents

Agents define how Copilot behaves during a conversation. VS Code includes four built-in agents:

| Agent | Description | Best For |
|-------|-------------|----------|
| **Agent** | Edit files, run commands, and retry after errors | Multi-file implementations, complex tasks |
| **Plan** | Read-only planning mode | Architecture decisions, task planning |
| **Ask** | Q&A mode for questions and explanations | Learning, understanding code, research |
| **Edit** | Focused file editing with inline changes | Quick edits to specific files |

Switch agents by clicking the agent picker dropdown in the Chat view.

### Agent mode

Agent mode can:

- Create and modify multiple files
- Run terminal commands automatically
- Recognize errors and fix them
- Iterate until your task is complete
- Identify related work needed to complete the task

When Agent makes changes, review them inline in the editor. Accept good changes, reject others, and ask for modifications. Use Chat's undo to revert if needed.

### Tool approvals

Agent requests permission before modifying files, running terminal commands, or invoking MCP tools. Approval options:

| Approval | Effect |
|----------|--------|
| Allow | Run once |
| Allow for Session | Allow during this session |
| Allow for Workspace | Allow in this workspace |
| Skip | Do not run the tool |

You can auto-approve safe commands in settings:

```json
{
  "chat.tools.terminal.autoApprove": {
    "mkdir": true,
    "npm test": true,
    "git status": true,
    "/^npm (install|run build)$/": true,
    "rm -rf": false,
    "sudo": false
  }
}
```

## Adding context with # mentions

Use `#` to give Copilot specific context:

| Mention | Purpose | Example |
|---------|---------|---------|
| `#file` | Reference a specific file | `#file:src/auth.ts explain this` |
| `#codebase` | Search your project | `#codebase how is auth implemented?` |
| `#selection` | Reference selected code | `#selection add error handling` |
| `#terminalSelection` | Reference terminal output | `#terminalSelection what's this error?` |
| `#problems` | Access editor errors | `Fix the issues in #problems` |

## Tools

Tools extend what Copilot can do. Access them via the **Configure Tools** button in Agent mode.

### Built-in tools

| Tool | Description |
|------|-------------|
| `#fetch` | Fetch web content |
| `#githubRepo` | Search GitHub repositories |
| `#usages` | Find code usages |
| `#changes` | Access git changes |

### MCP tools

Install additional capabilities through MCP (Model Context Protocol) servers. See [MCP Servers Guide](./mcp-servers.md) for setup and configuration.

### Slash commands

| Command | Purpose |
|---------|---------|
| `/explain` | Explain selected code |
| `/fix` | Fix errors in selection |
| `/tests` | Generate tests |
| `/new` | Create new files/projects |
| `/clear` | Clear chat history |

## Inline suggestions

While typing, Copilot suggests completions:

- Press `Tab` to accept or `Esc` to dismiss.
- Use `Alt+]` / `Option+]` for the next suggestion.
- Use `Alt+[` / `Option+[` for the previous suggestion.

Write a comment describing what you need, then press Enter to request a suggestion.

## Language models

Click the model picker in Chat to switch models:

Choose a model based on the task and compare the results against your
requirements. Available models and their performance change over time.

## Customizing Copilot

The challenge tracks use three customization types. They work together, but
each has a separate job.

### Repository Instructions

Create `.github/copilot-instructions.md` to set project-wide guidelines. Include project context, coding standards, testing requirements, and patterns to follow.

### Custom Agents

Create specialized agents in `.github/agents/` as `.agent.md` files with YAML frontmatter. Use them for role-specific judgment, reviews, and decisions that need domain context.

### Custom Skills

Create custom skills in `.github/skills/` for repeatable, multi-step workflows.
Skills are a better fit than an agent when the sequence should stay consistent
across repeated runs.

Start with the
[shared customization setup](../tracks/getting-started.md#3-draft-the-customization-trio).
It explains how to inspect the challenge, keep the three artifacts distinct,
and learn from examples without copying them.

## Security checklist

Before committing Copilot-generated code, verify:

- You understand what the code does
- No hardcoded secrets or credentials (use environment variables)
- The code validates and sanitizes inputs
- Database queries use parameters instead of string interpolation
- Error handling reports failures without leaking sensitive data
- You have reviewed SQL injection, XSS, CSRF, and authorization risks
- Tests cover the changed behavior

## Keyboard shortcuts

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Open Chat View | `Ctrl+Alt+I` | `Cmd+Shift+I` |
| Inline Chat | `Ctrl+I` | `Cmd+I` |
| Accept suggestion | `Tab` | `Tab` |
| Dismiss suggestion | `Esc` | `Esc` |
| Next suggestion | `Alt+]` | `Option+]` |
| Previous suggestion | `Alt+[` | `Option+[` |

## Next steps

- [Prompt Engineering Guide](./prompt-engineering.md) explains how to write focused requests.
- [MCP Servers Guide](./mcp-servers.md) covers external tools.

---

[Back to Home](./index.md)
