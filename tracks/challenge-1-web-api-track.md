# Challenge 1 Track: Web API

**Duration:** 6-8 hours

**Difficulty:** ⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Building APIs and backend services with GitHub Copilot

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

Go to `challenges/challenge-1-web-api/` and pick `node-express` or `python-fastapi`. Read the starter files (`app.js` or `main.py`, `models/`) to learn the structure and conventions before you write instructions, then work through the stages in order.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Project context (framework, language, architecture)
- Coding standards and conventions for your team
- Testing requirements and coverage goals
- API patterns and authentication approach
- Once Copilot has scaffolded around your framework and auth approach, keep both fixed

### Suggested custom agents

- An API Developer Agent that recommends resource shapes, status codes, error handling, and edge cases from an endpoint description.
- A Test Writer Agent that proposes and implements tests for a working handler, including failure paths.
- A Code Reviewer Agent that reviews a file or diff before you open a PR for injection risks, weak validation, and inconsistent error handling. It should return findings, not rewrite the code.

### Suggested custom skills

- An Endpoint Scaffolding Skill that adds a route file, handler, input validation, and test stub in a consistent format for each new resource.
- An API Contract Sync Skill that checks routes against the OpenAPI/Swagger spec and updates the spec after route changes.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "REST API agent", "test generation skill", and "OpenAPI instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Write a short comment above each function describing the endpoint, expected inputs, and error cases.
- Reference existing files in your prompts ("follow the pattern in routes/auth.js") to give Copilot a concrete example.
- Highlight a working route and ask for tests so Copilot can follow its patterns.
- When you hit an unfamiliar library or auth flow, run `/explain` on the code.

## Resources

- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-1-web-api-track/stages.md)
