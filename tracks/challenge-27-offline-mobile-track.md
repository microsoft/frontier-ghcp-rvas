# Challenge 27 Track: Offline Field Service App

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Making a React Native field-service workflow dependable when
connectivity and device capabilities cannot be assumed

## Who Is This For

- Mobile developers working with React Native or Expo
- Frontend engineers moving into local-first mobile workflows
- Test engineers who need synchronization logic to run without an emulator
- Technical leads defining offline and conflict behavior for field teams

## Prerequisites

- Working TypeScript and React knowledge
- Familiarity with React state, async code, and automated tests
- Basic understanding of mobile permissions and app lifecycle events
- Node.js 22 or the challenge devcontainer

An emulator, app store account, and Azure subscription are optional. The Expo
web target and Node test suite cover the required work.

## Technology Stack

- **React Native and Expo** for the mobile application
- **TypeScript** for UI, state, storage, and synchronization code
- **Jest** for state and integration tests that run in Node
- **Expo Camera and Expo Location** behind testable permission adapters
- **Mocked Azure Functions contract** for job retrieval and queued action sync

## Getting Started

Follow the [common setup steps](getting-started.md) first. The challenge expects
you to create repository instructions, a specialist agent, and a reusable
skill before the implementation settles.

### Open and Inspect the Challenge

Open [`challenges/challenge-27-offline-mobile/`](../challenges/challenge-27-offline-mobile/)
and run the fixture validation, typecheck, and tests. Then start the Expo web
target. Read `docs/architecture-notes.md` before changing the storage or sync
code.

The starter is a working service board with inspection forms and four network
fixtures. It is not release-ready. Refresh the web app after saving an
inspection, force a conflict, and try both permission buttons. Those failures
define the work.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should capture:

- The local-first rule: saving a technician's work must not require a network
  request
- The boundary between domain code, device adapters, persistence, and the
  mocked Azure Functions client
- Queue ordering, idempotency, schema migration, and error-handling conventions
- Accessibility expectations for React Native controls and status changes
- The requirement that core state and synchronization tests run in Node

### Suggested Custom Agents

- **Offline Data Reviewer** -- Reviews a proposed storage and queue design for
  data-loss paths, ordering mistakes, and restart behavior. Give it the design
  and relevant interfaces before implementation; keep it focused on findings
  and trade-offs rather than wholesale rewrites.
- **Mobile Accessibility Reviewer** -- Checks one completed journey for labels,
  roles, focus, text scaling, target size, and non-color status cues. Give it a
  screen and expected states after the basic flow works.
- **Sync Incident Reviewer** -- Examines conflict and network-failure evidence.
  Give it fixture results, queue behavior, and the chosen policy; ask it to find
  cases where technician work can disappear or be applied twice.

### Suggested Custom Skills

- **Offline Journey Check** -- A repeatable sequence that saves work, simulates
  restart, changes network fixtures, synchronizes, and records any data loss.
  Use it after each persistence or queue change.
- **Permission Degraded-Mode Check** -- Exercises granted, denied, blocked, and
  unavailable device states and verifies that the inspection can continue.
- **Release Evidence Pass** -- Runs the Node checks, reviews accessibility and
  failure evidence, and updates the release-readiness checklist without
  treating optional Azure deployment as a release requirement.

## Tips for Using Copilot on This Track

- Ask Copilot to trace one technician action from the form to local storage and
  through synchronization. A generic architecture summary will miss ordering
  and restart failures.
- Keep native APIs behind narrow interfaces. This lets Copilot generate useful
  Node tests instead of tests that depend on a simulator.
- Give conflict examples concrete versions and timestamps. Ask what happens to
  both copies of the work under the proposed policy.
- Test the offline fixture before the happy path. A local-first app that only
  works online is still an online app.
- Use accessibility review on state changes, not just static controls. Queue,
  sync, permission, and conflict feedback all need understandable announcements.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-27-offline-mobile-track/stages.md)
