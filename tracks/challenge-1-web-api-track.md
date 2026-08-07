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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

**What to include:**

- Project context (framework, language, architecture)
- Coding standards and conventions for your team
- Testing requirements and coverage goals
- API patterns and authentication approach

### Suggested Agents

**Agents to consider creating:**

- **API Developer Agent** -- Expert in REST API design, authentication patterns, and error handling
- **Test Writer Agent** -- Specialized in generating tests with high coverage
- **Code Reviewer Agent** -- Focused on code quality, security, and best practices

### Open the Challenge

Navigate to `challenges/challenge-1-web-api/` and choose either `node-express` or `python-fastapi`. Open the starter files (`app.js` or `main.py`, `models/`) to understand the structure, then work through the stages in order.

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
