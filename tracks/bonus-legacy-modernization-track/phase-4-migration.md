# Phase 4: Migration

[Back to Legacy Code Modernization Track](../bonus-legacy-modernization-track.md)

**Duration:** 2-3 hours

**Focus:** Upgrading to Spring Boot 3.x, replacing deprecated libraries, introducing proper architecture

## Tasks

1. **Upgrade the POM.** Move from Spring Boot 1.5.22 / Java 8 to Spring Boot 3.x / Java 17+. Replace:
   - `javax.servlet` with `jakarta.servlet`
   - Log4j 1.x with SLF4J + Logback (already included in Spring Boot 3)
   - Gson with Jackson (already included in Spring Boot 3)
   - Apache HttpClient 4.x with `java.net.http.HttpClient`
   - Commons IO with Java's built-in NIO APIs
   - Update the H2 dependency to a current version

2. **Introduce a service layer.** Extract all business logic from controllers into service classes:
   - `AccountService` -- account creation, transfer, interest calculation
   - `CustomerService` -- customer CRUD, tier management
   - `ReportService` -- portfolio and daily summary reports
   - Controllers should only handle HTTP concerns (request/response mapping, status codes)

3. **Fix SQL injection vulnerabilities.** Replace all string-concatenated queries with parameterized queries. Use Spring's `JdbcTemplate` with `?` placeholders consistently.

4. **Add proper error handling.** Replace the manual `HttpServletResponse.setStatus()` calls with Spring's `@ExceptionHandler` or `ResponseEntity`. Define custom exception classes for business rule violations.

5. **Replace manual JSON handling.** Remove the `BufferedReader` loops and Gson parsing. Use Spring's built-in `@RequestBody` deserialization with proper DTO classes.

6. **Create a `.github/copilot-instructions.md` knowledge base.** Document the system's business rules, API contracts, and architectural decisions so future developers (and Copilot) have the context that the original team never wrote down.

7. **Run all Phase 3 tests.** After migration, your characterization tests (with updated imports) should still pass. Fix any regressions.

## Verification

- [ ] POM updated to Spring Boot 3.x / Java 17+
- [ ] All deprecated libraries replaced
- [ ] Service layer introduced (at least 3 service classes)
- [ ] All SQL injection vulnerabilities fixed
- [ ] Proper error handling with custom exceptions
- [ ] Manual JSON parsing replaced with Spring annotations
- [ ] `.github/copilot-instructions.md` created with business rules
- [ ] All Phase 3 characterization tests pass after migration

---

Previous: [Phase 3: Test Harness](phase-3-tests.md)
