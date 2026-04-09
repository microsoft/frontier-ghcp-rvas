# Phase 2: Security and Debt Audit

[Back to Legacy Code Modernization Track](../bonus-legacy-modernization-track.md)

**Duration:** 1-1.5 hours

**Focus:** Identifying vulnerabilities, deprecated libraries, and technical debt

## Tasks

1. **Run a dependency audit.** Ask Copilot to review the `pom.xml` and identify: deprecated libraries, libraries with known CVEs, and libraries that should be replaced. Log4j 1.2.17 is the obvious one, but there are others.

2. **Find SQL injection vulnerabilities.** Search the codebase for string-concatenated SQL queries. Document each instance with the file, line, and the specific injection vector. There are at least 5.

3. **Identify missing input validation.** Review each endpoint: what inputs are accepted without validation? What happens if you send unexpected values? Document the gaps.

4. **Catalog dead code.** Find code that is not used or features that were never completed. The system context hints at one (exchange rate endpoint from a cancelled pilot), but there may be more.

5. **Assess architectural debt.** Document the problems with the current architecture: no service layer, business logic in controllers, no transaction management, no proper error handling model.

6. **Produce a technical debt report.** Create `docs/tech-debt-report.md` with all findings, organized by severity (Critical, High, Medium, Low). Each finding should have a description, location, risk, and recommended fix.

## Verification

- [ ] All deprecated/vulnerable dependencies identified (at least 3)
- [ ] All SQL injection points documented (at least 5)
- [ ] Missing input validation gaps cataloged
- [ ] Dead code and incomplete features identified
- [ ] Architectural issues documented
- [ ] Technical debt report created with severity-ranked findings

---

Previous: [Phase 1: Code Archaeology](phase-1-archaeology.md) | Next: [Phase 3: Test Harness](phase-3-tests.md)
