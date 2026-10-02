# CityPulse: Stakeholder Brief

## Background

The City of Maplewood's 311 system is outdated. Residents call a phone line to report issues like potholes, broken streetlights, or graffiti, and most calls go untracked. The city also has no centralized way to share community events -- information is scattered across social media pages, flyers, and a city website that nobody maintains.

The mayor's office wants a modern web platform that gives residents a simple way to report neighborhood issues and discover community events. Internally, staff want a dashboard showing how many issues are open, which categories come up most, and where resources need to go.

## What We Need

Build a web application called **CityPulse** with the following capabilities.

### Issue Reporting (Priority: Must Have)

Residents should be able to submit a report for a neighborhood issue. At minimum, a report includes:

- **Title** -- short description (e.g., "Pothole on Main Street")
- **Description** -- longer explanation with details
- **Category** -- one of: Pothole, Streetlight, Graffiti, Noise, Trash, Other
- **Location** -- text description of where (e.g., "Corner of Main St and 5th Ave")

Each report has a status: Submitted, Acknowledged, In Progress, Resolved. Residents should be able to view all reports and see their current status.

### Community Events (Priority: Must Have)

The platform should list community events. Each event has a title, description, date/time, and location. City staff (or any user) should be able to create new events. Residents browse upcoming events sorted by date.

### Dashboard (Priority: Should Have)

A dashboard page showing:

- Total number of open (unresolved) reports
- Reports broken down by category (how many potholes, streetlights, etc.)
- Number of events in the next 7 days
- Recent activity (last 5 reports submitted)

### UI Acceptance Criteria

- Report status has a readable text label, including Acknowledged. Color alone
  must not carry its meaning.
- Invalid or failed submissions preserve entered values and explain the
  next action. A failed request must not show submission success.
- An empty reports list explains that there are no reports yet.
- A resident can complete the report form using the keyboard at mobile width.
- One reviewed UI improvement has before-and-after evidence in the feature PR
  and is checked against these criteria by QA.

### User Accounts (Priority: Could Have)

Optional for the first version. If time allows, add user registration and login so that reports and events are associated with a user. Protect creation endpoints behind authentication.

## Constraints

- The platform must be a web application (accessible from a browser)
- It must work on both desktop and mobile screens
- The team has a five-hour core, with up to six hours for debugging
- Demonstrate locally; Azure deployment is optional unless an environment is already prepared
- There is no existing infrastructure -- you are starting from scratch

## Success Criteria

The mayor will evaluate the demo based on:

1. Can a resident submit an issue report and see it in the system?
2. Can a resident browse upcoming community events?
3. Can the team demonstrate the integrated application locally or on Azure?
4. Does the project have automated tests?
5. Does the team have a CI/CD pipeline?

Bonus points for: a working dashboard, authentication, solid error handling, and a polished UI.
