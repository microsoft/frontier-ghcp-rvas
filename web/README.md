# GitHub Copilot Adoption -- Web Site

Bespoke static site for the GitHub Copilot Adoption delivery session. No server required -- just open `index.html` after building.

## Build

```bash
node web/build.js
```

Reads `challenges/*/meta.yml`, `learning-paths.json`,
`role-collections.json`, and track markdown, then generates:

- `web/assets/data/platform.json` -- full catalog and each challenge's page manifest
- `web/assets/data/paths.json` -- curated learning paths
- `web/assets/data/roles.json` -- curated enterprise role collections
- `web/assets/data/challenges/<id>/pages/<page-id>.md` -- one Markdown payload per challenge page
- `web/assets/data/pages/<slug>.md` -- content docs

The `assets/data/` directory is generated and git-ignored.

## Challenge page model

A challenge is published as a page set:

1. The main track file is the overview.
2. The committed `stages.md` file is the contents page.
3. Each stage is a dedicated page.
4. Role-specific pages, where present, are nested under their parent stage.

The right-side **Challenge pages** menu reflects this hierarchy. Pages can be
opened directly with `challenge.html?id=<id>&page=<page-id>`. If `page` is
omitted, the overview opens.

The `pages` array for each challenge in `platform.json` is its page manifest.
Each entry identifies the page, its type and parent, its source, its generated
`content_url`, and any previous or next page. The Markdown itself is generated
as a separate payload at
`assets/data/challenges/<id>/pages/<page-id>.md`.

## Pages

- `index.html` -- home page (categories + learning paths + featured challenge)
- `catalog.html` -- challenge catalog
- `challenge.html` -- paged challenge content and navigation
- `builder.html` -- curated set builder
- `set.html` -- curated set landing page
- `paths.html` -- learning paths overview
- `roles.html` -- challenges grouped by enterprise role
- `guide.html` -- content guide renderer

## Shared shell

Copy the `<header>` and `<footer>` from `index.html` verbatim into every page. Load `core.js` first, then your page script.

## Cache busting

Local CSS and JS includes carry a `?v=N` query string (for example `core.js?v=2`). Static
hosts ignore the query and serve the file, but browsers treat each version as a separate
cache entry. When you change a shared asset (`core.js`, `styles.css`) or any page script,
bump the `?v=N` value on the affected includes across all pages. This prevents a new page
script from pairing with a stale cached `core.js`, which throws a runtime error such as
`FP.diffBadge is not a function`.

## FP API

`window.FP` provides:

- `FP.loadData()` → Promise(platform.json), cached
- `FP.loadPaths()` → Promise(paths.json), cached
- `FP.loadRoles()` → Promise(roles.json), cached
- `FP.categoryColor(id)`, `FP.categoryName(id, categories)` → category utilities
- `FP.challengeUrl(id)`, `FP.catalogUrl(catId)`, `FP.guideUrl(slug)`, `FP.setUrl(ids, name)` → URL builders
- `FP.diffBadge(d)`, `FP.durBadge(mins)`, `FP.tagBadges(tags, limit)` → badge generators
- `FP.kioskParams()`, `FP.isKiosk()`, `FP.applyKiosk()`, `FP.kioskChallengeUrl(id, params)` → kiosk mode
- `FP.initTheme()`, `FP.initNav()`, `FP.initReveal()`, `FP.renderError(el, msg)` → UI init
- `FP.renderMd(raw, el)`, `FP.renderInlineMd(raw)` → markdown rendering

Auto-initializes theme, nav, kiosk, reveal on DOMContentLoaded.

## Categories

| ID | Name | Color |
|----|------|-------|
| core-tracks | Core Tracks | #0078d4 |
| team-sprints | Team Sprints | #14868a |
| legacy-modernization | Legacy Modernization | #504092 |
| workflow-automation | Workflow Automation | #1a77e3 |
| azure-platform | Azure Platform | #032254 |

Use `.cat-<id>` CSS class + `style="--cat-color:<color>"` for category-specific styling.

## Role collections

`role-collections.json` is the source of truth for the Roles page and homepage
role cards. Each role has a stable ID, name, description, and curated list of
challenge IDs.

The build fails when a role is empty, contains duplicate or unknown challenge
IDs, or leaves a challenge without a role. Role order is editorial relevance,
not a prerequisite sequence.

## Serving locally

```bash
python3 -m http.server 8000 --directory web
open http://localhost:8000
```

Or use any static file server.
