# Consumer Notes

These notes came from teams integrating the three services.

## Internal Portal Team

The portal calls customer and order endpoints in the same user flow. The
different field casing and page shapes have led to separate client adapters.
The team cannot tell whether `X-Trace-Id`, `X-Request-ID`, and
`X-Correlation-ID` represent the same value.

## Finance Automation Team

Invoice pagination has no documented end condition. A failed invoice request
returns plain text, while other services return JSON. Their retry worker cannot
classify failures consistently.

## Partner Integration Team

The customer API expects a bearer token. The order API expects a key. Billing
does not declare identity requirements. The team wants one onboarding route
and a clear statement of which credentials are suitable for user-facing,
service-to-service, and partner access.

## Service Owners

The owners can change future versions, but they cannot break current consumers
without notice. They want objective review checks and a documented exception
process rather than subjective comments during every release.
