# GitHub Copilot Enterprise Hackathon

![Hackathon Banner](docs/images/hackathon-banner.jpg)

Welcome to the GitHub Copilot Enterprise 1-Day Hackathon! This repository contains **19 challenge tracks** with hands-on work that teaches your team how to use GitHub Copilot effectively.

## Hackathon Overview

This hackathon is organized into **19 challenge tracks** covering all skill levels and roles:

### Choose Your Track

- 📋 **[Challenge 0: Product Planning Track](./tracks/challenge-0-product-planning-track.md)** - Product planning, backlog management, documentation (no code)
- 🔧 **[Challenge 1: Web API Track](./tracks/challenge-1-web-api-track.md)** - REST APIs, authentication, testing
- 📊 **[Challenge 2: ML & AI Track](./tracks/challenge-2-ml-ai-track.md)** - Data analysis, ML models, feature engineering
- ☁️ **[Challenge 3: DevOps Track](./tracks/challenge-3-devops-track.md)** - Infrastructure as Code, containers, CI/CD
- 🎨 **[Challenge 4: Frontend Track](./tracks/challenge-4-frontend-track.md)** - React, TypeScript, modern UI
- 🔍 **[Challenge 5: QA & Testing Track](./tracks/challenge-5-qa-track.md)** - AI-assisted testing, test planning, Copilot for QA workflows
- 🤖 **[Challenge 6: Agentic Workflows Track](./tracks/challenge-6-agentic-workflows-track.md)** - Build AI-powered repository automation with GitHub Agentic Workflows
- 🧩 **[Challenge 7: Copilot SDK Track](./tracks/challenge-7-copilot-sdk-track.md)** - Build a Copilot SDK application (advanced)
- ✈️ **[Challenge 8: Flight Delay Predictor Track](./tracks/challenge-8-flight-delay-track.md)** - Full-stack ML app (advanced)
- 🏢 **[Challenge 9: Cross-Functional Team Sprint](./tracks/challenge-9-team-sprint-track.md)** - Full team agile sprint, ideation to deployment (4-6 people)
- 🥾 **[Challenge 10: Technical Team Sprint](./tracks/challenge-10-tech-sprint-track.md)** - Technical team sprint from spec to deployment (2-4 developers)
- 🏦 **[Challenge 11: Legacy MUMPS Modernization](./tracks/challenge-11-mumps-modernization-track.md)** - Reverse-engineer and translate a MUMPS banking system (solo, advanced)
- 🔄 **[Challenge 12: Legacy Code Modernization](./tracks/challenge-12-legacy-modernization-track.md)** - Reverse-engineer and modernize an undocumented Java application
- 📄 **[Challenge 13: Living Documentation](./tracks/challenge-13-living-docs-track.md)** - Automate javadoc, diagrams, changelogs, and PR doc reviews
- 🔩 **[Challenge 14: Pipeline Factory](./tracks/challenge-14-pipeline-factory-track.md)** - Build CI/CD pipelines, debug broken deployments, generate runbooks
- 📝 **[Challenge 15: Backlog Generator](./tracks/challenge-15-backlog-generator-track.md)** - Convert requirement specs into structured backlogs with MCP
- 🖥️ **[Challenge 16: Ops Assistant](./tracks/challenge-16-ops-assistant-track.md)** - Build AI-assisted log analysis, incident routing, and ops tooling
- 🚀 **[Challenge 17: Spec-to-Ship Accelerator](./tracks/challenge-17-spec-to-ship-track.md)** - Full lifecycle from functional spec to deployed code
- 🏗️ **[Challenge 18: COBOL Banking Modernization](./tracks/challenge-18-cobol-modernization-track.md)** - Reverse-engineer and modernize a COBOL banking system into a full-stack web app
- 🔧 **[Challenge 19: WCF Banking Modernization](./tracks/challenge-19-wcf-modernization-track.md)** - Understand a legacy WCF SOAP banking service and migrate it to a REST API

**[View All Tracks & Choose Yours](./tracks/README.md)**

Each track provides a curated path through the challenges based on your role, with specific guidance, tips, and learning objectives.

## Duration

**6-8 hours** per track.

## Documentation Site

The repository can publish its markdown guides as an MkDocs site through GitHub Pages.

For a local docs build:

```bash
python -m venv .venv-docs
. .venv-docs/bin/activate
python -m pip install -r requirements-docs.txt
mkdocs build --strict
```

The site uses the linked markdown under `docs/` as its source, with navigation ordered around challenge selection, setup, challenge tracks, and shared reference docs.

The GitHub Pages deployment workflow builds the same site from `mkdocs.yml`.

## Getting Started

### Step 1: Choose Your Track

**Not sure which track?** See the **[Track Selection Guide](./tracks/README.md)** for help choosing.

### Step 2: Set Up Environment

#### Prerequisites

- GitHub account with Copilot access
- GitHub Codespaces enabled (recommended) OR
- Local development environment with VS Code and GitHub Copilot extension

#### Start Hacking

**Option A: GitHub Codespaces (Recommended)**

1. Click the green **"Code"** button at the top of this repository.
2. Select the **"Codespaces"** tab.
3. Click **"Create codespace on main"**.
4. Wait for the environment to set up (2-3 minutes).

**Option B: Local Development**

1. Clone this repository:

   ```bash
   git clone https://github.com/martaldsantos/gh-copilot-for-enterprise.git
   cd gh-copilot-for-enterprise
   ```

2. Open the folder in VS Code.
3. When prompted, click **"Reopen in Container"** (requires Docker and Dev Containers extension).

The environment is pre-configured with:

- Node.js (LTS)
- Python 3.11
- Docker
- Terraform
- kubectl
- All necessary VS Code extensions

### Step 3: Clean Start (CRITICAL)

The `.github/` directory contains instructions, agents, and skills used by the hackathon organizers. Run the cleanup script to reset it before you begin.

**Linux / macOS / Codespaces:**

```bash
./scripts/clean-start.sh
```

**Windows (PowerShell):**

```powershell
.\scripts\clean-start.ps1
```

This empties `.github/copilot-instructions.md`, removes existing agents and skills, and detaches the git remote so you don't accidentally push to the template repo. After running the script, add your own project-specific instructions (see your Track guide for examples).

### Step 4: Verify Your Setup

Before starting, make sure Copilot is working:

**Check Copilot Status:**

- Look at the bottom-right of VS Code
- Copilot icon should be visible and say "Ready"

**Test Inline Suggestions:**

1. Create a new file (e.g., `test.js`)
2. Type: `// function to add two numbers`
3. You should see Copilot suggestions appear!

**Test Chat:**

1. Press `Ctrl+Shift+I` (Windows/Linux) or `Cmd+Shift+I` (Mac)
2. Type: "Hello, are you working?"
3. Copilot should respond!

### Step 5: Start Your Track

Once your environment is ready:

1. Open your chosen track guide (e.g., `tracks/challenge-1-web-api-track.md`)
2. Follow the recommended challenge sequence
3. Use the track-specific tips and guidance

## Key GitHub Copilot Features You'll Learn

Throughout these challenges, you'll master:

### 1. **Chat & Agentic Capabilities**

- `/explain`, `/fix`, `/tests` commands
- **Agentic Mode** - Autonomous multi-step task execution
- **Planning Mode** - High-level architectural reasoning
- Workspace context chat

### 2. **Prompt Engineering**

- Effective prompt patterns
- Context-aware requests
- Iterative refinement
- Collections and reusable prompts

### 3. **Extensibility & Custom Agents**

- **MCP Servers** - Connect external tools and data
- **Custom Agents** - Build and use specialized assistants
- Enhanced context for Copilot

### 4. **Inline Suggestions**

- Code completion
- Multi-line suggestions
- Ghost text navigation

## Challenges

**Tip:** Instead of choosing challenges individually, we recommend following a [role-based track](./tracks/README.md) for a structured learning experience!

All 19 challenges are available, and each track has a dedicated challenge:

### [Challenge 0: Product Planning -- TaskFlow v2.0](./challenges/challenge-0-product-planning/) ([Track](./tracks/challenge-0-product-planning-track.md))

**Team**: Product Owners, Business Analysts, Project Managers
**Skills**: Markdown, GitHub Issues, GitHub Projects, Pull Requests
**Copilot Focus**: Long-form writing, brainstorming, GitHub MCP server for issue/PR management

Plan the next major release of a task management platform across 5 progressive stages. Start with competitive analysis and quantified personas, then write and critique user stories, build feature specs aligned to real API endpoints, resolve conflicting stakeholder requests under a fixed budget, and produce a production-grade release plan with risk matrices, rollback strategies, and monitoring specs. No application code required.

---

### [Challenge 1: Web Development - REST API Builder](./challenges/challenge-1-web-api/) ([Track](./tracks/challenge-1-web-api-track.md))

**Team**: Backend/Web Developers
**Skills**: Express.js/FastAPI, API design, error handling, testing
**Copilot Focus**: Inline completion, `/tests` command, workspace chat

Build a task management REST API across 5 progressive stages: basic CRUD, JWT authentication with role-based access, SQLite persistence with data relationships, debugging a broken v2 API module (3 intentional bugs), and production readiness with load testing, caching, and structured logging.

---

### [Challenge 2: ML/AI - Data Analysis & Model Development](./challenges/challenge-2-ml-ai/) ([Track](./tracks/challenge-2-ml-ai-track.md))

**Team**: Data Scientists, ML Engineers
**Skills**: Python, pandas, scikit-learn, data visualization
**Copilot Focus**: Jupyter notebooks integration, `/explain` for algorithms, code generation

Predict customer churn across 5 stages: discover 7+ hidden data quality issues, create visualizations with statistical hypothesis testing, train models with cost-sensitive evaluation using sklearn Pipelines, compare imbalance techniques with SHAP interpretability, and deploy a prediction API with drift detection and a model card.

---

### [Challenge 3: DevOps - Infrastructure as Code](./challenges/challenge-3-devops/) ([Track](./tracks/challenge-3-devops-track.md))

**Team**: DevOps, Platform Engineers
**Skills**: Terraform, Docker, Kubernetes, CI/CD
**Copilot Focus**: Infrastructure patterns, documentation generation, best practices

Build infrastructure for a Node.js app across 5 stages: multi-stage Dockerfile with Docker Compose, Kubernetes with HPA and NetworkPolicy, Terraform for Azure (ACR, AKS) with variables and remote state, debug a broken Key Vault module and add observability, then create a CI/CD pipeline with blue/green deployment and a DR runbook.

---

### [Challenge 4: Frontend - Interactive UI Components](./challenges/challenge-4-frontend/) ([Track](./tracks/challenge-4-frontend-track.md))

**Team**: Frontend Developers
**Skills**: React, TypeScript, Component design, State management
**Copilot Focus**: Component scaffolding, TypeScript types, CSS styling

Build a task dashboard across 5 stages: responsive layout with React Router, state management with Context/useReducer and undo support, drag-and-drop Kanban with keyboard shortcuts and themes, find and fix 5 accessibility violations in a pre-built component, then integrate with a REST API and achieve >80% test coverage.

---

### [Challenge 5: QA & Test Automation](./challenges/challenge-5-qa/) ([Track](./tracks/challenge-5-qa-track.md))

**Team**: QA Engineers, Quality Assurance Specialists, Manual Testers
**Skills**: Test planning, test case design, bug reporting (no coding experience required)
**Copilot Focus**: AI-assisted test generation, Playwright MCP exploration, Copilot-driven debugging

Test the eShop application across 5 stages: explore the app with Copilot and Playwright MCP to build a test plan, use Copilot to debug and generate your first automated tests, expand coverage across browsers with Copilot-generated page objects, compare AI-driven vs human-guided testing approaches, then build reporting and a test strategy document.

---

### [Challenge 7: Copilot SDK -- Release Notes Agent](./challenges/challenge-7-copilot-sdk/) ([Track](./tracks/challenge-7-copilot-sdk-track.md))

**Team**: Experienced developers (any role) who finished a standard track
**Duration**: 8-12 hours (Advanced)
**Skills**: Node.js, TypeScript, Copilot SDK, GitHub API, custom tool definitions
**Copilot Focus**: Building *with* the Copilot agent runtime -- sessions, streaming, custom tools, MCP integration

Build a Release Notes Agent powered by the GitHub Copilot SDK. The agent fetches merged PRs, categorizes changes, generates a structured changelog through iterative conversation, and publishes a draft GitHub Release -- all using custom tools, streaming responses, and multi-turn sessions.

> ⚠️ **Challenge 7 is significantly harder and longer than the standard challenges.**

---

### [Challenge 8: Full-Stack Flight Delay Predictor](./challenges/challenge-8-flight-delay/) ([Track](./tracks/challenge-8-flight-delay-track.md))

**Team**: Full-Stack Developers, Advanced Participants
**Duration**: 8-12 hours (extended challenge)
**Skills**: Python, pandas, scikit-learn, Flask/FastAPI, TypeScript, frontend frameworks
**Copilot Focus**: End-to-end development -- data science in notebooks, API scaffolding, frontend generation, cross-domain debugging

Build a complete application that predicts flight delay probability. Explore a real FAA dataset, train an ML model, serve it through a REST API, and create a frontend where users select a day and airport to see their delay risk.

---

### [Challenge 9: Cross-Functional Team Sprint (CityPulse)](./challenges/challenge-9-team-sprint/) ([Track](./tracks/challenge-9-team-sprint-track.md))

**Team**: Cross-functional team of 4-6 (Product Owner, Backend Dev, Frontend Dev, QA, DevOps, optional BA)
**Duration**: 8 hours (team challenge)
**Skills**: GitHub Spark, GitHub Issues/Projects, Express.js/FastAPI, React/Vue, Playwright, Docker, Azure, Terraform
**Copilot Focus**: Every role uses Copilot -- PO for user stories and planning, developers for code generation, QA for test automation, DevOps for infrastructure

Build CityPulse, a civic engagement platform, from scratch as a cross-functional team running a simulated agile sprint. The PO ideates with GitHub Spark and manages the backlog via GitHub Issues while developers, QA, and DevOps work in parallel across two sprints -- building a REST API, a frontend UI, automated tests, CI/CD pipelines, and deploying to Azure. Ends with a team demo and retrospective.

> This challenge requires a team. It is not designed for solo participants.

---

### [Challenge 10: Technical Team Sprint (TrailMate)](./challenges/challenge-10-tech-sprint/) ([Track](./tracks/challenge-10-tech-sprint-track.md))

**Team**: Technical team of 2-4 (Backend Dev, Frontend Dev, DevOps required; QA optional -- no PO or BA)
**Duration**: 8 hours (team challenge)
**Skills**: Express.js/FastAPI, React/Vue, Playwright, Docker, Azure, Terraform, GitHub Issues/Projects
**Copilot Focus**: Every technical role uses Copilot -- developers for code generation, QA for test automation, DevOps for infrastructure

Build TrailMate, a trail management platform for a regional parks authority, from a provided functional specification. Unlike the Cross-Functional Team Sprint, there is no product discovery phase and no business stakeholders. The team reads the spec, writes a technical specification, breaks work into GitHub Issues, and self-organizes across two sprints -- building a REST API, a frontend UI, automated tests, CI/CD pipelines, and deploying to Azure. Ends with a team demo and retrospective.

> This challenge requires a team. It is not designed for solo participants.

---

### [Challenge 11: Legacy MUMPS Modernization](./challenges/challenge-11-mumps-banking/) ([Track](./tracks/challenge-11-mumps-modernization-track.md))

**Team**: Solo or pair (any developer role)
**Duration**: 8-12 hours (Advanced)
**Skills**: Any modern language (PSL, Java, Python, C#, TypeScript), reverse engineering, testing, financial domain knowledge
**Copilot Focus**: Legacy code comprehension with `/explain`, cross-language translation, characterization test generation, architecture documentation

Reverse-engineer and translate a core banking system written in MUMPS -- a language most developers have never seen. The system handles customer management, deposit accounts, teller transactions, consumer loans, interest calculation, and end-of-day batch processing across 12 routines and ~2,500 lines of code. Understand it, test it, extend it, and translate it to a modern language while preserving every business rule.

---

### [Challenge 12: Legacy Code Modernization](./challenges/challenge-12-legacy-modernization/) ([Track](./tracks/challenge-12-legacy-modernization-track.md))

**Team**: Solo or pair (Java developers)
**Duration**: 6-8 hours
**Skills**: Java 8/17, Spring Boot, Maven, REST APIs, SQL
**Copilot Focus**: Legacy code comprehension with `/explain`, security auditing, characterization testing, framework migration

Reverse-engineer and modernize the Acme Bank Account Manager -- an undocumented Java 8 / Spring Boot 1.5 banking application built by a contractor who left in 2018. The code has SQL injection vulnerabilities, deprecated libraries (Log4j 1.x, Apache HttpClient 4.x), no service layer, no tests, and business logic buried in controllers. Recover the business rules, audit for security issues, write characterization tests, and migrate to Spring Boot 3.x / Java 17+.

---

### [Challenge 13: Living Documentation](./challenges/challenge-13-living-docs/) ([Track](./tracks/challenge-13-living-docs-track.md))

**Team**: Solo or pair (Java developers, tech leads)
**Duration**: 6-8 hours
**Skills**: Java, Javadoc, Mermaid diagrams, Markdown
**Copilot Focus**: Bulk javadoc generation, architecture diagram creation, custom prompts for changelogs, custom agents for PR documentation review

Automate the documentation of the Widget Corp Inventory Manager -- a Java application with stale javadoc, a changelog that stopped being updated two versions ago, and zero architecture diagrams. Generate accurate javadoc, create Mermaid diagrams for architecture and data model, build a changelog prompt that works from code diffs, and create an agent that reviews PRs for documentation completeness.

---

### [Challenge 14: Pipeline Factory](./challenges/challenge-14-pipeline-factory/) ([Track](./tracks/challenge-14-pipeline-factory-track.md))

**Team**: Solo or pair (DevOps, platform engineers, developers)
**Duration**: 6-8 hours
**Skills**: GitHub Actions, Node.js, Shell scripting, CI/CD concepts
**Copilot Focus**: Workflow generation, `/fix` for debugging broken deployments, reusable workflow design, incident runbook prompts

Build CI/CD pipelines for TaskBoard, a kanban app that currently deploys via a shell script with commented-out scp commands. Create GitHub Actions workflows, debug 5 deliberate bugs in a broken staging deployment, build reusable workflow templates, and generate deployment gates with rollback mechanisms and incident runbooks.

---

### [Challenge 15: Backlog Generator](./challenges/challenge-15-backlog-generator/) ([Track](./tracks/challenge-15-backlog-generator-track.md))

**Team**: Solo or pair (product owners, tech leads, scrum masters)
**Duration**: 6-8 hours (no code required)
**Skills**: Agile concepts (Epics, Stories, Acceptance Criteria), Jira/Confluence (optional)
**Copilot Focus**: Custom prompts for spec-to-backlog conversion, custom agents for refinement, Atlassian Rovo MCP server for Jira/Confluence integration

Convert three use case specifications of increasing complexity (Password Reset, Notification Preferences, Inventory Reorder) into structured backlogs. Build a reusable prompt that produces Epics, Stories, Tasks, and Test Cases following INVEST criteria. Create a refinement agent that reviews generated backlogs for gaps. Optionally push items directly to Jira using the Atlassian MCP server.

---

### [Challenge 16: Ops Assistant](./challenges/challenge-16-ops-assistant/) ([Track](./tracks/challenge-16-ops-assistant-track.md))

**Team**: Solo or pair (support engineers, SREs, ops teams)
**Duration**: 6-8 hours
**Skills**: Log analysis concepts, incident management, basic Node.js (optional)
**Copilot Focus**: Custom agents for log analysis, custom prompts for incident routing and runbook generation, error-to-plain-language translation

Build AI-assisted operations tooling for the Order Gateway -- a critical e-commerce service. Analyze two days of production logs containing payment timeouts, database deadlocks, connection pool exhaustion, and OutOfMemoryErrors. Create a log analysis agent that explains errors in plain language for non-technical support staff, build an incident routing prompt that maps errors to responsible teams, and generate troubleshooting runbooks from historical incident data.

---

### [Challenge 17: Spec-to-Ship Accelerator](./challenges/challenge-17-spec-to-ship/) ([Track](./tracks/challenge-17-spec-to-ship-track.md))

**Team**: Solo or pair (tech leads, senior developers)
**Duration**: 6-8 hours
**Skills**: Full SDLC concepts, Node.js, GitHub Actions
**Copilot Focus**: End-to-end prompt chain -- spec to backlog to technical analysis to code to tests to CI pipeline, custom agents for test specification

Compress the full development lifecycle for a billing module on an existing multi-tenant SaaS platform. Start with a functional requirements document and an existing tenant management API. Build prompts that convert the spec into work items, generate a technical analysis against the existing codebase, implement the billing module from generated stories, create test specifications with a custom agent, and wire up a CI pipeline -- all producing reusable Copilot artifacts.

---

### [Challenge 18: COBOL Banking Modernization](./challenges/challenge-18-cobol-banking/) ([Track](./tracks/challenge-18-cobol-modernization-track.md))

**Team**: Solo or pair (any developer role)
**Duration**: 8-12 hours (Advanced)
**Skills**: COBOL (no prior experience needed), Node.js/TypeScript or Java, React, reverse engineering, testing
**Copilot Focus**: Legacy code comprehension with `/explain`, cross-language translation, characterization test generation, full-stack modernization

Reverse-engineer and modernize a core banking system written in COBOL -- the language that still runs the majority of the world's banking transactions. The system handles customer management, deposit accounts, teller transactions, consumer loans, interest calculation, and end-of-day batch processing. Understand the code, build characterization tests, extend it with new features, and translate it into a modern React + Node.js/Java web application while preserving every business rule.

---

### [Challenge 19: WCF Banking Modernization](./challenges/challenge-19-wcf-banking/) ([Track](./tracks/challenge-19-wcf-modernization-track.md))

**Team**: Solo or pair (.NET developer)
**Duration**: 6-10 hours (Intermediate to Advanced)
**Skills**: C#, WCF/SOAP concepts, ASP.NET Core Web API, REST design, xUnit
**Copilot Focus**: SOAP service contract comprehension, fault contract analysis, REST migration, characterization testing

Reverse-engineer a legacy WCF banking service (Meridian Savings Bank) built circa 2010-2012, now running on CoreWCF and .NET 8. Understand the service contracts, data contracts, and fault conditions, then port the business logic to a REST API using ASP.NET Core Web API. The service has real bugs to find and real decisions to make about whether to preserve or fix them during migration.

---

## Learning Resources

### Examples & Templates

> **[github/awesome-copilot](https://github.com/github/awesome-copilot)** - A curated collection of real-world examples including:
> - Custom instruction files (`.github/copilot-instructions.md`)
> - Custom agent templates (`.github/agents/`)
> - Reusable prompt files (`.github/prompts/`)
> - Best practices and patterns

### GitHub Copilot Documentation

- [Copilot Guide](./docs/copilot-guide.md)
- [Prompt Engineering Guide](./docs/prompt-engineering.md)
- [MCP Servers Guide](./docs/mcp-servers.md)

### Quick Tips

**Getting the Most from Copilot:**

1. **Be Specific**: Detailed prompts yield better results
2. **Provide Context**: Reference existing code and patterns
3. **Iterate**: Refine suggestions through conversation
4. **Use Chat Commands**: Use `/explain`, `/fix`, `/tests`, and natural language for documentation
5. **Review Suggestions**: Always understand generated code
6. **Keyboard Shortcuts**:
 - `Tab` - Accept suggestion
 - `Esc` - Dismiss suggestion
 - `Alt+]` - Next suggestion
 - `Alt+[` - Previous suggestion
 - `Ctrl+Shift+I` - Open Copilot Chat

### Tips for Success

1. **Write Clear Comments**

   ```javascript
   // ❌ Bad: "do stuff"
   // ✅ Good: "Validate email format and return true if valid, false otherwise"

   ```

2. **Use Chat Freely** - Ask Copilot: "What does this code do?", "How can I improve this?"

3. **Review Everything** - Understand all generated code, test thoroughly

4. **Iterate** - First suggestion not perfect? Refine your prompt or try different approaches

### Common Issues

| Problem | Solution |
|---------|----------|
| Copilot not suggesting | Check status icon, ensure signed in, restart VS Code |
| Wrong suggestions | Be more specific, provide more context, try chat instead |
| Environment issues | Codespaces: rebuild container; Local: check tool versions |

## Hackathon Format

### Track-Based Learning (Recommended)

**Choose a track** based on your role and follow the curated path:

- Each track provides a recommended sequence of challenges
- Track-specific tips and guidance
- Clear learning objectives
- Estimated time for completion

See **[Tracks Overview](./tracks/README.md)** to choose your path.

### Alternative: Individual Challenges

Prefer to explore on your own?

- Choose 2-3 challenges based on your interests
- Each challenge includes starter code and objectives
- Progressive difficulty with bonus tasks

### Team Showcase (1-2 hours)

- Present your solutions
- Share interesting Copilot interactions
- Discuss productivity gains and learnings
- Compare experiences across different tracks

### Best Practices Session (1 hour)

- Review common patterns
- Share tips and tricks discovered
- Q&A with Copilot experts

## Success Metrics

Track your progress:

- [ ] Chose and started your track
- [ ] Completed at least 2 challenges (or all required challenges in your track)
- [ ] Used all major chat commands (`/explain`, `/fix`, `/tests`)
- [ ] Created reusable prompt collections
- [ ] Documented learnings and productivity wins
- [ ] Can explain Copilot's impact on your workflow

## Collaboration

- Use GitHub Issues to ask questions
- Share discoveries in Discussions
- Help teammates learn new Copilot features
- Document your journey in your challenge folders

## Feedback

After completing the hackathon, please share:

- What worked well
- What could be improved
- Productivity improvements you experienced
- Features you found most valuable

## Next Steps

After the hackathon:

1. Apply Copilot to your daily work
2. Explore advanced features and settings
3. Create team-specific prompt collections
4. Share knowledge with your organization
5. Measure and track productivity improvements

## Support & Resources

### Quick Links

- **[Choose Your Track](./tracks/README.md)** - Role-based learning paths
- **[Troubleshooting Guide](./TROUBLESHOOTING.md)** - Common issues and solutions
- **[Facilitator Guide](./FACILITATOR_GUIDE.md)** - For hackathon organizers
- **[Contributing Guide](./CONTRIBUTING.md)** - Help improve this content

### Need Help?

- **Which track?** See [Track Selection Guide](./tracks/README.md)
- **Technical Issues**: Check [Troubleshooting Guide](./TROUBLESHOOTING.md)
- **Copilot Questions**: Use Copilot Chat in VS Code
- **General Help**: Review the `/docs` folder
- **Found a Bug**: Create an issue in this repository

---

**Getting started:**

1. [Choose Your Track](./tracks/README.md)
2. Follow the [Setup Instructions](#step-2-set-up-environment) above
3. [Verify Your Setup](#step-4-verify-your-setup)
4. Start your first challenge!
