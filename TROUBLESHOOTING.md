# Troubleshooting guide

Use this guide to diagnose setup and Copilot problems.

## GitHub Copilot issues

### Copilot not showing suggestions

**Symptoms:**

- No gray text appearing as you type
- No inline suggestions

**Solutions:**

1. Click the Copilot icon at the bottom right of VS Code. Check for "Ready".
2. If signed out, select "Sign in to GitHub", authenticate, and restart VS Code.
3. Open Extensions with `Ctrl+Shift+X`. Check that GitHub Copilot and GitHub
   Copilot Chat are installed.

4. **Enable Inline Suggestions**

   ```json
   // Settings (Ctrl+,)
   "editor.inlineSuggest.enabled": true

   ```

5. Close and reopen VS Code, then wait 30 seconds.
6. Check your internet connection by opening <https://github.com>.

### Copilot chat not responding

**Symptoms:**

- Chat window opens but nothing happens
- "Thinking..." never completes

**Solutions:**

1. Open the command palette with `Ctrl+Shift+P` and run "Developer: Reload Window".
2. Check that Copilot is signed in and has no error status.
3. Try inline chat with `Ctrl+I` in the editor.
4. Clear chat history with the trash icon and start a new conversation.

### Suggestions not relevant

**Symptoms:**

- Copilot suggests wrong code
- Suggestions don't match intent

**Solutions:**

1. **Be More Specific**

   ```javascript
   // ❌ Vague
   // create function
   
   // ✅ Specific
   // Create async function to fetch user data from API endpoint /api/users/:id
   // Return user object or throw error if not found

   ```

2. Provide type hints, reference existing patterns, and include example inputs
   and outputs.
3. Explain the expected behavior in Copilot Chat. Refine the request when the
   response misses a requirement.
4. Add the relevant imports and types to the current file.

### Copilot using old patterns

**Symptoms:**

- Suggests deprecated syntax
- Not using latest features

**Solutions:**

1. **Explicitly Request Modern Syntax**

   ```javascript
   // Use modern ES6+ syntax with async/await and destructuring

   ```

2. **Show Example**

   ```python

   # Use this modern pattern:
   def example():
       return [x for x in range(10)]
   
   # Now create similar function for...

   ```

3. **Specify Versions**

   ```javascript
   // Using React 18 hooks and TypeScript 5.0

   ```

## Codespaces issues

### Codespace won't start

**Symptoms:**

- "Creating..." never completes
- Error during creation

**Solutions:**

1. Allow at least five minutes for creation. Do not refresh while it runs.
2. If creation remains stuck, delete the failed Codespace and create another.
3. Check your available hours at <https://github.com/settings/billing>.
4. Try Chrome or Edge with browser extensions disabled.

### Codespace is slow

**Symptoms:**

- Laggy typing
- Delayed responses

**Solutions:**

1. Check your connection speed and stability.
2. Close unused tabs and other Codespaces.
3. Run "Codespaces: Rebuild Container" from the command palette and wait for completion.
4. If needed, stop the Codespace, select a larger machine type, and restart it.

### Extensions not loading

**Symptoms:**

- Copilot extension missing
- Configured extensions not installed

**Solutions:**

1. Wait 2-3 minutes for the post-create script. Check the terminal for completion.
2. Search Extensions for "GitHub Copilot" and install it if missing.
3. If configured extensions still fail, run "Codespaces: Rebuild Container".

## Challenge-specific issues

### Challenge 1: Web API

**Port Already in Use**

```bash

# Error: Port 3000 already in use

# Solution: Use different port
PORT=3001 npm run dev

```

**Dependencies Won't Install**

```bash

# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install

```

**Database Connection Failed**

```text

# Using in-memory storage for the session

# No external database needed

# Check models/data.js is imported correctly

```

### Challenge 2: ML/AI

**Jupyter Not Starting**

```bash

# Install Jupyter
pip install jupyter

# Start manually
jupyter notebook

```

**Import Errors**

```bash

# Install requirements
pip install -r requirements.txt

# Or individually
pip install pandas numpy scikit-learn matplotlib

```

**Dataset Not Found**

```bash

# Generate the dataset first
python generate_dataset.py

# Check file exists
ls -la customer_churn.csv

```

### Challenge 3: DevOps

**Terraform Init Fails**

```bash

# Check Terraform installed
terraform --version

# If not in Codespace, install:

# Download from terraform.io

```

**Docker Build Fails**

```bash

# Check Docker running
docker --version
docker ps

# In Codespace, Docker-in-Docker is enabled

# May need to wait for startup

```

**Azure Credentials Missing**

```text

# For this session: No real Azure deployment needed

# Terraform validate/plan only

# Don't actually apply!

```

### Challenge 4: Frontend

**Node Modules Issues**

```bash

# Clean install
rm -rf node_modules package-lock.json
npm install

# If still fails, check Node version
node --version  # Should be 18+

```

**Vite Dev Server Won't Start**

```bash

# Port might be in use
npm run dev -- --port 3001

# Or kill process on port
lsof -ti:3000 | xargs kill -9

```

**TypeScript Errors**

```bash

# Check tsconfig.json exists

# Reload VS Code window

# Ctrl+Shift+P → "TypeScript: Restart TS Server"

```

### Challenge 5: QA

**Playwright Not Found**

```bash

# Install Playwright
npm install @playwright/test
npx playwright install

```

**Browser Launch Issues**

```text

1. Ensure browsers are installed: npx playwright install
2. Verify server starts: node mcp-servers/github-server.js
3. Check for errors in server output
4. Restart VS Code

```

**Tools Not Appearing**

```text

1. Check ListToolsRequestSchema handler
2. Verify tool schema format
3. Check server logs for errors
4. Restart MCP server

```

## General development issues

### VS Code performance

**Slow Performance**

1. Disable unused extensions
2. Close unused files
3. Disable file watchers for large directories
4. Increase memory limit

**High CPU Usage**

```json
// Settings
"files.watcherExclude": {
  "**/node_modules/**": true,
  "**/.git/**": true
}

```

### Git issues

**Permission Denied**

```bash

# Configure git
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

```

**Merge Conflicts**

```bash

# During the session, you likely won't push

# If you do and get conflicts:
git stash
git pull
git stash pop

# Resolve conflicts

```

### Terminal issues

**Command Not Found**

```bash

# Check if in correct directory
pwd

# Verify tool installed
which node
which python
which terraform

```

**Permission Denied**

```bash

# Make script executable
chmod +x script.sh

# Or run with interpreter
bash script.sh

```

## Getting help

### Self-help steps

1. Read the full error and copy it for searching.
2. Search this guide with `Ctrl+F`.
3. Give Copilot the error and describe what you were trying to do.

```text
   Open Copilot Chat (Ctrl+Shift+I):
   "I'm getting this error: [paste error]
    How do I fix it?"

   ```

4. Check the track guide, tool documentation, and GitHub issues.

### During the session

1. Post the error and relevant context in the session's Slack or Teams channel.
2. Ask a facilitator and share your screen if needed.
3. Pair with another participant to trace the failure.

### Emergency fallback

**If All Else Fails:**

1. Try another challenge while the blocker is resolved.
2. Use the prepared local environment if Codespaces is unavailable, or vice versa.
3. Continue the parts you can run and record the blocked work.

## Prevention tips

**Do:**

- Save work frequently
- Commit small changes
- Test incrementally
- Read error messages
- Ask early when stuck

**Don't:**

- Make many changes at once
- Ignore warnings
- Skip documentation
- Work in isolation when stuck

## Still stuck?

If this guide doesn't help:

1. Create an issue with the error, reproduction steps, and fixes you have tried.
2. Contact the organizers through the session channel.
3. Record the solution once found so others can reuse it.

---

[Back to Main](./docs/index.md) | [Tracks](./tracks/README.md)
