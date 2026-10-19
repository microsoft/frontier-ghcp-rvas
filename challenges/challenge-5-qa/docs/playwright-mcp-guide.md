# Playwright MCP Integration Guide

Use the **Microsoft Playwright MCP Server** with GitHub Copilot to explore web
applications and generate tests.

## What is Playwright MCP?

The **Playwright MCP Server** (`@playwright/mcp`) is an official Microsoft package that implements the Model Context Protocol, allowing AI assistants like GitHub Copilot to control a browser, navigate pages, and interact with web elements using structured accessibility snapshots.

## Setup Instructions

### 1. Run the MCP Server

Run the Playwright MCP server directly with npx. No installation is needed:

```bash
npx @playwright/mcp@latest
```

### 2. Configure VS Code

Add to your VS Code settings (`.vscode/mcp.json`):

```json
{
  "servers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

Or install via VS Code CLI:

```bash
code --add-mcp '{"name":"playwright","command":"npx","args":["@playwright/mcp@latest"]}'
```

### 3. Restart VS Code

After adding the configuration, restart VS Code for the MCP server to be recognized.

## Advanced Configuration

You can customize the Playwright MCP server with a config file:

```bash
npx @playwright/mcp@latest --config path/to/config.json
```

Example config file:

```json
{
  "browser": {
    "browserName": "chromium",
    "launchOptions": {
      "headless": false
    }
  },
  "capabilities": ["tabs", "pdf", "vision"]
}
```

### Available Capabilities

- `tabs` - Tab management
- `install` - Browser installation
- `pdf` - PDF generation
- `vision` - Coordinate-based interactions

## Using AI-Driven Testing

### Exploration Commands

Ask Copilot to explore your application:

```text
Navigate to http://localhost:3000 and describe the main navigation elements.
```

```text
Go to the login page and list all form fields and buttons you find.
```

```text
Navigate through the main user flows and identify potential test scenarios.
```

### Test Generation Commands

Ask Copilot to generate tests based on what it observes:

```text
Navigate to the dashboard and generate Playwright tests for the widgets you see.
```

```text
Explore the settings page and create tests for form validation.
```

### Bug Hunting Commands

Ask Copilot to check for potential issues:

```text
Navigate through the checkout flow and report any usability issues.
```

```text
Test the form validation by entering invalid data and report the behavior.
```

## Best Practices

1. **Start with exploration**: Let the AI understand the application structure first
2. **Review generated tests**: AI-generated tests are a starting point, not the final product
3. **Improve selectors**: Replace fragile selectors with more robust data-testid attributes
4. **Add meaningful assertions**: Ensure tests verify actual business requirements
5. **Combine with manual tests**: Use AI for coverage, manual for complex scenarios

## Troubleshooting

### MCP Server Not Recognized

- Ensure VS Code is restarted after configuration
- Check that the package is installed globally: `npm list -g @modelcontextprotocol/server-playwright`
- Verify the settings.json syntax is correct

### Browser Issues

- Run `npm install` to ensure Playwright dependencies are installed from the `challenges/challenge-5-qa` directory
- Run `npx playwright install-deps` to install OS-level dependencies for browsers
- Run `npx playwright install` to ensure browsers are installed
- Check for firewall or proxy issues blocking browser downloads

### Timeout Issues

- Increase timeout in playwright.config.ts
- Ensure the application is running before starting tests
