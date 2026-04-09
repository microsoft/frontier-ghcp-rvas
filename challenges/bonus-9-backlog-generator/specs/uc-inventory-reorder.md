# Use Case: Inventory Reorder Automation

## Overview

Warehouse managers currently check stock levels manually every morning using a spreadsheet export from the ERP. When stock falls below the reorder threshold, they create purchase orders by hand in the procurement portal. This process takes 2-3 hours daily and often misses items, leading to stockouts. The goal is to automate reorder detection, purchase order creation, and supplier notification.

## Actors

- **System (Scheduled Job)**: Runs daily at 06:00 and checks stock levels
- **Warehouse Manager**: Reviews and approves generated purchase orders
- **Procurement System**: Existing system where purchase orders are submitted (REST API available)
- **Supplier Portal**: Receives order notifications via email or EDI

## Preconditions

- Product catalog contains reorder thresholds and preferred suppliers
- Supplier contracts are active and on file
- Procurement system API credentials are configured
- Inventory data is current (synced from warehouse management system nightly)

## Main Flow

1. Scheduled job runs and queries all products where current stock is at or below the reorder threshold
2. For each product below threshold, system calculates the order quantity using the Economic Order Quantity (EOQ) formula
3. System groups items by preferred supplier to minimize the number of purchase orders
4. System generates draft purchase orders with line items, quantities, and expected unit costs
5. System assigns each draft PO to the warehouse manager responsible for that product category
6. Warehouse manager receives a notification with a summary of pending POs
7. Warehouse manager reviews each PO in the approval queue
8. Warehouse manager approves, adjusts quantities, or rejects each PO
9. For approved POs, system submits them to the procurement system via API
10. System sends order confirmation to the supplier via their preferred channel (email or EDI)
11. System updates the product record with the expected delivery date and pending order quantity

## Alternative Flows

### A1: Supplier is inactive or contract expired (Step 3)

- System flags the product and assigns it to a "manual review" queue
- Warehouse manager must select an alternative supplier or escalate to procurement
- No automatic PO is generated for these items

### A2: EOQ calculation results in quantity above supplier maximum (Step 2)

- System caps the order at the supplier's maximum order quantity
- A note is added to the PO explaining the cap
- If the capped quantity still does not bring stock above the safety threshold, a warning is added

### A3: Procurement API is unavailable (Step 9)

- System retries 3 times with exponential backoff (1 min, 5 min, 15 min)
- If all retries fail, the PO is moved to a "failed submission" queue
- Warehouse manager is notified and can retry manually or submit through the procurement portal

### A4: Warehouse manager does not act within 24 hours (Step 7)

- System sends a reminder notification
- After 48 hours, the PO is escalated to the procurement team lead
- Critical items (stock at zero) bypass approval and are auto-submitted

## Business Rules

- EOQ formula: Q = sqrt((2 * annual demand * order cost) / holding cost per unit)
- Safety stock = average daily demand * lead time in days * 1.5 (safety factor)
- Reorder quantity must be rounded up to the nearest supplier pack size
- Products marked as "seasonal" use a different reorder threshold based on the current quarter
- Purchase orders above 10,000 EUR require a second approval from the finance team
- Duplicate POs for the same product within a 7-day window should be flagged and merged

## Non-Functional Requirements

- The daily job must complete within 15 minutes for up to 50,000 products
- All POs must be traceable from detection through submission and delivery
- Integration with procurement API must handle rate limiting (max 60 requests/minute)

## Dependencies

- Warehouse management system (stock levels, nightly sync)
- Product catalog service (reorder thresholds, supplier assignments, pack sizes)
- Supplier management service (contract status, contact channels, maximum order quantities)
- Procurement system (PO submission API)
- Finance approval workflow (for high-value POs)
- Notification service (email, dashboard alerts)

## Open Questions

- Should the system support multi-warehouse reordering (different thresholds per location)?
- Can we integrate with supplier systems for real-time lead time estimates instead of using static values?
- Machine learning for demand forecasting -- is this in scope or a future phase?
