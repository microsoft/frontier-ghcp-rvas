# TrailMate: Functional Specification

## Background

The Ridgeline Regional Parks Authority manages 30+ hiking trails across a network of parks. Trail conditions change frequently -- storms knock down trees, heavy rain causes flooding, erosion closes sections, and seasonal snow makes some routes impassable. Right now, rangers update a shared spreadsheet when they patrol, and hikers have no way to check conditions before driving to a trailhead.

The parks authority wants a web platform that lets hikers browse trails, check current conditions, and report problems they encounter on the trail. Rangers want a dashboard showing which trails have active condition reports so they can prioritize maintenance.

## What We Need

Build a web application called **TrailMate** with the following capabilities.

### Trail Directory (Priority: Must Have)

The application maintains a directory of trails. Each trail has:

- **Name** -- trail name (e.g., "Eagle Peak Loop")
- **Description** -- what the trail is like, terrain, scenery
- **Difficulty** -- one of: Easy, Moderate, Hard, Expert
- **Distance** -- length in kilometers (e.g., 8.5)
- **Elevation Gain** -- meters of climbing (e.g., 420)
- **Estimated Time** -- typical completion time (e.g., "3-4 hours")
- **Status** -- one of: Open, Caution, Closed
- **Park** -- which park it belongs to (e.g., "Ridgeline North")

Hikers should be able to browse all trails, filter by difficulty and status, and view details for any trail. The trail list page should show each trail's name, difficulty, distance, and current status at a glance.

### Condition Reports (Priority: Must Have)

Hikers can submit a condition report for a trail. Each report includes:

- **Trail** -- which trail the report is about (selected from the directory)
- **Type** -- one of: Fallen Tree, Flooding, Trail Erosion, Wildlife Sighting, Snow/Ice, Vandalism, Other
- **Severity** -- one of: Low (informational), Medium (proceed with caution), High (trail may be impassable)
- **Description** -- details about the condition
- **Reported Date** -- when the report was submitted (auto-filled)

Hikers can view all condition reports for a given trail, sorted by most recent. A trail's detail page should show its recent condition reports inline.

### Trail Status Updates (Priority: Should Have)

Authorized users (or any user, for the hackathon) can update a trail's status (Open, Caution, Closed). The status change should reference the condition reports that prompted it.

When a trail has High-severity condition reports, the UI should flag it visually (a warning indicator on the trail list and detail pages).

### Statistics Dashboard (Priority: Should Have)

A dashboard page showing:

- Total trails by status (how many Open, Caution, Closed)
- Condition reports by type (how many Fallen Tree, Flooding, etc.)
- Trails with the most condition reports in the last 30 days
- Recent activity (last 10 condition reports submitted)

### User Accounts (Priority: Could Have)

Optional for the first version. If time allows, add user registration and login so that condition reports are associated with a user. Protect write endpoints behind authentication.

## Data Model

The specification assumes two core entities and their relationship:

### Trail

| Field | Type | Required |
|-------|------|----------|
| id | UUID or auto-increment | Yes |
| name | string (max 200 chars) | Yes |
| description | text | Yes |
| difficulty | enum (Easy, Moderate, Hard, Expert) | Yes |
| distanceKm | number (decimal) | Yes |
| elevationGainM | number (integer) | Yes |
| estimatedTime | string | Yes |
| status | enum (Open, Caution, Closed) | Yes |
| park | string (max 200 chars) | Yes |
| createdAt | timestamp | Yes |
| updatedAt | timestamp | Yes |

### Condition Report

| Field | Type | Required |
|-------|------|----------|
| id | UUID or auto-increment | Yes |
| trailId | foreign key to Trail | Yes |
| type | enum (Fallen Tree, Flooding, Trail Erosion, Wildlife Sighting, Snow/Ice, Vandalism, Other) | Yes |
| severity | enum (Low, Medium, High) | Yes |
| description | text | Yes |
| reportedAt | timestamp | Yes |

## API Endpoints (suggested)

These are suggestions. The team can adjust the API design during technical planning.

### Trails

- `GET /api/trails` -- List all trails. Support query params: `?difficulty=Hard&status=Open&search=eagle`
- `GET /api/trails/:id` -- Get a single trail with its recent condition reports
- `POST /api/trails` -- Create a trail (seed data or admin use)
- `PATCH /api/trails/:id` -- Update trail (primarily for status changes)

### Condition Reports

- `POST /api/trails/:trailId/reports` -- Submit a condition report for a trail
- `GET /api/trails/:trailId/reports` -- List condition reports for a trail (newest first)

### Statistics

- `GET /api/stats` -- Return dashboard statistics (trails by status, reports by type, most reported trails, recent activity)

## Constraints

- The platform must be a web application (accessible from a browser)
- It must work on both desktop and mobile screens
- The team has 8 hours to deliver a working version
- Deploy to a cloud environment (Azure preferred)
- There is no existing infrastructure -- you are starting from scratch

## Success Criteria

The demo will be evaluated based on:

1. Can a hiker browse the trail directory and filter trails?
2. Can a hiker submit a condition report for a trail?
3. Does the trail detail page show recent condition reports?
4. Is the application deployed and accessible online?
5. Does the project have automated tests?
6. Does the team have a CI/CD pipeline?

Bonus points for: a working dashboard, trail status management, authentication, solid error handling, and a polished UI.

## Seed Data

The team should create seed data with at least:

- 10 trails across 3 parks, with a mix of difficulties and statuses
- 15-20 condition reports spread across several trails
- At least 2 trails with High-severity reports and Closed or Caution status
