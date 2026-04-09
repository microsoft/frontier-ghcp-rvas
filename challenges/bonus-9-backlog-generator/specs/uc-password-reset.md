# Use Case: Self-Service Password Reset

## Overview

Users who forget their password currently need to contact the helpdesk to get a temporary password. This creates a bottleneck during Monday mornings and after holiday periods, with average resolution times of 45 minutes. The goal is to allow users to reset their own passwords through the web portal.

## Actors

- **End User**: Any registered user of the platform
- **Email Service**: Sends reset links (existing integration with the notifications module)
- **Identity Provider**: Manages authentication tokens (SAML-based, hosted on-premise)

## Preconditions

- User has a registered email address in the system
- Email service is operational
- The user account is not locked or suspended

## Main Flow

1. User clicks "Forgot Password" on the login page
2. System displays a form asking for the registered email address
3. User enters their email and submits
4. System validates the email exists in the user registry
5. System generates a time-limited reset token (valid for 30 minutes)
6. System sends an email with a unique reset link
7. User clicks the link in the email
8. System validates the token (not expired, not already used)
9. System displays a form for entering a new password
10. User enters and confirms the new password
11. System validates password against policy (minimum 12 characters, at least one uppercase, one number, one special character)
12. System updates the password and invalidates the token
13. System sends a confirmation email notifying the user their password was changed
14. User is redirected to the login page with a success message

## Alternative Flows

### A1: Email not found (Step 4)

- System displays the same success message as a valid request (to prevent user enumeration)
- No email is sent
- Event is logged for security monitoring

### A2: Token expired (Step 8)

- System displays a message saying the link has expired
- User is offered the option to request a new reset link
- The expired token is marked as used

### A3: Password does not meet policy (Step 11)

- System displays specific feedback about which rules are not met
- User can retry without requesting a new token (token remains valid)

### A4: Account is locked (Step 4)

- System displays the generic success message (same as A1)
- An internal alert is generated for the security team
- No reset email is sent

## Business Rules

- A user can request a maximum of 3 reset links within a 1-hour window
- Reset tokens are single-use
- All password reset attempts (successful and failed) must be logged in the audit trail
- The reset link URL must use HTTPS
- Password history: users cannot reuse any of their last 5 passwords
- After a successful reset, all other active sessions for that user must be terminated

## Non-Functional Requirements

- The reset email must be sent within 30 seconds of the request
- The system must handle 100 concurrent reset requests during peak hours
- All reset-related data must be encrypted at rest and in transit

## Dependencies

- Notifications module (email sending)
- User registry service (email lookup, password update)
- Audit logging service
- Session management service (for invalidating active sessions)

## Open Questions

- Should we support SMS as an alternative delivery channel? (Pending product decision)
- Should locked accounts be able to self-service unlock, or just reset password? (Pending security review)
