# Incident Log

Historical incidents for the Order Gateway service. Support teams use this as reference when new issues come in.

## INC-2025-0047: Payment Gateway Timeouts

**Date:** 2025-11-15
**Severity:** High
**Duration:** 45 minutes
**Affected:** Order placement (all customers)
**Root Cause:** Payment provider (Stripe) had a regional outage in EU-West
**Resolution:** Waited for provider recovery. No code change needed.
**Team:** Payments Team
**Followup:** Added circuit breaker pattern (not yet implemented)

## INC-2025-0051: Database Connection Pool Exhaustion

**Date:** 2025-11-22
**Severity:** Critical
**Duration:** 12 minutes
**Affected:** All API endpoints
**Root Cause:** A slow query (missing index on orders.status column) held connections open. Under load, the pool (20 connections max) was exhausted within minutes.
**Resolution:** Added index on orders.status. Increased pool to 30 connections as temporary measure.
**Team:** Backend Team
**Followup:** Need to add query timeout configuration and pool monitoring alerts.

## INC-2025-0055: OutOfMemoryError on List Orders

**Date:** 2025-12-01
**Severity:** Critical
**Duration:** Service restart required (5 minutes downtime)
**Affected:** All API endpoints (full outage)
**Root Cause:** The list orders endpoint loads all matching orders into memory. A query with no filters returned 2.3 million rows.
**Resolution:** Added pagination (page size = 100). Increased JVM heap from 512MB to 1GB.
**Team:** Backend Team
**Followup:** Review all list endpoints for missing pagination.

## INC-2025-0058: SMTP Connection Failures

**Date:** 2025-12-02
**Severity:** Medium
**Duration:** 3 hours (emails queued, none lost)
**Affected:** Order confirmation and shipping notification emails
**Root Cause:** Internal SMTP relay was restarted for maintenance without notifying dependent teams.
**Resolution:** SMTP came back after maintenance. Queued emails were sent.
**Team:** Infrastructure Team
**Followup:** Add SMTP health to the health check endpoint. Create maintenance notification process.

## INC-2025-0060: Repeated Authentication Failures

**Date:** 2025-12-01
**Severity:** Medium
**Duration:** Ongoing (no resolution)
**Affected:** Unknown (possibly security issue)
**Root Cause:** Unknown. Repeated JWT signature failures from a single IP address. Could be a misconfigured client or a brute-force attempt.
**Resolution:** IP was temporarily blocked. No root cause determined.
**Team:** Security Team (escalated from Support)
**Followup:** Implement automated IP blocking after N failed auth attempts.
