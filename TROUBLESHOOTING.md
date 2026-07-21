# Troubleshooting Guide

Common issues and solutions for GitHub Copilot Adoption.

## GitHub Copilot Issues

### Copilot Not Showing Suggestions

**Symptoms:**

- No gray text appearing as you type
- No inline suggestions

**Solutions:**

1. **Check Copilot Status**
 - Look at bottom-right corner of VS Code
 - Click the Copilot icon
 - Should show "Ready" status

2. **Verify Sign-In**
 - Click Copilot icon → "Sign in to GitHub"
 - Complete authentication
 - Restart VS Code

3. **Check Extension**
 - Go to Extensions (Ctrl+Shift+X)
 - Search "GitHub Copilot"
 - Ensure both extensions installed:
 - GitHub Copilot
 - GitHub Copilot Chat

4. **Enable Inline Suggestions**

   ```json
   // Settings (Ctrl+,)
   "editor.inlineSuggest.enabled": true

   ```

5. **Restart VS Code**
 - Close completely
 - Reopen
 - Wait 30 seconds

6. **Check Internet Connection**
   - Copilot requires internet
   - Test: open <https://github.com>

### Copilot Chat Not Responding

**Symptoms:**

- Chat window opens but nothing happens
- "Thinking..." never completes

**Solutions:**

1. **Reload Window**
 - `Ctrl+Shift+P` → "Developer: Reload Window"

2. **Check Copilot Status**
 - Ensure signed in
 - Check no error icons

3. **Try Inline Chat Instead**
 - Press `Ctrl+I` in the editor
 - Sometimes more reliable

4. **Clear Chat History**
 - Click trash icon in chat
 - Start new conversation

### Suggestions Not Relevant

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

2. **Provide Context**
 - Add type hints (TypeScript, Python)
 - Reference existing patterns
 - Include example input/output

3. **Use Copilot Chat**
 - Explain your requirements in detail
 - Ask for specific implementation
 - Iterate based on response

4. **Check File Context**
 - Copilot looks at current file
 - Add relevant imports/types at top

### Copilot Using Old Patterns

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

## Codespaces Issues

### Codespace Won't Start

**Symptoms:**

- "Creating..." never completes
- Error during creation

**Solutions:**

1. **Wait and Retry**
 - Sometimes takes 5+ minutes
 - Don't refresh during creation

2. **Delete and Recreate**
 - Go to Codespaces page
 - Delete the stuck codespace
 - Create a new one

3. **Check Quota**
 - You might be out of free hours
 - Check: github.com/settings/billing

4. **Try Different Browser**
 - Chrome/Edge recommended
 - Disable browser extensions

### Codespace is Slow

**Symptoms:**

- Laggy typing
- Delayed responses

**Solutions:**

1. **Check Internet Speed**
 - Need stable connection
 - Test: speedtest.net

2. **Close Unused Tabs**
 - Each tab uses resources
 - Close other Codespaces

3. **Rebuild Container**
 - `Ctrl+Shift+P` → "Codespaces: Rebuild Container"
 - Wait for rebuild

4. **Use Larger Machine Type**
 - Stop Codespace
 - Change machine type in settings
 - Restart

### Extensions Not Loading

**Symptoms:**

- Copilot extension missing
- Configured extensions not installed

**Solutions:**

1. **Wait for Post-Create Script**
 - Takes 2-3 minutes after Codespace starts
 - Check terminal for completion

2. **Manually Install**
 - Extensions → Search "GitHub Copilot"
 - Install manually

3. **Rebuild Container**
 - `Ctrl+Shift+P` → "Codespaces: Rebuild Container"

## Challenge-Specific Issues

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

## General Development Issues

### VS Code Performance

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

### Git Issues

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

### Terminal Issues

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

## Getting Help

### Self-Help Steps

1. **Check Error Message**
 - Read the full error
 - Copy error text for searching

2. **Search This Guide**
 - Use Ctrl+F to find keywords

3. **Ask Copilot**

```text
   Open Copilot Chat (Ctrl+Shift+I):
   "I'm getting this error: [paste error]
    How do I fix it?"

   ```

4. **Check Documentation**
 - Challenge README
 - Tool documentation
 - GitHub issues

### During the Session

1. **Ask in Chat**
 - Slack/Teams channel
 - Other participants might know

2. **Flag a Facilitator**
 - They're here to help!
 - Share your screen if needed

3. **Pair with Someone**
 - Two heads better than one
 - Different perspective helps

### Emergency Fallback

**If All Else Fails:**

1. **Switch Challenges**
 - Try a different one
 - Come back later

2. **Local Instead of Codespace**
 - Or vice versa
 - Different environment might work

3. **Skip and Learn**
 - Focus on what works
 - Learn from others later

## Prevention Tips

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

## Still Stuck?

If this guide doesn't help:

1. **Create GitHub Issue**
 - Describe the problem
 - Include error messages
 - Share what you tried

2. **Contact Organizers**
 - Use provided contact method
 - Include troubleshooting steps tried

3. **Document for Others**
 - Note solution when found
 - Help improve this guide

---

Troubleshooting is part of learning.

Most issues have simple solutions. Stay calm and debug systematically!

[Back to Main](./docs/index.md) | [Tracks](./tracks/README.md)
