# Challenge 19 track: Legacy WCF banking modernization

**Duration:** 6-10 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Use GitHub Copilot to trace a banking SOAP service, characterize its behavior, and migrate it to a REST API

## Who is this for

- .NET developers dealing with legacy WCF or SOAP services
- Engineers performing enterprise service modernization (WCF, JAX-WS, or similar SOAP platforms)
- Developers who need to understand service contracts, bindings, faults, and data contracts before rewriting them
- Teams that finished challenge-18 (COBOL) and want a second modernization scenario with a different legacy stack

## Prerequisites

- Solid C# and .NET fundamentals
- Basic awareness of SOAP and REST
- Familiarity with HTTP status codes and RESTful API design
- Basic understanding of banking concepts (accounts, transactions, interest)
- No prior WCF experience required

## Technology stack

- **Source runtime:** CoreWCF on .NET 8 -- open-source WCF-compatible service contracts and SOAP endpoints, BasicHttpBinding
- **Source language:** C#
- **Target framework:** ASP.NET Core Web API (.NET 8), REST/JSON
- **Testing:** xUnit or NUnit
- **Tools:** dotnet CLI, REST Client extension (or Postman/SoapUI for SOAP testing)

## What you are working with

The codebase is a **legacy banking SOAP service** for a fictional bank called Meridian Savings Bank. It was built circa 2010-2012 using WCF and has been running in production ever since, migrated to CoreWCF in 2024 without touching the business logic.

The system handles customer account management, consumer loans, and transaction processing through `AccountService`, `LoanService`, and `TransactionService`. It follows classic WCF conventions, with service contracts on interfaces, data contracts on DTOs, fault contracts on every operation, and `BasicHttpBinding` for all endpoints.

Some operations have documented bugs (see `docs/system-context.md`). Some have undocumented quirks. Everything you learn about the system, you learn from reading the contracts, tracing the implementations, and studying the context document.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-19-wcf-banking/`. Read `docs/system-context.md` first, then `docs/architecture.md`, then explore the service contracts in `src/Meridian.Banking.Service/Contracts/` before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-19-wcf-banking/` with .NET 8 SDK, CoreWCF dependencies, and the VS Code C# extension.

#### Running the WCF service

From the challenge root, restore and start the service:

```bash
dotnet restore
dotnet run --project src/Meridian.Banking.Service
```

The service starts on `http://localhost:5000`. A 404 at the root path is expected. SOAP requests use these paths:

- `http://localhost:5000/AccountService`
- `http://localhost:5000/LoanService`
- `http://localhost:5000/TransactionService`

To verify it is running, fetch the WSDL for any endpoint (quote the URL so the shell does not expand `?`):

```bash
curl 'http://localhost:5000/AccountService?wsdl'
```

A successful response returns an XML document starting with `<wsdl:definitions ...>`. A 400 or empty response means the service is not up yet or the URL was not quoted correctly.

#### Using the console client

A demo client is included at `src/Meridian.Banking.Client`. With the service running in one terminal, open a second terminal and run:

```bash
dotnet run --project src/Meridian.Banking.Client
```

It sends a real SOAP request to `GetCustomerProfile` for customer ID 1001 and prints the raw HTTP status and response body. This is a quick sanity check that the service is accepting SOAP messages correctly. The client uses raw HTTP rather than a generated proxy, so you can also read its source to see what a well-formed SOAP envelope looks like for this service.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should include:

- That you are working with a legacy WCF banking service running on CoreWCF (.NET 8) and modernizing it to a REST API using ASP.NET Core Web API
- WCF-specific concepts Copilot should expect to encounter: `ServiceContract`, `OperationContract`, `DataContract`, `DataMember`, `FaultContract`, `ServiceFault`, `BasicHttpBinding`, `ServiceBehavior`, WSDL, SOAP 1.1 message structure
- The modernization goal: preserve all business logic while adopting REST/JSON conventions and HTTP status codes in place of SOAP faults
- Your preference for REST endpoint design (controllers vs. minimal APIs) and persistence strategy (in-memory, SQLite, or other)
- Non-negotiable: every migrated endpoint needs a characterization test proving it matches the original SOAP behavior before the SOAP path is retired

### Suggested custom agents

The custom agents below help you work on the challenge. They are separate from the WCF service and REST API you build; those are runtime deliverables, not `.github/agents/` definitions.

- **WCF Analyst Agent** -- Reads WCF service contracts and explains each operation, its data contracts, and the faults it can throw. Give it a contract file; it returns a plain-language breakdown of the operation and its `BasicHttpBinding` configuration. Use it before mapping anything to REST.
- **Banking Domain Agent** -- Applies banking domain judgment for account types, interest calculation, and transaction reconciliation that the WCF service assumes. Give it an operation's behavior; it explains the domain reasoning. Use it when a rule's intent isn't obvious from the contract alone.
- **REST Migration Agent** -- Reasons about how each WCF operation and fault should map to an HTTP verb, path, and status code, and how to phrase the resulting OpenAPI documentation. Give it an analyzed operation; it proposes the REST equivalent. Use it once the Analyst agent has explained the original contract.

### Suggested custom skills

- **Characterization Testing Skill** -- A fixed sequence for capturing current WCF behavior before changing anything: call each operation with representative inputs, record the exact response including faults, and turn those recordings into xUnit/NUnit tests that must keep passing through the migration.
- **WSDL Verification Skill** -- A repeatable check after starting the service: fetch the WSDL for each endpoint, confirm it parses, and use the console client to send one real SOAP request per service as a smoke test before deeper work begins.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "SOAP to REST migration agent", "characterization testing skill", and "ASP.NET Core instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Use `/explain` on a service contract file. Check its description of operations, faults, and binding semantics against the code.
- Before writing code, decide the HTTP verb, path, and fault-to-status-code mapping for each `OperationContract`.
- Use `@workspace` and `#file` references to point Copilot at specific contracts when asking questions.
- For the loan amortization schedule, have Copilot explain the PMT formula and check the implementation. Find the known date-calculation bug.
- When migrating a WCF service method to a C# service class, check the generated code against the characterized behavior, including legacy quirks.
- Agent mode is useful for scaffolding the ASP.NET Core project structure. Describe the resource model and let Copilot generate the controller skeletons.

## Resources

- [CoreWCF on GitHub](https://github.com/CoreWCF/CoreWCF)
- [WCF documentation (Microsoft Learn)](https://learn.microsoft.com/dotnet/framework/wcf/)
- [ASP.NET Core Web API documentation](https://learn.microsoft.com/aspnet/core/web-api/)
- [Azure API Management documentation](https://learn.microsoft.com/azure/api-management/)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-19-wcf-modernization-track/stages.md)
