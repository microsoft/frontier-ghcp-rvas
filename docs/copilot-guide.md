# GitHub Copilot Guide

## What is GitHub Copilot?

GitHub Copilot is an AI assistant built into VS Code. In Agent mode it reads files, runs terminal commands you approve, catches errors, and retries -- handling multi-step tasks with less back-and-forth than inline completions alone.

## Three Ways to Interact

| Method | Access | Best For |
|--------|--------|----------|
| **Chat View** | `Ctrl+Alt+I` (Win/Linux) / `Cmd+Shift+I` (Mac) | Complex tasks, multi-file changes |
| **Inline Chat** | `Ctrl+I` / `Cmd+I` | Quick edits within a file |
| **Inline Suggestions** | Automatic as you type | Code completions while coding |

## Agents

Agents define how Copilot behaves during a conversation. VS Code includes four built-in agents:

| Agent | Description | Best For |
|-------|-------------|----------|
| **Agent** | Full autonomous mode -- edit files, run commands, self-correct | Multi-file implementations, complex tasks |
| **Plan** | Read-only planning mode | Architecture decisions, task planning |
| **Ask** | Q&A mode for questions and explanations | Learning, understanding code, research |
| **Edit** | Focused file editing with inline changes | Quick edits to specific files |

Switch agents by clicking the agent picker dropdown in the Chat view.

### Agent Mode

Agent mode is Copilot's most capable mode. It can:

- Create and modify multiple files
- Run terminal commands automatically
- Recognize errors and fix them
- Iterate until your task is complete
- Infer additional work needed

When Agent makes changes, review them inline in the editor. Accept good changes, reject others, and ask for modifications. Use Chat's undo to revert if needed.

### Tool Approvals

Agent requests permission before modifying files, running terminal commands, or invoking MCP tools. Approval options:

- **Allow** -- run once
- **Allow for Session** -- run during this session
- **Allow for Workspace** -- always allow in this workspace
- **Skip** -- don't run this tool

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

## Adding Context with # Mentions

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

### Built-in Tools

| Tool | Description |
|------|-------------|
| `#fetch` | Fetch web content |
| `#githubRepo` | Search GitHub repositories |
| `#usages` | Find code usages |
| `#changes` | Access git changes |

### MCP Tools

Install additional capabilities through MCP (Model Context Protocol) servers. See [MCP Servers Guide](./mcp-servers.md) for setup and configuration.

### Slash Commands

| Command | Purpose |
|---------|---------|
| `/explain` | Explain selected code |
| `/fix` | Fix errors in selection |
| `/tests` | Generate tests |
| `/new` | Create new files/projects |
| `/clear` | Clear chat history |

## Inline Suggestions

While typing, Copilot suggests completions:

- **Accept**: Press `Tab`
- **Dismiss**: Press `Esc`
- **Next suggestion**: `Alt+]` / `Option+]`
- **Previous suggestion**: `Alt+[` / `Option+[`

Write a comment describing what you need, then press Enter -- Copilot will suggest an implementation.

## Language Models

Click the model picker in Chat to switch models:

- **GPT-4o** -- good general-purpose choice for most coding tasks
- **Claude Sonnet** -- tends to follow complex, multi-constraint instructions more precisely
- **Gemini** -- lower latency, useful when you're iterating quickly
- **o1/o3** -- slower but useful for tasks that need step-by-step logical planning (architecture decisions, algorithm design); not worth it for routine code generation

## Customizing Copilot

### Custom Instructions

Create `.github/copilot-instructions.md` to set project-wide guidelines. Include project context, coding standards, testing requirements, and patterns to follow.

### Custom Agents

Create specialized agents in `.github/agents/` as `.agent.md` files with YAML frontmatter. Define a name, description, tools, and behavioral instructions. Agents can hand off to other agents for multi-step workflows.

### Prompt Files

Create reusable prompts in `.github/prompts/` as `.prompt.md` files. Use `${input:variableName}` for dynamic inputs and `#file:path` references for context. Invoke them with `/prompt-name` in chat.

> Check out the [github/awesome-copilot](https://github.com/github/awesome-copilot) repository for examples of custom instructions, agents, and prompt files.

## Security Checklist

Before committing Copilot-generated code, verify:

- You understand what the code does
- No hardcoded secrets or credentials (use environment variables)
- Inputs are validated and sanitized
- Database queries are parameterized (no string interpolation)
- Errors are handled appropriately
- Security implications are reviewed (SQL injection, XSS, CSRF, auth bypasses)
- Tests are included or updated

## Keyboard Shortcuts

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Open Chat View | `Ctrl+Alt+I` | `Cmd+Shift+I` |
| Inline Chat | `Ctrl+I` | `Cmd+I` |
| Accept suggestion | `Tab` | `Tab` |
| Dismiss suggestion | `Esc` | `Esc` |
| Next suggestion | `Alt+]` | `Option+]` |
| Previous suggestion | `Alt+[` | `Option+[` |

## Next Steps

- [Prompt Engineering Guide](./prompt-engineering.md) -- write effective prompts
- [MCP Servers Guide](./mcp-servers.md) -- extend Copilot with external tools

---

[Back to Home](./index.md)
