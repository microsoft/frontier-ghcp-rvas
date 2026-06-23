# Linus — History

## Core Context

- Project: GitHub Copilot Enterprise Hackathon challenge repo
- Owner: Marco Olivo
- Challenge folders under challenges/ -- 7 core + 11 bonus
- Multi-language: Node.js/TS (backend, SDK), Python (data science, flight delay), Terraform (DevOps), React/TS (frontend), .NET (QA)
- Starter code must scaffold without solving -- guide, don't hand-hold
- Each challenge has a matching devcontainer config under .devcontainer/
- Azure-only constraint for any cloud references
- No README files in challenge folders -- instructions live in tracks/

## Learnings

## Learnings

### 2026-06-23: Web foundation build

**Layout**: The `web/` directory contains the bespoke static site for the GitHub Copilot Enterprise Hackathon. Structure is:

- `web/build.js` — dependency-free Node build script (core modules only).
- `web/index.html` + `web/assets/js/home.js` — home page with canonical shared header/footer shell.
- `web/assets/js/core.js` — FP API providing data loading, theme, nav, kiosk, reveal, markdown rendering.
- `web/assets/js/marked.min.js` — copied verbatim from reference repo.
- `web/assets/css/styles.css` — adapted from reference, using 5 category colors instead of 4 module colors.
- `web/assets/data/` — GENERATED, git-ignored; contains `platform.json`, `paths.json`, challenge guides, and content pages.

**FP API surface** (locked contract in `core.js`):

- `FP.loadData()` → Promise(platform.json), cached.
- `FP.loadPaths()` → Promise(paths.json), cached.
- `FP.categoryColor(id)`, `FP.categoryName(id, categories)` → map category IDs to CSS vars and names.
- `FP.challengeUrl(id)`, `FP.catalogUrl(catId)`, `FP.guideUrl(slug)`, `FP.setUrl(ids, name)` → URL builders.
- `FP.diffBadge(d)`, `FP.durBadge(mins)`, `FP.tagBadges(tags, limit)` → HTML badge generators.
- `FP.kioskParams()`, `FP.isKiosk()`, `FP.applyKiosk()`, `FP.kioskChallengeUrl(id, params)` → curated set support.
- `FP.initTheme()`, `FP.initNav()`, `FP.initReveal()`, `FP.renderError(el, msg)` → UI initialization.
- `FP.renderMd(raw, el)`, `FP.renderInlineMd(raw)` → markdown rendering with sanitization.
- Auto-init on DOMContentLoaded: theme, nav, kiosk, reveal.

**build.js inputs/outputs**:

- **Inputs**: `challenges/<slug>/meta.yml` (single source of truth for each challenge), `learning-paths.json` (repo root), track markdown files (`tracks/<name>.md` + stage/phase files).
- **Outputs**:
  - `web/assets/data/platform.json` — full catalog (categories + challenges with category, category_name, difficulty, duration, description, focus, tags, prerequisites, track_url, starter_path, guide path).
  - `web/assets/data/paths.json` — curated learning paths.
  - `web/assets/data/challenges/<id>/guide.md` — concatenated guide (main track + stage/phase files in order).
  - `web/assets/data/pages/<slug>.md` — content docs (copilot-guide, prompt-engineering, mcp-servers, facilitator-guide, troubleshooting, getting-started).
- **Validation**: every meta.yml has required fields; category is one of the 5; every learning-path challenge_id and prerequisites[] entry resolves; exits non-zero on error.
- **Category metadata** is hardcoded in build.js per the contract.

**Deviations from reference**:

- Renamed `module` → `category` throughout (5 categories vs 4 modules).
- Single hackathon branding: "GitHub Copilot Enterprise Hackathon" (no four-module compass).
- Category IDs and colors per contract: `core-tracks` (#58a6ff), `team-sprints` (#3fb950), `legacy-modernization` (#d29922), `workflow-automation` (#a371f7), `azure-platform` (#ec6547).
- Added `FP.loadPaths()` for learning paths support.
- Home page leads with 5 categories + curated paths, not modules + outcomes.
- CSS utility classes: `.cat-<id>` with `--cat-color` instead of `.mod-<id>` with `--mod-color`.

**Testing**: Build runs clean with test stubs. When real meta.yml files land, the build will populate platform.json and paths.json automatically. Other agents own authoring those files.

### 2026-06-23: Student set feature and multi-page site delivery

**Pages delivered**: Implemented 5 page pairs (HTML + JS + optional CSS) on the locked FP API foundation:

1. **Catalog page** (`catalog.html`, `catalog.js`) — filterable/searchable 22-challenge grid, grouped by category with live counts, deep links (?cat=<id>, ?difficulty=<level>), all FP.* helpers reused, no custom CSS.

2. **Challenge detail page** (`challenge.html`, `challenge.js`, `challenge.css`) — single view for any challenge reading ?id param, renders hero/metadata sidebar/prerequisites/guide content, fetches guide markdown via FP.renderMd(), handles kiosk mode (preserves ?set param on internal links to keep students in curated set), scoped CSS for typography and layout only.

3. **Builder page** (`builder.html`, `builder.js`) — coaches multi-select challenges via category/difficulty/search filters, track selection state in a Set, generate shareable student set URL using FP.setUrl(), copy/open buttons for sharing, all FP.* helpers reused, no custom CSS.

4. **Student set page** (`set.html`, `set.js`) — displays curated challenges from ?ids=comma-separated param, auto-enters kiosk mode (hides nav links, injects exit button, preserves kiosk state on challenge links), challenges grouped by category, empty states (no ids → link to builder, unknown ids → silent filter, no valid → error message).

5. **Learning paths page** (`paths.html`, `paths.js`, `paths.css`) — loads 8 curated paths from paths.json, resolves challenge IDs to titles, renders path cards with challenge lists and share-as-set controls (absolute URL via FP.setUrl()), copy/open buttons.

6. **Guide page** (`guide.html`, `guide.js`, `guide.css`) — reads ?p=<slug> param (defaults to copilot-guide), fetches markdown from assets/data/pages/<slug>.md, renders via FP.renderMd() with marked.js, sidebar nav lists all guides with active state highlighting, unknown slug shows FP.renderError().

**Kiosk mode**: The feature that allows coaches to lock student views to a specific challenge set. Implemented via FP.kioskParams() (extracts ?set=<set_id> from URL), FP.isKiosk() (true if in kiosk), FP.applyKiosk() (hides nav, footer, injects exit button), and FP.kioskChallengeUrl(id, params) (constructs links that preserve kiosk state). Set and challenge pages auto-enter kiosk mode if ?set param is present; all internal links preserve it so students never accidentally escape to the full catalog.

**Technical invariants**: All pages copy header/footer verbatim from index.html to ensure consistent branding and nav. No edits to core.js, build.js, styles.css, or sibling pages. Reused all existing CSS classes from styles.css (.card, .btn, .badge, .sel-card, .set-tray, .filters, .challenge-grid, etc.). All URL generation, data loading, markdown rendering, and kiosk logic delegated to FP.* helpers without modification. JavaScript syntax validated with `node --check` for all 9 files.

**Governance note**: The locked FP API and shared shell pattern allowed 5 page pairs to be developed in parallel without merge conflicts or coordination overhead. Build.js + core.js + home shell form the immutable foundation; all other pages are additive layers that cannot break each other. Future page additions should follow the same pattern.

### 2026-06-23: Outcome-driven data model implementation

**Outcome taxonomy**: Implemented the six-outcome business taxonomy (modernize-legacy, ship-features, raise-quality, automate-delivery, platform-foundation, build-ai) additively on top of the existing 5-category color scheme. Category controls visual grouping; outcomes describe work results. Both are independent dimensions.

**meta.yml outcomes field**: Added `outcomes:` list field to all 22 `challenges/*/meta.yml` files positioned consistently near the `tags` field. Multi-valued: challenges map to one or more outcomes based on the deliverable they produce. The field is validated at build time against the canonical OUTCOME_CONFIG.

**build.js additions**: Added `OUTCOME_CONFIG` constant (lines 26-53) with the six canonical outcome definitions (id, name, description). Added validation loop (lines 202-207) that fails the build if any meta.yml contains an unknown outcome ID. Emit outcomes into each challenge object in platform.json (line 217), and added top-level `outcomeConfig` array to platform.json (lines 360-364) so the frontend can render labels without hardcoding.

**learning-paths.json reframing**: Added `outcomes: [..]` field to all 8 paths, derived from their constituent challenges. Renamed path `name` and `description` fields to be outcome-led (removed "learning journey" and "mastery" language in favor of outcome framing like "Product Delivery", "Automation", "AI Capabilities"). Kept `id` and `challenge_ids` unchanged for compatibility.

**tracks/TRACK_STRUCTURE.md update**: Added "Outcome Framing" subsection in Rules (lines 95-101) documenting that outcomes live in metadata and framing docs, NOT as a new track-file section. The existing "No Learning Outcomes section" rule remains in full force. Referenced the new BYOC templates in byoc/templates/.

**BYOC templates**: Created `byoc/templates/` directory with three authoring skeletons for customer-authored challenges: `track-template.md` (main track file matching canonical section order with {{placeholders}}), `stage-template.md` (stage skeleton with Tasks, Verification, Copilot vs Judgment, navigation), and `meta.yml.template` (annotated meta.yml with inline comments explaining valid values for outcomes, category, difficulty, prerequisites). Templates describe WHAT to fill, not HOW to solve.

**Verification**: Build passes (`node web/build.js` reports 22 challenges, 5 categories, 8 learning paths, exit 0). platform.json emits outcomes correctly (verified challenge-1 has `"outcomes": ["ship-features", "raise-quality"]`). All 22 meta.yml files contain valid outcomes per OUTCOMES.md mapping. No breaking changes to existing category or site structure.

### 2026-06-23: Outcome-driven site reframe and BYOC page

**Website narrative updates**: Reframed web/index.html copy from learning-centric to outcome-driven per WS4 plan. Hero now leads with "Drive outcomes. Build skills as you ship." Categories section changed from "Five learning journeys" to "Pick your outcome path" emphasizing business outcomes over activities. Learning paths section changed to "Paths to measurable outcomes" focusing on deliverables. All copy humanized -- no hype, no em-dashes, no emoji in headings.

**Outcome surfacing (data-driven, zero hardcoded labels)**: Added outcome display across three pages consuming `platform.json` `outcomes` + `outcomeConfig` fields that build.js already emits:

- **Catalog (catalog.html/.js)**: Added outcome filter chipset alongside category and difficulty. URL parameter support (`?outcome=<id>`) for deep linking. Outcome badges displayed on all challenge cards below footer (using new `FP.outcomeBadges()` helper). Filter logic updated to support multi-filter state (category + outcome + difficulty + search).
- **Challenge detail (challenge.html/.js)**: Outcome badges rendered in hero metadata row using outcomeConfig for labels and descriptions (tooltip). Passed as parameter from init to avoid async in render function.
- **Paths (paths.html/.js)**: Each learning path card now displays its outcomes as badges below description. Reads from `paths.json` `outcomes` field (already emitted by build; learning-paths.json has it). Badge generation uses cached outcomeConfig from platform data.

**Core.js FP API extension (additive)**: Added `FP.outcomeBadges(outcomeIds, outcomeConfig)` helper function (lines 71-77) to render outcome badges with names from config and descriptions as tooltips. Follows existing badge helper pattern. Non-breaking addition; all existing pages work without modification.

**BYOC page (new)**: Created web/byoc.html + web/assets/js/byoc.js following the shared header/footer shell pattern. Page structure:

- Hero: introduces Bring Your Own Challenge concept -- run hackathons on your own codebase using the 22 challenges as worked examples.
- Kit Overview section: four cards linking to the GitHub repo paths for Outcome Canvas, Facilitator Runbook, Outcome Scorecard, and Example Walkthrough (byoc/*.md files).
- Templates section: three cards linking to track-template.md, stage-template.md, and meta.yml.template under byoc/templates/.
- Getting Started: six-step ordered list (define outcome, map work, author challenge, prepare environment, run hackathon, assess outcome) with inline links to kit files.
- Related Resources: links to BYOC README, TRACK_STRUCTURE.md, and catalog page.
- All GitHub links use absolute URLs (https://github.com/marcoolivo/frontier-ghcp-hackathon/...) so the page is dependency-free and works from GitHub Pages without repo-local file access.
- JS file is minimal (static page, reveal animations handled by core.js).

**Navigation consistency**: Added BYOC link to nav on all 9 pages (index, catalog, challenge, builder, set, paths, byoc, guide). Link positioned between "Learning Paths" and "Guides" across the site. aria-current updated per page.

**Verification**: `node web/build.js` passes (22 challenges, 5 categories, 8 learning paths, exit 0). All 11 JavaScript files pass `node --check` (core, home, catalog, challenge, paths, builder, set, guide, byoc, build.js). Outcomes surfaced correctly on catalog filter, challenge detail badges, and path cards. BYOC page renders with all links to GitHub repo kit files. No breaking changes to existing FP API or page scripts.

### 2026-06-23 -- Team convention: Outcomes facet + BYOC kit (Scribe orchestration)

- **Outcome-driven data model:** All 22 challenges now have `outcomes` field in meta.yml (multi-valued YAML list) defined per Danny's outcome taxonomy. `web/build.js` validates each outcome ID against `OUTCOME_CONFIG` map. `platform.json` emits per-challenge outcomes + top-level `outcomeConfig` for rendering. `learning-paths.json` updated with `outcomes` fields derived from constituent challenges.
- **Website surfaces outcomes:** Catalog page filters by outcome. Challenge detail and path cards display outcome badges. Core.js has `FP.outcomeBadges()` helper for consistent rendering. BYOC page added as entry point for custom hackathons. All outcome labels and descriptions are data-driven (from outcomeConfig) -- no hardcoded labels in scripts.
- **BYOC templates:** Created `byoc/templates/{track-template.md, stage-template.md, meta.yml.template}` for customer authoring of new challenges. Templates use {{placeholders}} showing what to fill in, not how to solve. All templates follow TRACK_STRUCTURE rules and include outcomes field in meta.yml.
- **Implication for future work:** Any new challenge must define 1+ outcome IDs in meta.yml. Site updates must preserve outcomes data flow (build.js -> platform.json -> FP API -> rendering). The BYOC kit is the facilitator-facing framework for running hackathons on customer codebases.
