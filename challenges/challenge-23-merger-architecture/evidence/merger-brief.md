# Merger Brief

## The organizations

**Harbor & Pine Commerce (HPC)** sells home goods through 46 stores and a direct-to-consumer site. Its teams favor synchronous APIs and a shared operational reporting database. Customer support, order management, and finance all depend on the same customer identifier.

**Northstar Market Network (NMN)** runs a marketplace with 1,800 independent sellers. Its core workflows are event-driven. Seller, buyer, and order identities are separate, and reporting is fed from immutable event history.

The legal merger closes in 14 weeks. The combined company must present one customer experience within nine months, but neither organization can pause normal releases for more than two weeks.

## What the board expects

- Customers can view purchases from both businesses in one account.
- Support agents can find a customer without knowing which company served them.
- Finance can produce one daily revenue and refund report.
- Marketplace sellers remain isolated from retail customer administration.
- The first useful integration ships within 90 days.

## What is not decided

- Which customer record becomes authoritative
- Whether order histories move, federate, or remain split
- Where identity linking belongs
- Which interactions should be synchronous, asynchronous, or batch
- Which existing systems retire, coexist, or become systems of record
- How reporting works during the transition

## Working rules

This is an architecture exercise. Do not implement services or provision Azure resources. Treat the evidence as incomplete on purpose. Record assumptions, call out contradictions, and keep decisions reversible where the merger timeline leaves uncertainty.
