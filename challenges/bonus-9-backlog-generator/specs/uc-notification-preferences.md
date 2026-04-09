# Use Case: Order Notification Preferences

## Overview

Customers receive a fixed set of notifications about their orders (order confirmed, shipped, delivered). They have no control over which notifications they receive or through which channel. Several customers have complained about receiving too many emails. The goal is to allow customers to configure their notification preferences per channel (email, SMS, push notification) and per event type.

## Actors

- **Customer**: A registered user with at least one order
- **Notification Engine**: Existing service that dispatches messages (supports email, SMS, push)
- **Admin**: Can view and override notification preferences for compliance reasons

## Preconditions

- Customer has a verified account
- At least one notification channel is configured (email is always available)
- Notification engine is operational

## Main Flow

1. Customer navigates to "Notification Preferences" in their account settings
2. System displays a matrix of event types (rows) and channels (columns)
3. Customer toggles individual preferences on/off
4. Customer clicks Save
5. System validates that at least one channel remains active for critical notifications (order confirmation, payment issues)
6. System persists the preferences
7. System displays a confirmation message

## Event Types

| Event | Default Email | Default SMS | Default Push | Can Disable All? |
|-------|:---:|:---:|:---:|:---:|
| Order Confirmed | Yes | No | Yes | No |
| Payment Processed | Yes | No | No | No |
| Order Shipped | Yes | Yes | Yes | Yes |
| Out for Delivery | No | Yes | Yes | Yes |
| Order Delivered | Yes | No | Yes | Yes |
| Return Accepted | Yes | No | No | No |
| Promotional Offers | Yes | No | Yes | Yes |

## Alternative Flows

### A1: Customer tries to disable all channels for a critical event (Step 5)

- System prevents the save
- Displays a message explaining that certain notifications cannot be fully disabled
- Highlights which events must keep at least one active channel

### A2: Channel not configured (Step 2)

- SMS column is grayed out if no phone number is on file
- Push column is grayed out if no mobile app is registered
- A link to add the missing channel is shown inline

### A3: Admin override (separate flow)

- Admin accesses a customer's preference panel through the admin portal
- Admin can force-enable channels for compliance events
- Admin overrides are logged with reason code and admin ID
- Customer sees a note explaining specific preferences are managed by the system

## Business Rules

- Promotional notifications follow opt-in/opt-out regulations (GDPR: default off for EU customers, can opt in)
- Preference changes take effect immediately for future events
- Changing preferences does not affect notifications already queued for dispatch
- SMS notifications incur a cost; system should display a note about potential carrier charges
- Preference history must be retained for 2 years for compliance audits
- Bulk preference changes must be supported (e.g., "turn off all SMS")

## Non-Functional Requirements

- Preferences page must load within 2 seconds
- Changes must be persisted with eventual consistency (up to 5-second delay acceptable)
- System must support 10,000 concurrent preference updates during sales events

## Dependencies

- Customer profile service (phone number, app registration status)
- Notification engine (channel capabilities, queue status)
- Compliance service (GDPR region detection)
- Audit logging service

## Open Questions

- Should we add a "digest" mode (daily summary instead of individual notifications)?
- WhatsApp as a channel -- is the integration with the notification engine ready?
