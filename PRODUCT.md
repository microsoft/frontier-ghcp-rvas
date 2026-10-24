# GitHub Copilot Adoption

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

**Participants are the primary audience.** They choose work relevant to their
role, prepare an environment, follow a track, and demonstrate a working outcome
within a delivery session.

Coaches are the secondary audience. They help participants select challenges,
curate challenge sets, share student URLs, and run sessions on predefined
challenges.

## Product Purpose

Help teams adopt GitHub Copilot by delivering work they need, rather than
practicing isolated prompts. A successful session produces a demonstrable result
and practices the team can keep using.

The product includes the documentation site, challenge starter code, and track
guides.

## Positioning

The repository pairs worked-example challenges with starter code, dedicated
development environments, staged guides, and verification criteria. Participants
develop repository instructions, custom agents, and custom skills in the context
of the work. Individual tracks define exceptions, including the supplied
Spec Kit workflow.

## Operating Context

Participants can browse challenges by role, outcome, category, or learning path.
Role Collections group relevant challenges; they are not required sequences.
Coaches can use the Challenge Set Builder and Learning Paths pages to prepare a
selection and share one student URL.

Each challenge guide has an overview, contents page, and separate stage pages.
Role-specific pages appear where the track needs them. Direct links must keep
participants on the intended challenge page.

Participants work in GitHub Codespaces or a local development environment.
Predefined challenges use disposable clones because first-time setup removes
material outside the selected challenge.

The site uses static HTML, CSS, and JavaScript in `web/`, without build
dependencies. `node web/build.js` generates site data from repository content.
GitHub Pages publishes the site through `.github/workflows/deploy-site.yml`.
Local preview uses `python3 -m http.server 8000 --directory web`.

## Capabilities and Constraints

- **Azure only.** Cloud-related session content uses Azure.
- Each challenge must be completable in 4-6 hours. Keep optional work outside
  that core.
- Keep tracks and challenge starter code synchronized. Each challenge needs its
  own devcontainer configuration, referenced by its track.
- Put challenge instructions in the corresponding track under `tracks/`, not
  in challenge-folder README files.
- Describe what repository instructions, custom agents, and prompts should
  achieve. Do not supply ready-to-paste solutions.
- Update the root `README.md` when repository structure changes.
- Keep challenge IDs, page links, curated sets, and generated site data
  consistent with their source files.
- Do not hand-edit generated content under `web/assets/data/`.

**Open decisions:** No product-specific accessibility standard or additional
user needs were confirmed during initialization. Do not claim conformance.

## Brand Commitments

Preserve the GitHub Copilot Adoption name and existing RVAP/RVAS identity and
assets. Initialization does not authorize a redesign.

Write for a competent engineer in a clear-thinker voice: direct, active, and
concrete. Keep technical facts, Microsoft product names, citations, and
governance terminology intact. Remove repetition and unnecessary deliverables.

Use the terminology in `CONTEXT.md`, including Session, Role, Role Collection,
Stage, Repository Instructions, Custom Agent, and Custom Skill.

## Evidence on Hand

- `README.md` and `CONTEXT.md`: product scope, delivery approach, and terminology.
- `tracks/` and `challenges/`: session guides, starter code, and challenge metadata.
- `FACILITATOR_GUIDE.md`: planning and delivery material for coaches.
- `learning-paths.json` and `role-collections.json`: curated challenge selections.
- `web/`: the existing site implementation and its build script.
- `web/assets/img/` and `docs/images/rvas-banner.jpg`: existing identity assets.

Challenge examples demonstrate the work participants can attempt. They are not
evidence of measured adoption gains or customer outcomes. Do not invent
testimonials, benchmarks, or results.

## Product Principles

- Lead with the work participants need to deliver.
- Help participants choose relevant work and reach its instructions directly.
- Keep the core achievable within one 4-6-hour session.
- Teach participants to author and refine Copilot customizations, not copy
  finished answers.
- Preserve one consistent experience across the site, tracks, starter code,
  and development environments.
