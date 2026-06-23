# Danny -- History

## Core Context

- Project: GitHub Copilot Enterprise Hackathon challenge repo
- Owner: Marco Olivo
- Stack: Multi-language (Node.js/TS, Python, .NET, Terraform, React), Markdown-heavy content, devcontainers
- 7 core tracks + 11 bonus tracks, each with challenge folders, devcontainer configs, and stage files
- Strict structural rules defined in tracks/TRACK_STRUCTURE.md
- Writing style rules in .github/copilot-instructions.md (no AI slop, no emoji headings, no em-dashes)
- Azure-only constraint
- Sync rules: track ↔ challenge ↔ devcontainer ↔ README must stay aligned

## Learnings

📌 Correction note (2026-04-28): The repo now uses a single numbered challenge sequence through Challenge 18. Any older references to bonus tracks or bonus challenges in this history are historical only and should not be used for current work.

## Learnings

### 2026-06-01 -- MkDocs nav full expansion (GitHub Pages)
- `docs/tracks` is a SYMLINK to `../tracks`. Plain `find docs/tracks` returns nothing; must use `find -L docs/tracks` to follow the symlink when enumerating sub-pages.
- Nav nesting convention adopted for every challenge that has sub-pages:
  - Challenge becomes a nav SECTION. First child is `Overview:` -> the main `*-track.md` page.
  - Stage challenges (0,1,2,3,4,5,6,20): Overview + `Stage N - Title` in numeric order.
  - Single-phase challenges (7,8,11-19): Overview + `Phase N - Title` in numeric order.
  - Sprint challenges (9,10): Overview + each phase as a nested sub-section (Overview + role pages).
  - Role order, sprint phases: Product Owner, Business Analyst, Frontend Developer, Backend Developer, QA Engineer, DevOps Engineer. Challenge 10 has no PO/BA, so it starts at Frontend Developer.
- Titles use single ` - ` separator to match the existing nav style ("Challenge 0 - Product Planning"), NOT em-dash and NOT `--`. Titles derived from filenames/H1, kept concise.
- Added challenges 19 and 20 (were on disk but missing from nav entirely) + `tracks/TRACK_STRUCTURE.md` (as top-level "Track Structure").
- Count: 168 track .md files, all now in nav exactly once; 147 of them newly added.
- Verify with `. .venv-docs/bin/activate && mkdocs build --strict`. Strict FAILS on warnings (bad paths), but "not in nav" messages are INFO-level and do NOT fail strict. Leftover INFO entries are `challenges/**` starter materials and a nested `docs/docs/` mirror -- intentionally NOT in site nav (exercise files, not docs). Build must stay exit 0 / warning-free.

### 2026-06-12 -- Challenge 21 Azure Terraform alignment
- Challenge 21 is now the dedicated Azure Terraform track/challenge pair. Treat it as separate from Challenge 3 DevOps when updating catalog, nav, or challenge-selection copy.
- `docs/challenge-selection.md` needs a full wording pass whenever the challenge table expands or is renumbered; the surrounding step text must match the visible table range, not just the table rows.
- Challenge 21 follows the specialized-track phase convention (`phase-*` files, Phase labels in MkDocs). Its single participant Terraform root is `challenges/challenge-21-azure-terraform/terraform/azure`; do not reintroduce duplicate root-level `.tf` files under `terraform/`.
- When normalizing a track from stage-style naming to phase-style naming, check filenames, H1s, navigation labels, relative links, devcontainer paths, workflow paths, and setup-script output together so participants see one coherent working path.

### 2026-06-15 -- Challenge 21 richness guardrails
- Enrich Challenge 21 through judgment pressure, not platform sprawl. Keep it Azure-only, phase-based, and scoped to Azure Container Apps, remote state, network shape, managed identity and Key Vault, module cleanup, CI gates, and drift response.
- Future Challenge 21 edits should preserve the 4-6 hour cap by sharpening evidence prompts and acceptance criteria instead of adding a sixth phase or larger Azure architecture.

### 2026-06-23 -- Outcome taxonomy finalized
- Six outcome categories defined: `modernize-legacy`, `ship-features`, `raise-quality`, `automate-delivery`, `platform-foundation`, `build-ai`. All 22 challenges mapped; every outcome has 2+ challenges.
- Data-model decision: `category` (existing, single-valued, color grouping) preserved unchanged. New `outcomes` field (multi-valued YAML list) added to `meta.yml`. `web/build.js` gains `OUTCOME_CONFIG` map for validation. `platform.json` emits outcomes per challenge + top-level `outcomeConfig`.
- These are work/business outcomes (shipped deliverables), not learning objectives. The `TRACK_STRUCTURE.md` ban on "Learning Outcomes" sections in track files remains in effect.
- Authoritative spec: `OUTCOMES.md` at repo root. Decision logged to `.squad/decisions.md`.

### 2026-06-23 -- Team convention: Outcomes facet + BYOC kit (Scribe orchestration)
- **Emerged convention:** All challenges now carry an `outcomes` facet in their metadata (defined by Danny). The hackathon narrative (Rusty) shifted from learning-centric to outcome-driven. The website (Linus) surfaces outcomes through badges and filtering. Facilitators now have a BYOC kit (5 prose files + 3 templates) to run hackathons on customer codebases using an outcome-canvas, facilitator-runbook, and outcome-scorecard framework.
- **Key decisions logged:** danny-outcome-taxonomy.md, rusty-byoc-narrative.md, linus-outcome-datamodel.md, linus-site-outcomes.md, basher-byoc-tooling.md, livingston-outcome-review.md merged into `.squad/decisions.md`.
- **Impact on future work:** Any new challenge must define its outcomes (1+ IDs from the 6 canonical outcomes) in meta.yml. Any narrative/copy update must use outcome-first framing ("what will teams deliver?") instead of learning-first framing. Site updates must preserve the outcomes filter and badges. BYOC kit files (canvas, runbook, scorecard, templates) are reference material for facilitators and customers authoring custom hackathons.
