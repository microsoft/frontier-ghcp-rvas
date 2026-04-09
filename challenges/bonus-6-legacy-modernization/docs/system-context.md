# Acme Bank Account Manager -- System Context

This application manages customer accounts for Acme Bank, a fictional mid-size retail bank. The system has been in production since 2016, originally built by a contractor who left the company in 2018. Maintenance has been done by three different developers since then, none of whom were involved in the original design.

## What the System Does

- Customer registration and profile management
- Account operations: checking, savings, and fixed deposits
- Account-to-account transfers
- Monthly interest calculation (batch job)
- Customer tier management based on total balance (batch job)
- Transaction logging
- Portfolio and daily summary reports
- Exchange rate lookup (from a cancelled cross-border pilot)

## Known Issues

The team that inherited this system documented a few things informally in Slack, but this is the only written context that survived a workspace migration:

- There is no service layer. All business logic lives in the controllers.
- SQL queries are built using string concatenation in several places.
- The Log4j dependency is outdated and flagged in security scans.
- Apache HttpClient 4.x is used for one endpoint (exchange rates) that nobody uses.
- The transfer endpoint does not use database transactions, so a crash mid-transfer could leave inconsistent balances.
- The daily transfer limit check only looks at the individual transaction, not the daily total.
- The email validation in DbHelper is minimal.
- There are no tests of any kind.
- The exchange rate endpoint was added for a pilot project in 2018 that was cancelled. Nobody removed it.
- Customer tier updates happen only in the batch job -- there is no real-time tier check.

## Technology Stack (Current)

- Java 8
- Spring Boot 1.5.22
- H2 in-memory database
- Apache HttpClient 4.5.6
- Gson 2.8.2
- Commons IO 2.5
- Log4j 1.2.17
- No build automation or CI/CD
- No tests
