# Integration Failure Evidence

These incidents came from earlier point-to-point work. They are not a complete failure catalog.

## Incident 1: Duplicate refund notifications

NMN Orders retried an event after a consumer timeout. The consumer committed the refund status but failed before acknowledging the message. The retry sent a second customer notification.

- Customer impact: 3,842 duplicate emails
- Detection: support tickets, 47 minutes after the first duplicate
- Missing control: idempotency key at the notification boundary
- Open question: should deduplication use event ID, refund ID plus state, or both?

## Incident 2: Customer match collision

A pilot export joined records on normalized email. A seller employee and a retail customer shared a family email address. The resulting profile showed the retail address in a marketplace support tool.

- Records affected: 126 before the pilot stopped
- Detection: manual review
- Missing control: confidence threshold and identity-type boundary
- Open question: who approves or rejects uncertain links?

## Incident 3: Stale order view

HPC Reporting queried an OMS read replica during a replication delay. Support told 612 customers that shipped orders were still processing.

- Maximum observed lag: 38 minutes
- Detection: warehouse escalation
- Missing control: freshness indicator and source fallback
- Open question: what freshness is acceptable for read-only order history?

## Incident 4: Schema drift

NMN Orders added `refundReasonCode` as an optional field, then one producer changed it from a string to an object in a patch release. Two consumers moved messages to their dead-letter queues.

- Events delayed: 91,000
- Recovery time: 3 hours 22 minutes
- Missing control: compatibility check in producer delivery
- Open question: who owns contract approval after the merger?

## Incident 5: Daily totals disagree

HPC reports transactions by posting date. NMN reports seller settlement using event effective time and later compensating events. The merger finance trial differed by 1.7 percent.

- Detection: finance reconciliation
- Resolution: manual adjustment workbook
- Missing control: shared metric definition and correction policy
- Open question: does the combined report show operational revenue, settled revenue, or both?
