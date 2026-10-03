# Challenge 1 Track: Web API

**Duration:** 6-8 hours

**Difficulty:** ⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Building APIs and backend services with GitHub Copilot

## Who is this for

- Backend Engineers and API Developers
- Web Service Developers
- Software Engineers focused on server-side development

## Prerequisites

- Basic knowledge of REST APIs and HTTP methods/status codes
- Familiarity with either JavaScript/Node.js or Python
- Basic testing concepts

## Technology stack

- **Node.js** with Express.js OR **Python** with FastAPI
- JWT for authentication
- Testing frameworks (Jest/Mocha or pytest)
- OpenAPI/Swagger for documentation

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-1-web-api/` and choose either `node-express` or `python-fastapi`. Open the starter files (`app.js` or `main.py`, `models/`) to understand the structure and existing conventions before you write any instructions, then work through the stages in order.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Project context (framework, language, architecture)
- Coding standards and conventions for your team
- Testing requirements and coverage goals
- API patterns and authentication approach
- Non-negotiable: keep the chosen framework and auth approach fixed once Copilot has scaffolded around it

### Suggested custom agents

- Use an API Developer Agent to recommend resource shapes, status codes, error handling, and edge cases from an endpoint description.
- Use a Test Writer Agent to propose and implement tests for a working handler, including failure paths.
- Use a Code Reviewer Agent before opening a PR to review a file or diff for injection risks, weak validation, and inconsistent error handling. It should return findings rather than rewrite the code.

### Suggested custom skills

- An Endpoint Scaffolding Skill adds a route file, handler, input validation, and test stub in a consistent format for each new resource.
- An API Contract Sync Skill checks routes against the OpenAPI/Swagger spec and updates the spec after route changes.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "REST API agent", "test generation skill", and "OpenAPI instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Write a short comment above each function describing the endpoint, expected inputs, and error cases. Copilot uses these as a spec.
- Reference existing files in your prompts ("follow the pattern in routes/auth.js") to give Copilot a concrete example.
- Highlight a working route and ask for tests. Copilot picks up on patterns in open files better than starting from nothing.
- When you hit an unfamiliar library or auth flow, use `/explain` on the relevant code to get a quick breakdown.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-1-web-api-track/stages.md)
