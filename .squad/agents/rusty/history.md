# Rusty — History

## Core Context

- Project: GitHub Copilot Enterprise Hackathon challenge repo
- Owner: Marco Olivo
- 7 core tracks + 11 bonus tracks, each with stage files under the track directories in `tracks/`
- Track structure defined in tracks/TRACK_STRUCTURE.md (section order is mandatory)
- Writing style: .github/copilot-instructions.md -- no emoji headings, no em-dashes, no AI slop, no hype, natural developer voice
- Shared setup: tracks/getting-started.md (clean start, custom instructions, agents, open challenge)
- Stage files: Tasks (numbered), Verification (bullets), navigation footer (Previous/Next)
- Challenge folders have no README -- all instructions live in track files
- Azure-only constraint
- Content must describe WHAT to achieve, never provide ready-to-paste solutions

## Learnings

- (2026-06-15) Challenge 21 enrichment should make participants defend Terraform decisions, not build a bigger platform. Keep the scope to Azure Container Apps, remote state, network shape, managed identity and Key Vault, module reuse, CI policy, and drift response. Require short docs artifacts for plan review and trade-offs so the work cannot be completed by accepting generated HCL alone.

📌 Team update (2026-04-28): The docs site can add a curated entry layer for ordering and navigation, but the publishing path should stay lightweight and share one strict MkDocs build path with CI and GitHub Pages. -- decided by Scribe

📌 Correction note (2026-04-28): The repo now uses a single numbered challenge sequence through Challenge 18. Any older references to bonus tracks or bonus challenges in this history are historical only and should not be used for current work.

- (2026-06-12) The current catalog now extends through Challenge 21. Challenge 21 is the dedicated Azure Terraform track, with stage content focused on remote state, Azure platform setup, managed identity and Key Vault, module reuse, and CI plus drift handling. When updating docs that summarize the challenge range, keep the prose aligned with the table and repo structure.

- (2026-06-12) Challenge 21 follows the specialized-track phase convention, not the stage convention. Use `phase-*` filenames and Phase labels for its track sub-pages, and keep final newlines in every phase file for markdownlint hygiene.
