# Squad Decisions

## Active Decisions

### 2026-06-01: MkDocs nav nesting convention for track sub-pages

**By:** Danny (Lead), requested by Marco Olivo

**What:** Every challenge track in `mkdocs.yml` `nav:` that has sub-pages is expanded into a nav SECTION rather than a single link. The section's first entry is always `Overview:` pointing to the main `tracks/challenge-N-...-track.md` page. Then:
- Stage-based challenges (0,1,2,3,4,5,6,20): list `Stage N - <Title>` entries in numeric order.
- Single-file phase challenges (7,8,11-19): list `Phase N - <Title>` entries in numeric order.
- Sprint challenges (9 and 10): each phase is itself a nested sub-section containing an `Overview:` (the `phase-*.md` file) plus the per-role pages. Role order is fixed: Product Owner, Business Analyst, Frontend Developer, Backend Developer, QA Engineer, DevOps Engineer (Challenge 10 omits PO/BA).

**Title rules:** Single ` - ` separator (matches existing "Challenge N - Title" style), no em-dashes, no emoji, concise human titles derived from filename or H1.

**Verification:** `docs/tracks` is a symlink to `tracks/`; enumerate with `find -L docs/tracks -name '*.md'`. Every track page must appear in nav exactly once. Confirm with `. .venv-docs/bin/activate && mkdocs build --strict` -> must exit 0 with no warnings.

**Why:** User wants all per-stage/per-phase/per-role pages browsable on the GitHub Pages site, not just top-level track pages. Future track additions must follow this nesting + ordering convention and re-run the strict build before merging.

### 2026-06-01: GitHub Pages docs use Material for MkDocs

**By:** Basher (DevOps), requested by Marco Olivo

**What:** Upgraded the docs site from the plain default MkDocs theme to Material for MkDocs (navigation tabs/sections/top, light/dark palette toggle, search suggest/highlight, code copy) so the published GitHub Pages site renders tracks, challenges, and guides as a polished, navigable website. Pinned `mkdocs-material==9.5.49`, `pymdown-extensions==10.14`, and `pygments==2.18.0` in `requirements-docs.txt`. The existing `.github/workflows/deploy-docs.yml` is unchanged. `mkdocs build --strict` passes (exit 0).

**Why:** The pygments pin is mandatory -- pymdown-extensions 10.14 passes `filename=None` for untitled code blocks and pygments 2.19+ crashes in `html.escape` on that, breaking the strict build in CI. `pygments==2.18.0` is the last release that handles it.

**Supersedes:** The theme choice in the 2026-04-28 "MkDocs and GitHub Pages docs publishing shape" decision -- plain default theme replaced by Material. The build command (`mkdocs build --strict`), dependency manifest, and dedicated Pages workflow remain as decided there.

**Manual step (owner action required):** Set GitHub → Settings → Pages → Source = "GitHub Actions" once in the UI. This cannot be configured from code.

### 2026-06-12: Challenge 21 is a dedicated Azure Terraform track with its own scaffold and devcontainer

**By:** Danny, Rusty, Basher

**What:** Added Challenge 21 as `challenge-21-azure-terraform`, positioned as a dedicated Azure Terraform track separate from the broader DevOps track. The track is a 4-6 hour Azure-only path focused on remote state, Azure platform setup, managed identity and Key Vault, module reuse, and CI plus drift handling. The corresponding challenge scaffold lives under `challenges/challenge-21-azure-terraform/terraform/azure`, ships with a dedicated lean devcontainer, and includes a valid Azure starter that provisions a resource group plus a private storage account and container for Terraform state exercises.

**Guardrail:** When a challenge scaffold lands before its track guide, `scripts/setup-challenge.sh` and `scripts/setup-challenge.ps1` must preserve shared `tracks/` content instead of deleting it or leaving a broken README link.

**Why:** The repository already covered Terraform inside the broader DevOps track, but it did not have a Terraform-first Azure infrastructure path. This isolates infrastructure authoring and review work into its own workshop-ready challenge without duplicating the container and Kubernetes scope from Challenge 3.

### 2026-06-12: Challenge 21 phase naming and Terraform root

**By:** Danny (Lead), requested by Marco Olivo

**What:** Challenge 21 uses `phase-*` track files and Phase labels in navigation, matching the specialized track convention used by nearby challenges 17-19. The participant Terraform working root is `challenges/challenge-21-azure-terraform/terraform/azure`; duplicate root-level Terraform files under `terraform/` were consolidated into that path or removed.

**Why:** Challenge 21 had both `stage-*` track pages and two Terraform roots, which made it look different from the specialized tracks and gave participants two possible places to work. The track, devcontainer, workflow, and starter files now point to one clear path.

### 2026-06-15: Challenge 21 requires Terraform review judgment

**By:** Danny, Rusty, Basher, Livingston, requested by Scribe

**What:** Challenge 21 should be richer by adding realistic Azure Terraform judgment pressure, not by expanding the platform footprint. Keep it Azure-only, phase-based, and centered on `challenges/challenge-21-azure-terraform/terraform/azure`, with Azure Container Apps as the canonical hosting target. The track now expects participants to resolve ambiguous stakeholder requirements, review Terraform plans before apply, document rejected options, justify identity and access choices, define environment promotion rules, and handle drift or failed applies through a short incident runbook.

**Scaffold guardrails:** The starter should stay intentionally incomplete enough to require decisions rather than copy-paste completion. It may include constrained variables, Azure naming and tagging guardrails, backend access choices, validation hooks, CI lint placeholders, drift evidence, and compact review docs. It should not add Kubernetes, Azure Container Registry, a full app build, complex multi-region deployment, private endpoint implementation, enterprise landing-zone scaffolding, production-grade policy suites, extra cloud providers, challenge-folder README files, or stage naming.

**4-6 hour cap:** Keep deliverables to five phase-sized increments: state and naming, network and Container Apps environment, identity and Key Vault design, module and environment cleanup, and CI plus drift response. New artifacts should sharpen existing work rather than add a sixth phase.

**Why:** The previous Challenge 21 flow was structurally sound but too linear. A participant could ask an AI assistant to generate Terraform phase by phase and pass most checks. The richer pattern rewards reasoning about naming, state, modules, identity, policy severity, plan review, and drift response while staying workshop-sized.

### 2026-06-12: Challenge selection copy must stay aligned with the current catalog range

**By:** Livingston, Danny

**What:** Any update to `docs/challenge-selection.md` that expands or renumbers the challenge table must also update the surrounding instructional copy so the stated challenge range matches the table and repo structure.

**Why:** Reviewer validation caught a mismatch where Step 1 still referenced an older challenge range after the catalog had expanded, which made the selection flow inconsistent even though the table itself was current.

### 2026-05-04: Challenge 19 uses CoreWCF on .NET 8 (not classic WCF/.NET Framework)

**By:** Linus, Basher (via Coordinator)

**What:** Challenge 19 runs the WCF banking service using CoreWCF on .NET 8, not classic WCF/.NET Framework. Classic WCF requires Windows containers (not Codespaces-compatible). CoreWCF is Linux-native and installs via NuGet (CoreWCF.Http 1.5+).

**Why:** Codespaces runs Linux containers. Classic WCF on .NET Framework requires Windows Server containers, which GitHub Codespaces does not support. CoreWCF provides the same service contract programming model on .NET 8 on Linux.

### 2026-04-28: MkDocs and GitHub Pages docs publishing shape (consolidated)

**By:** Rusty, Basher, Danny

**What:** Use plain MkDocs for the documentation site with a small curated entry layer, a root-level docs dependency manifest, and a dedicated GitHub Pages workflow. Keep the docs build command the same locally and in CI with `mkdocs build --strict`.

**Why:** This keeps the docs stack small, avoids unnecessary theme or plugin churn, and gives the team one validation path for both local work and Pages deployment. The curated entry layer can shape the reader flow without requiring a heavy second documentation system.

### 2026-04-28: Normalize squad metadata to the renumbered challenge model

**By:** Danny

**What:** Treat the renumbered repository model as the source of truth in mutable squad metadata and charters. Use one numbered challenge sequence instead of the old core-versus-bonus split.

**Why:** The repository already uses the renumbered Challenge 0 through Challenge 18 structure. Keeping squad metadata on the old split causes avoidable drift when agents describe project scope or challenge paths.

### 2026-06-23: Bespoke site architecture replacing MkDocs

**By:** Marco, decided by Linus (foundation), Rusty (data), Basher (infra)

**What:** Migrated the GitHub Pages site from MkDocs (Python build, CLI workflow) to a bespoke Node.js static site consuming challenge metadata as sources of truth. The architecture includes:

- `web/build.js` — dependency-free Node build script reading `challenges/*/meta.yml` and `learning-paths.json`, transforming to `platform.json`, `paths.json`, and challenge guides
- `web/assets/js/core.js` — locked FP API providing data loading, URL builders, badge generators, kiosk mode support (consumed by all page scripts without modification)
- `web/assets/css/styles.css` — 5-category color scheme (core-tracks, team-sprints, legacy-modernization, workflow-automation, azure-platform) with utility classes
- Shared header/footer shell in `web/index.html` + `web/assets/js/home.js` (copied verbatim by all other pages)
- 22 `meta.yml` files (one per challenge): category, difficulty (beginner/intermediate/advanced), duration (minutes), prerequisites, tags
- 8 learning paths in `learning-paths.json` (Core Developer Journey, Full-Stack Mastery, Legacy Modernization, Automation Excellence, Team Collaboration, AI & ML Development, Azure Infrastructure, Advanced Workflows)
- New `.github/workflows/deploy-site.yml` workflow (triggers on push to main + workflow_dispatch, runs build.js, deploys from web/ to GitHub Pages)
- Deleted MkDocs infrastructure: `mkdocs.yml`, `requirements-docs.txt`, `site/`, `scripts/generate-challenge-catalog.py`, old curator pages/assets in docs/
- Kept consumed pages: `docs/copilot-guide.md`, `docs/prompt-engineering.md`, `docs/mcp-servers.md`, `docs/images/`, `FACILITATOR_GUIDE.md`, `TROUBLESHOOTING.md`, `tracks/getting-started.md`

**Pages implemented:**
- Catalog (`catalog.html`/`catalog.js`) — filterable, searchable access to 22 challenges, deep links via ?cat=<id> and ?difficulty=<level>
- Challenge detail (`challenge.html`/`challenge.js`/`challenge.css`) — renders challenge hero, metadata, prerequisites, guide content; kiosk-aware (preserves ?set param on internal links)
- Builder (`builder.html`/`builder.js`) — coaches multi-select challenges by category/difficulty/search, generate shareable student set URL via FP.setUrl()
- Student set view (`set.html`/`set.js`) — displays curated challenges from ?ids=comma-separated, auto-enters kiosk mode (hides nav, injects exit button)
- Learning paths (`paths.html`/`paths.js`/`paths.css`) — displays 8 curated paths with challenge lists and share-as-set controls
- Guides (`guide.html`/`guide.js`/`guide.css`) — renders markdown pages (?p=<slug>) with sidebar navigation

**Category mappings:** "Core tracks" → core-tracks (0-8), "Team sprints" → team-sprints (9-10), "Legacy modernization" → legacy-modernization (11,12,18,19), "Workflow automation" → workflow-automation (13-17,20), "Azure platform" → azure-platform (21)

**Difficulty mappings:** ⭐ → beginner, ⭐⭐ → intermediate, ⭐⭐⭐+ → advanced; progressive ranges rounded to representative level

**Duration mappings:** 4-6h → 300min, 6-8h → 420min, 6-10h → 480min, 8-10h → 540min, 8-12h → 600min

**Why:** The MkDocs static generation step was slow and tightly coupled to documentation structure. A bespoke build allows us to:
- Use challenge metadata as single source of truth (no duplication across mkdocs.yml and challenge folders)
- Generate multiple static sites (catalog, builder, guides) from one data set
- Implement student set feature (coaches create custom challenge collections, students see locked views) without complex MkDocs plugins
- Migrate to Azure-backed deployment in the future without changing the local development workflow
- Speed up the build process (no mkdocs virtualenv or CLI overhead)

**Verification:** Build passes (22 challenges, 5 categories, 8 learning paths), all 9 JavaScript files pass `node --check`, Markdownlint 0 errors, no dangling MkDocs references, Azure-only references maintained.

**Pre-existing issues flagged (out of scope):** Challenges 1, 2, 11, 18, 19 have folder/track/devcontainer naming mismatches. Recommended for future Gentry/Marco resolution to standardize naming conventions.

**Manual step (owner action required):** Set GitHub → Settings → Pages → Source = "GitHub Actions" once in the UI (if not already done).

### 2026-06-23: Outcome Taxonomy and Data-Model Contract

**By:** Danny (Lead), requested by Marco Olivo

**Date:** 2026-06-23

**What:** Finalized a 6-category outcome taxonomy for the hackathon and defined the data-model contract for implementation. All 22 challenges are mapped. The taxonomy is additive to the existing 5-category color scheme -- it does not replace or break it.

**Outcome IDs and Names:**

| ID | Name |
|----|------|
| `modernize-legacy` | Modernize Legacy Systems |
| `ship-features` | Ship Product Features Faster |
| `raise-quality` | Raise Quality and Confidence |
| `automate-delivery` | Automate Delivery and Ops Toil |
| `platform-foundation` | Stand Up Cloud Platform Foundations |
| `build-ai` | Build AI-Powered Capabilities |

**Data-Model Decision:**

- **`category`** (existing): Preserved. Single-valued. Controls color grouping on the site.
  Values: `core-tracks`, `team-sprints`, `legacy-modernization`, `workflow-automation`, `azure-platform`.
- **`outcomes`** (new): Multi-valued YAML list in each `meta.yml`. Describes the business
  outcome the challenge delivers. Values drawn from the 6 IDs above.
- **`OUTCOME_CONFIG`** in `web/build.js`: A map from outcome ID to `{name, description}`.
  Build validates every challenge `outcomes[]` entry against this map. Fail on unknown IDs.
- **`platform.json`**: Each challenge object gains an `outcomes` array. Top-level gains an
  `outcomeConfig` key with the full map for frontend rendering.

**Authoritative Reference:** Full taxonomy, mapping table, and implementation spec: `OUTCOMES.md` at repo root.

**Implementation Impact:**
- Linus: Add `outcomes` field to 22 `meta.yml` files (use mapping from OUTCOMES.md). Add `OUTCOME_CONFIG` + validation to `web/build.js`. Emit into `platform.json`.
- Rusty: Use outcome names/descriptions in narrative reframes. Do not add "Learning Outcomes" sections to track files.
- Basher: Preserve outcomes in participant workspaces.
- Livingston: Validate sync between `meta.yml` outcomes and `OUTCOME_CONFIG` keys.

**Why:** Customer wants hackathon framed around business outcomes (the work result a team delivers) rather than just learning activities. Additive taxonomy preserves existing site structure while reframing challenges by real business impact.

### 2026-06-23: BYOC Narrative and Kit Structure

**By:** Rusty (Content Dev), requested by Marco Olivo

**Date:** 2026-06-23

**What:** Shifted the hackathon narrative from learning-centric to outcome-driven and created the Bring Your Own Challenge (BYOC) kit to support hackathons on customer codebases.

**Narrative Reframe:**
- README.md now opens with "drive real work outcomes" instead of "learn how to use Copilot"
- Added "Two ways to run this hackathon" section: (1) pick a worked-example challenge, (2) bring your own challenge
- Every challenge listing includes a one-line outcome tag (e.g., "Ship Product Features Faster", "Modernize Legacy Systems")
- Tracks organized by the 6 outcome categories first, then by role
- Success metrics shifted from activity-only to outcome-first: "each team produced a demonstrable outcome and can articulate the business impact"
- Facilitator guide reframed: opening as outcome selection, showcase as outcome demos, wrap-up as outcome review

**BYOC Kit Structure (5 prose files):**
1. **byoc/README.md** -- Kit overview, when to use it, end-to-end flow (define outcome -> author challenge -> run session -> score outcome), integration with worked-example challenges
2. **byoc/outcome-canvas.md** -- Fill-in worksheet: target outcome (from the 6, or custom), current pain/baseline, definition of done, constraints, app/repo in scope, demo plan, success measurement (before/after impact)
3. **byoc/facilitator-runbook.md** -- How to run a hackathon on a customer codebase: pre-session prep (outcome definition, environment/devcontainer guidance, access), day-of structure (opening, timeboxes with checkpoints, demo and outcome review), post-session follow-up, common challenges and mitigations, example timeboxes for common outcomes
4. **byoc/outcome-scorecard.md** -- Reusable definition-of-done / business-impact scorecard: outcome statement, acceptance criteria (met/not met with evidence), artifacts, before/after impact (quantified), how Copilot accelerated the work, lessons learned, next steps
5. **byoc/example-walkthrough.md** -- Worked example adapting the Web API challenge app end-to-end through the kit. Shows filled canvas + scorecard + session flow for a "make the API production-ready" outcome (add JWT auth, tests, structured logging)

**Writing Style Compliance:** All BYOC files follow humanized rules (no emoji in headings, no em-dashes, no hype language, no AI sign-offs, natural phrasing, markdownlint-compliant).

**Cross-Linking:** BYOC kit referenced from README.md ("Two ways to run this hackathon" section, "Bring Your Own Challenge Kit" in Quick Links), tracks/README.md ("Bring Your Own Challenge" section), FACILITATOR_GUIDE.md ("BYOC Sessions" section).

**Why:** Customer wants the narrative tied to outcomes (the work result a team is trying to drive), not just learning activities. The BYOC kit enables customers to run hackathons on their own codebases and deliver measurable business value, positioning the 22 worked-example challenges as reference patterns rather than the only menu.

### 2026-06-23: Outcome-Driven Data Model Implementation (Additive)

**By:** Linus (Challenge Dev), Danny (Lead Architect)

**Date:** 2026-06-23

**Status:** Implemented

**What:** Implemented the six-outcome business taxonomy additively on top of the existing 5-category color scheme. The outcome classification describes WHAT work result a challenge produces, while category continues to control visual color grouping on the site. These are independent, complementary dimensions.

**Implementation Details:**
1. **Data Model (additive, non-breaking)**
   - Added OUTCOME_CONFIG to `web/build.js` defining the six canonical outcomes with id, name, and description
   - Added outcomes field to all 22 `challenges/*/meta.yml` files with multi-valued lists per the mapping in OUTCOMES.md
   - Build-time validation: Every outcome ID in meta.yml is validated against OUTCOME_CONFIG keys; build fails with clear error on unknown outcome
   - platform.json emission: Each challenge object includes `outcomes: [..]` array, and top-level `outcomeConfig` array provides canonical definitions for frontend rendering

2. **Learning Paths Reframing**
   - Added `outcomes: [..]` field to all 8 paths, derived from constituent challenge mappings
   - Renamed path `name` and `description` to be outcome-led (e.g., "Core Developer Path" with outcome focus, "Full-Stack Product Delivery", "Delivery and Operations Automation")
   - Kept `id` and `challenge_ids` unchanged for compatibility

3. **Documentation Updates**
   - **tracks/TRACK_STRUCTURE.md**: Added "Outcome Framing" subsection documenting that outcomes live in metadata and framing, NOT as a track-file section
   - Referenced new BYOC templates in byoc/templates/

4. **BYOC Authoring Templates**
   - Created `byoc/templates/track-template.md` -- main track file matching canonical structure with {{placeholders}}
   - Created `byoc/templates/stage-template.md` -- stage skeleton with Tasks, Verification, Copilot vs Judgment, navigation
   - Created `byoc/templates/meta.yml.template` -- annotated metadata file with inline comments explaining valid values for outcomes, category, difficulty, prerequisites

**Verification:**
- Build passes: `node web/build.js` reports 22 challenges, 5 categories, 8 learning paths, exit 0
- platform.json emits outcomes correctly
- All 22 meta.yml files contain valid outcomes per OUTCOMES.md mapping
- No breaking changes to existing category or site structure

**Why:** Repository framing was too learning-focused ("learn how to use Copilot") when customers want to run hackathons tied to business outcomes. Additive approach preserves the just-shipped bespoke site structure.

### 2026-06-23: Website Outcome-Driven Reframe and BYOC Page

**By:** Linus (Challenge Dev)

**Date:** 2026-06-23

**Status:** Implemented

**What:** Reframed the GitHub Pages site from learning-centric to outcome-driven and added a Bring Your Own Challenge (BYOC) page. Kept the existing 22 challenges and 5-category color scheme intact; outcomes are additive and non-breaking.

**Outcome Surfacing (data-driven):**
- Catalog: added outcome filter chipset + outcome badges on challenge cards (reads from `platform.json` `outcomeConfig`)
- Challenge detail: displays challenge outcomes as badges in hero metadata row
- Paths: displays learning path outcomes as badges below description
- Core.js: added `FP.outcomeBadges()` helper (additive, non-breaking)

**Copy Updates (humanized, outcome-led):**
- Hero: "Drive outcomes. Build skills as you ship."
- Categories: "Pick your outcome path" (removed "Five learning journeys")
- Paths: "Paths to measurable outcomes" (removed "Learning paths for your journey")
- No hype language, no em-dashes, no emoji in headings

**BYOC Page (web/byoc.html + byoc.js):**
- Introduces Bring Your Own Challenge: run hackathons on your own codebase
- Links to kit files in byoc/ (outcome-canvas.md, facilitator-runbook.md, outcome-scorecard.md, example-walkthrough.md, templates/)
- All links point to GitHub repo (dependency-free, works from GitHub Pages)
- Six-step getting-started flow inline on page
- Added BYOC nav link consistently across all 9 site pages

**Non-breaking:**
- Category-based navigation, color scheme, and existing URLs unchanged
- Outcomes are additive facet
- All outcome labels and descriptions come from `platform.json` `outcomeConfig` -- no hardcoded labels in page scripts

**Verification:**
- `node web/build.js` passes (22 challenges, 5 categories, 8 learning paths, exit 0)
- All 11 JavaScript files pass `node --check` (no syntax errors)
- Outcome filter works on catalog (e.g. `?outcome=ship-features`)
- Outcome badges render on catalog cards, challenge detail, and path cards with correct labels from outcomeConfig
- BYOC page renders with all GitHub repo links to kit files

**Why:** Site narrative was learning-first ("learn Copilot") instead of outcome-first ("drive a real deliverable"). Outcomes now visible across catalog, challenge detail, and paths, making it easy to filter and discover challenges by business outcome. BYOC page provides clear entry point for customers who want to adapt the kit to their own codebase.

### 2026-06-23: Preserve byoc/ and OUTCOMES.md in Participant Workspaces

**By:** Basher (DevOps)

**Date:** 2026-06-23

**Context:** The team added two new top-level items to the repository:
- `OUTCOMES.md` -- the outcome taxonomy (8.6 KB)
- `byoc/` -- the Bring Your Own Challenge authoring kit with templates, canvas, runbook, and example walkthrough (~56 KB)

Both are **facilitator-facing reference materials** intended to help facilitators understand and adapt the outcome-driven model.

**Decision:** **PRESERVE** `byoc/` and `OUTCOMES.md` in participant workspaces.

**Rationale:**
1. **Facilitator Reference:** These materials help facilitators run or adapt challenges. Even participants running a modified challenge could benefit from understanding the outcome framework.
2. **No Burden:** Both files are small (~65 KB combined) and do not interfere with challenge work.
3. **No Build Dependency:** Neither `web/build.js` nor any other build/deploy pipeline reads these files.
4. **Intentional, Not Accidental:** Added explicit comments to setup and clean scripts to document that preservation is intentional, not accidental.

**Implementation:**
- `scripts/setup-challenge.sh` and `scripts/setup-challenge.ps1` do NOT remove `byoc/` or `OUTCOMES.md`
- `scripts/_clean-common.sh` and `scripts/_clean-common.ps1` do NOT remove these files
- Added comments documenting this as intentional behavior for facilitator reference

**Verification:**
- `bash -n scripts/*.sh` -- all scripts pass syntax validation
- Devcontainer post-create calls `setup-challenge.sh` -- behavior unchanged, files preserved
- `web/build.js` -- no changes needed (does not read byoc/ or OUTCOMES.md)
- `.github/workflows/deploy-site.yml` -- no changes needed (triggers `node web/build.js`, no byoc/ reading)

**Why:** Participant workspaces are slightly larger (~65 KB) but gain access to facilitator reference materials. Non-breaking; all build, deploy, and container workflows remain unchanged.

## Governance

- All meaningful changes require team consensus
- Document architectural decisions here
- Keep history focused on work, decisions focused on direction
