# Functional Requirements: Multi-Tenant Billing Module

## 1. Purpose

Add a billing module to the existing SaaS platform. The platform currently manages tenants (organizations) and their users, but all billing is handled manually through spreadsheets. This module will automate subscription management, usage tracking, invoice generation, and payment processing.

## 2. Scope

This module adds to the existing tenant management system. It does not replace the user management, authentication, or the main application features.

### In Scope

- Subscription plans (creation, assignment, upgrade/downgrade)
- Usage metering (API calls, storage, seats)
- Invoice generation (monthly, automated)
- Payment method management (credit card via Stripe)
- Billing dashboard for tenant admins
- Billing admin panel for platform operators

### Out of Scope

- Tax calculation (handled by Stripe Tax, no custom logic needed)
- Refund processing (manual process, out of scope for v1)
- Multi-currency support (USD only for v1)

## 3. Subscription Plans

### 3.1 Plan Structure

Each plan has:

- Name (e.g., "Starter", "Professional", "Enterprise")
- Monthly base price
- Included quotas: API calls/month, storage in GB, number of seats
- Overage rates: price per additional 1,000 API calls, per GB of storage, per seat
- Billing cycle: monthly only for v1

### 3.2 Plan Transitions

- Upgrades take effect immediately; the tenant is charged a prorated amount for the remainder of the billing cycle
- Downgrades take effect at the start of the next billing cycle
- A tenant can only have one active plan at a time
- Plan changes must be logged with timestamp, old plan, new plan, and who initiated the change

### 3.3 Initial Plans

| Plan | Monthly Price | API Calls | Storage | Seats | Overage (API/1k) | Overage (GB) | Overage (Seat) |
|------|-------------|-----------|----------|-------|-------------------|--------------|----------------|
| Starter | $29 | 10,000 | 5 GB | 3 | $0.50 | $2.00 | $10.00 |
| Professional | $99 | 100,000 | 50 GB | 15 | $0.30 | $1.50 | $8.00 |
| Enterprise | $499 | 1,000,000 | 500 GB | Unlimited | $0.10 | $1.00 | N/A |

## 4. Usage Metering

### 4.1 Tracked Metrics

- **API calls**: Counted per tenant per day. The API gateway already emits events; this module must consume them.
- **Storage**: Measured daily as a snapshot of total tenant storage usage (read from the storage service).
- **Active seats**: Count of users with at least one login in the billing period.

### 4.2 Metering Requirements

- Usage data must be aggregated daily and stored for at least 13 months
- Tenants must be able to view their current usage vs. plan quotas in real time (up to 5-minute delay acceptable)
- When a tenant reaches 80% of any quota, send a notification
- When a tenant exceeds 100% of any quota, begin tracking overages (do not block access)

## 5. Invoice Generation

### 5.1 Invoice Contents

Each monthly invoice includes:

- Billing period (start and end dates)
- Base plan charge
- Usage breakdown (API calls, storage, seats) with included vs. overage quantities
- Overage charges itemized
- Tax (calculated by Stripe)
- Total amount due

### 5.2 Invoice Lifecycle

- Generated automatically on the 1st of each month for the previous month
- Status: DRAFT -> FINALIZED -> PAID / OVERDUE / VOID
- Draft invoices can be adjusted by billing admins before finalization
- Finalized invoices are immutable
- Payment is attempted automatically via the tenant's payment method on file
- If payment fails, the invoice moves to OVERDUE and a notification is sent
- After 3 failed payment attempts (retried on days 1, 3, and 7), the tenant account is flagged

### 5.3 Invoice Numbering

Format: INV-YYYY-NNNNN (e.g., INV-2026-00142). Sequential, never reused, no gaps.

## 6. Payment Processing

- Integration with Stripe for payment processing
- Tenants can add, update, and remove credit cards
- One payment method must be designated as default
- PCI compliance: no card numbers stored in the application database (Stripe tokens only)
- Payment receipts sent to the tenant's billing contact email

## 7. API Endpoints

### Subscriptions

- `GET /api/tenants/{id}/subscription` -- current plan and status
- `PUT /api/tenants/{id}/subscription` -- change plan (upgrade/downgrade)

### Usage

- `GET /api/tenants/{id}/usage` -- current period usage vs. quotas
- `GET /api/tenants/{id}/usage/history?months=N` -- historical usage

### Invoices

- `GET /api/tenants/{id}/invoices` -- list invoices
- `GET /api/tenants/{id}/invoices/{invoiceId}` -- invoice detail
- `PUT /api/tenants/{id}/invoices/{invoiceId}` -- adjust draft invoice (admin only)
- `POST /api/tenants/{id}/invoices/{invoiceId}/finalize` -- finalize draft (admin only)

### Payment Methods

- `GET /api/tenants/{id}/payment-methods` -- list payment methods
- `POST /api/tenants/{id}/payment-methods` -- add payment method
- `DELETE /api/tenants/{id}/payment-methods/{pmId}` -- remove (if not the only one)
- `PUT /api/tenants/{id}/payment-methods/{pmId}/default` -- set as default

## 8. Authorization

- Tenant admins can view their own subscription, usage, invoices, and manage payment methods
- Platform billing admins can view and manage all tenants' billing data
- Regular tenant users cannot access billing endpoints

## 9. Events and Notifications

The module must emit events for integration with other services:

- `subscription.changed` -- plan upgrade or downgrade
- `usage.threshold.reached` -- 80% of quota reached
- `usage.quota.exceeded` -- 100% of quota exceeded
- `invoice.generated` -- new invoice created
- `invoice.paid` -- payment successful
- `invoice.overdue` -- payment failed
- `payment_method.added` -- new payment method
- `payment_method.removed` -- payment method deleted

## 10. Data Retention

- Invoice data: 7 years (regulatory requirement)
- Usage data: 13 months (rolling)
- Payment method tokens: until tenant deletes or account is closed
- Audit logs for all billing actions: 3 years
