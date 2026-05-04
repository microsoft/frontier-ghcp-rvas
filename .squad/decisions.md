# Squad Decisions

## Active Decisions

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

## Governance

- All meaningful changes require team consensus
- Document architectural decisions here
- Keep history focused on work, decisions focused on direction
