# Challenge 1 Track: Web API

**Duration:** 6-8 hours

**Difficulty:** ⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Building APIs and backend services with GitHub Copilot

## Who Is This For

- Backend Engineers and API Developers
- Web Service Developers
- Software Engineers focused on server-side development

## Prerequisites

- Basic knowledge of REST APIs and HTTP methods/status codes
- Familiarity with either JavaScript/Node.js or Python
- Basic testing concepts

## Technology Stack

- **Node.js** with Express.js OR **Python** with FastAPI
- JWT for authentication
- Testing frameworks (Jest/Mocha or pytest)
- OpenAPI/Swagger for documentation

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-1-web-api/` and choose either `node-express` or `python-fastapi`. Open the starter files (`app.js` or `main.py`, `models/`) to understand the structure and existing conventions before you write any instructions, then work through the stages in order.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- Project context (framework, language, architecture)
- Coding standards and conventions for your team
- Testing requirements and coverage goals
- API patterns and authentication approach
- Non-negotiable: keep the chosen framework and auth approach fixed once Copilot has scaffolded around it

### Suggested Custom Agents

- **API Developer Agent** -- Applies REST design judgment: resource modeling, status codes, and error handling conventions for a new endpoint. Give it an endpoint description; it recommends the route shape and edge cases to handle. Use it when designing an endpoint, not for writing its tests.
- **Test Writer Agent** -- Focuses on coverage judgment: which paths, edge cases, and failure modes are worth testing for a given route. Give it a working handler; it proposes a test list plus the code. Use it after a route works, to harden it.
- **Code Reviewer Agent** -- Applies a quality and security lens across the codebase: injection risks, weak validation, and inconsistent error handling. Give it a diff or file; it returns findings, not a rewrite. Use it before opening a PR.

### Suggested Custom Skills

- **Endpoint Scaffolding Skill** -- A consistent sequence for adding a new resource: route file, handler, input validation, and a matching test stub, generated in the same order every time. Use it whenever you start a new endpoint so every resource follows the same shape.
- **API Contract Sync Skill** -- A repeatable check that walks every route and compares it against the OpenAPI/Swagger spec, flagging drift and updating the spec to match. Run it after any route change, not as a one-time setup step.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "REST API agent", "test generation skill", and "OpenAPI instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Write a short comment above each function describing the endpoint, expected inputs, and error cases. Copilot uses these as a spec.
- Reference existing files in your prompts ("follow the pattern in routes/auth.js") -- this gives Copilot more to work with than a blank request.
- Highlight a working route and ask for tests. Copilot picks up on patterns in open files better than starting from nothing.
- When you hit an unfamiliar library or auth flow, use `/explain` on the relevant code to get a quick breakdown.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)

---

Next: [Stages](challenge-1-web-api-track/stages.md)
