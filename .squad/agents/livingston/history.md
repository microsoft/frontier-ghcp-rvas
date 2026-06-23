# Livingston -- History

## Core Context

- Project: GitHub Copilot Enterprise Hackathon challenge repo
- Owner: Marco Olivo
- 18 tracks total (7 core + 11 bonus) must follow TRACK_STRUCTURE.md
- Markdownlint config at .markdownlint.json
- Writing style rules at .github/copilot-instructions.md
- Sync rules: track ↔ challenge ↔ devcontainer ↔ README.md
- Stage files need: Tasks (numbered), Verification (bullets), navigation footer
- No emoji in headings, no em-dashes, no AI slop, no hype, code fences need lang tags
- Azure-only constraint

## Learnings

📌 Team update (2026-04-28): MkDocs and GitHub Pages changes should be validated with `mkdocs build --strict`, and docs link or navigation fixes count as release-blocking if they break the curated site flow. -- decided by Scribe

- (2026-06-12) Challenge-selection reviews need to check both the table rows and the instructional prose around them. Catalog drift can show up as stale range wording even when the table itself is correct.

- (2026-06-12) Challenge 21 consistency review: missing final newlines in phase files are release-blocking markdown hygiene. After newline-only cleanup, focused markdownlint passed for the Challenge 21 track files.

- (2026-06-15) Challenge 21 richness review approved the enriched Azure Terraform path as workshop-sized. Future reviews should check that infrastructure challenges include judgment evidence, such as rejected generated suggestions, plan consequences, identity trade-offs, CI gate reasoning, and drift response, without turning into a full landing-zone build.

- (2026-06-23) QA review of bespoke site migration: comprehensive validation covering markdownlint (0 errors after em-dash fixes), writing style compliance (no emoji/em-dashes/hype, Azure-only), build integrity (`node web/build.js` passes with 22 challenges/5 categories/8 paths), dangling MkDocs references (0 matches), JS syntax (9 files pass `node --check`). Pre-existing issues flagged (out of scope for migration): challenges 1, 2, 11, 18, 19 have folder/track/devcontainer naming mismatches; recommended for future Gentry/Marco resolution. Web/README.md fixed (em-dashes replaced with --). Migration validated as release-ready.

- (2026-06-23) Outcome-driven reframe + BYOC kit final QA gate: **PASS**. All checks passed on first run:
  * Markdownlint: `npx -y markdownlint-cli2` passed 13 changed/new .md files (0 errors)
  * Build: `node web/build.js` passed (22 challenges, 5 categories, 8 learning paths, outcomeConfig present)
  * JS syntax: `node --check` passed on 10 changed/new JS files (web/build.js, web/assets/js/*.js)
  * Outcome taxonomy consistency: All 22 challenges have outcomes in meta.yml matching OUTCOMES.md mapping table exactly; build.js OUTCOME_CONFIG matches OUTCOMES.md definitions; learning-paths.json has outcomes; platform.json contains per-challenge outcomes + top-level outcomeConfig
  * Writing style: 0 emoji in headings (except allowed role-themed emoji in track listings per rules), 0 em-dashes, 0 hype language, 0 AI sign-offs, natural human phrasing
  * Sync rules: README track links valid, BYOC nav present across all 8 web/*.html pages, tracks/TRACK_STRUCTURE.md preserves "No Learning Outcomes section" rule, byoc/ cross-links resolve
  * Scripts: `bash -n` passed on scripts/_clean-common.sh and scripts/setup-challenge.sh
  * No mechanical fixes required (first-pass clean). No substantive issues requiring author revision. Release-ready as delivered.

- (2026-06-23) **Team convention: Outcomes facet + BYOC kit (Scribe orchestration)** -- QA gate for the session finalized and logged to `.squad/decisions.md`. The 6-outcome taxonomy (Danny), outcome-driven narrative reframe (Rusty), outcome-surfaced website (Linus), BYOC kit + templates (Rusty/Linus), intentional preservation of byoc/OUTCOMES.md (Basher) are now a cohesive team convention. Future reviews must check: (1) any new challenge has 1+ outcome IDs in meta.yml per OUTCOMES.md; (2) outcomes flow through build.js -> platform.json -> FP.outcomeBadges() for rendering; (3) narrative/copy uses outcome-first language ("what will teams deliver?"); (4) BYOC kit files + templates remain accessible in facilitator workspace.
