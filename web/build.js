#!/usr/bin/env node
/**
 * GitHub Copilot Adoption -- build step (dependency-free, Node core only).
 *
 * Reads challenges/<slug>/meta.yml as the single source of truth and emits:
 *   web/assets/data/platform.json
 *   web/assets/data/paths.json
 *   web/assets/data/roles.json
 *   web/assets/data/challenges/<id>/pages/<page-id>.md
 *   web/assets/data/pages/<slug>.md
 *
 * Validation (exits non-zero on errors):
 *   - Every meta.yml has required fields, including track_url and contents_url
 *   - Category is one of the 5 valid categories
 *   - Challenge page IDs, parent relationships, and navigation are valid
 *   - Every learning-path challenge_id and prerequisites[] entry resolves to a real challenge
 *   - Every role collection is valid and every challenge belongs to at least one role
 *
 *   node web/build.js
 */
'use strict';

const fs   = require('fs');
const path = require('path');

/* ─── Category config (LOCKED per contract) ─────────────────────────────────
 * These are the 5 categories for this GitHub Copilot Adoption delivery session.
 * ─────────────────────────────────────────────────────────────────────────── */
const CATEGORY_CONFIG = {
  'core-tracks': {
    name: 'Core Tracks',
    description: 'Foundational GitHub Enterprise and Copilot skills -- API development, machine learning, DevOps, and frontend engineering.',
    color: '#0078d4'
  },
  'team-sprints': {
    name: 'Team Sprints',
    description: 'Multi-role sprint challenges -- product management, business analysis, development, QA, and DevOps working together.',
    color: '#14868a'
  },
  'legacy-modernization': {
    name: 'Legacy Modernization',
    description: 'Migrate MUMPS, COBOL, and WCF systems to modern platforms with GitHub Copilot assistance.',
    color: '#504092'
  },
  'workflow-automation': {
    name: 'Workflow Automation',
    description: 'Build AI-powered automation for documentation, pipelines, backlog generation, ops assistance, and end-to-end delivery.',
    color: '#1a77e3'
  },
  'azure-platform': {
    name: 'Azure Platform',
    description: 'Azure infrastructure and deployment automation with Terraform, PowerShell, and GitHub Actions.',
    color: '#032254'
  }
};

/* ─── Paths ──────────────────────────────────────────────────────────────── */
const ROOT                = path.resolve(__dirname, '..');
const CHALLENGES_DIR      = path.join(ROOT, 'challenges');
const TRACKS_DIR          = path.join(ROOT, 'tracks');
const DOCS_DIR            = path.join(ROOT, 'docs');
const OUT_DATA_DIR        = path.join(__dirname, 'assets', 'data');
const OUT_CHALLENGES_DIR  = path.join(OUT_DATA_DIR, 'challenges');
const OUT_PAGES_DIR       = path.join(OUT_DATA_DIR, 'pages');
const LEARNING_PATHS_PATH = path.join(ROOT, 'learning-paths.json');
const ROLE_COLLECTIONS_PATH = path.join(ROOT, 'role-collections.json');
const FACILITATOR_PATH    = path.join(ROOT, 'FACILITATOR_GUIDE.md');
const TROUBLESHOOT_PATH   = path.join(ROOT, 'TROUBLESHOOTING.md');

/* ─── Repository (for resolving relative links in guides) ─────────────────── */
const REPO_URL    = 'https://github.com/microsoft/frontier-ghcp-rvas';
const REPO_BRANCH = 'main';

/* ─── Minimal YAML parser ────────────────────────────────────────────────────
 * Handles only the locked meta.yml contract: scalar key-value pairs, block
 * lists, inline comments. NOT a general parser -- intentional.
 * ─────────────────────────────────────────────────────────────────────────── */
function parseMeta(text) {
  const out          = {};
  let currentListKey = null;
  const lines = text.split(/\r?\n/);

  for (let i = 0; i < lines.length; i++) {
    const raw = lines[i];
    if (!raw.trim() || /^\s*#/.test(raw)) continue;

    const listItem = raw.match(/^\s*-\s+(.*)$/);
    if (listItem && currentListKey) {
      const val = stripComment(listItem[1]).trim();
      if (val) out[currentListKey].push(val);
      continue;
    }

    const kv = raw.match(/^([A-Za-z0-9_]+):\s*(.*)$/);
    if (!kv) continue;

    const key  = kv[1];
    const rest = stripComment(kv[2]).trim();

    if (/^[>|][+-]?$/.test(rest)) {
      const blockLines = [];
      for (i = i + 1; i < lines.length; i++) {
        const next = lines[i];
        if (!next.trim()) {
          blockLines.push('');
          continue;
        }
        if (/^\S/.test(next)) {
          i--;
          break;
        }
        blockLines.push(next);
      }
      out[key]       = coerceBlock(rest[0], blockLines);
      currentListKey = null;
    } else if (rest === '' || rest === '[]') {
      out[key]       = [];
      currentListKey = key;
    } else {
      out[key]       = coerce(rest);
      currentListKey = null;
    }
  }
  return out;
}

function stripComment(s) {
  return s.replace(/\s+#.*$/, '');
}

function coerce(v) {
  if (v === 'true')  return true;
  if (v === 'false') return false;
  if (/^-?\d+$/.test(v)) return Number(v);
  return v.replace(/^["']|["']$/g, '');
}

function coerceBlock(style, lines) {
  const nonBlank = lines.filter(line => line.trim());
  const indent = nonBlank.length ? Math.min(...nonBlank.map(line => line.match(/^\s*/)[0].length)) : 0;
  const normalized = lines.map(line => line.trim() ? line.slice(indent).replace(/\s+$/, '') : '');
  if (style === '|') return normalized.join('\n').trim();

  let out = '';
  let previousBlank = false;
  for (const line of normalized) {
    if (!line.trim()) {
      if (out && !previousBlank) out += '\n';
      previousBlank = true;
      continue;
    }
    if (out && !out.endsWith('\n')) out += ' ';
    out += line.trim();
    previousBlank = false;
  }
  return out.trim();
}

/* ─── Helpers ─────────────────────────────────────────────────────────────── */
function readDirSafe(p) {
  try { return fs.readdirSync(p, { withFileTypes: true }); }
  catch { return []; }
}

function readFileSafe(p) {
  try { return fs.readFileSync(p, 'utf8'); }
  catch { return null; }
}

function ensureDir(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
}

/* ─── Collect challenges ─────────────────────────────────────────────────── */
function collectChallenges() {
  const challenges = [];
  const errors = [];

  for (const entry of readDirSafe(CHALLENGES_DIR)) {
    if (!entry.isDirectory()) continue;
    const slug = entry.name;
    const metaPath = path.join(CHALLENGES_DIR, slug, 'meta.yml');
    
    if (!fs.existsSync(metaPath)) continue;

    const raw = readFileSafe(metaPath);
    if (!raw) {
      errors.push(`Could not read ${metaPath}`);
      continue;
    }

    try {
      const meta = parseMeta(raw);
      
      if (!meta.id) {
        errors.push(`${slug}/meta.yml: missing 'id' field`);
        continue;
      }
      if (!meta.title) {
        errors.push(`${slug}/meta.yml: missing 'title' field`);
        continue;
      }
      if (!meta.category) {
        errors.push(`${slug}/meta.yml: missing 'category' field`);
        continue;
      }
      if (!CATEGORY_CONFIG[meta.category]) {
        errors.push(`${slug}/meta.yml: invalid category '${meta.category}' (must be one of: ${Object.keys(CATEGORY_CONFIG).join(', ')})`);
        continue;
      }
      if (!meta.track_url) {
        errors.push(`${slug}/meta.yml: missing 'track_url' field`);
        continue;
      }
      if (!meta.contents_url) {
        errors.push(`${slug}/meta.yml: missing 'contents_url' field`);
        continue;
      }

      const challenge = {
        id: meta.id,
        number: meta.number || 0,
        title: meta.title,
        category: meta.category,
        category_name: CATEGORY_CONFIG[meta.category].name,
        difficulty: meta.difficulty || 'intermediate',
        duration_minutes: meta.duration_minutes || 360,
        description: meta.description || '',
        focus: meta.focus || '',
        tags: Array.isArray(meta.tags) ? meta.tags : [],
        prerequisites: Array.isArray(meta.prerequisites) ? meta.prerequisites : [],
        track_url: meta.track_url,
        contents_url: meta.contents_url,
        starter_path: `challenges/${slug}/`,
        pages: []
      };

      challenges.push(challenge);
    } catch (e) {
      errors.push(`${slug}/meta.yml: parse error: ${e.message}`);
    }
  }

  return { challenges, errors };
}

/* ─── Challenge page publishing ───────────────────────────────────────────────
 * Track sources are published as separate Markdown payloads. Links between
 * published challenge pages point back through challenge.html; other repository
 * links continue to resolve to GitHub.
 * ─────────────────────────────────────────────────────────────────────────── */
function pageSlug(value) {
  return value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function pageIdFromRelativePath(relativePath) {
  return relativePath
    .replace(/\\/g, '/')
    .replace(/\.md$/i, '')
    .split('/')
    .map(pageSlug)
    .filter(Boolean)
    .join('/');
}

function repoUrlFor(relPathFromRoot, isDir) {
  const clean = relPathFromRoot.replace(/\\/g, '/').replace(/\/+$/, '');
  return `${REPO_URL}/${isDir ? 'tree' : 'blob'}/${REPO_BRANCH}/${clean}`;
}

function challengePageUrl(challengeId, pageId, hash) {
  const query = new URLSearchParams({ id: challengeId, page: pageId });
  return `challenge.html?${query.toString()}${hash || ''}`;
}

/* Rewrite markdown links, but not images. `publishedPages` maps normalized
 * absolute source paths to page IDs. */
function rewriteChallengeLinks(content, fragmentDir, challengeId, publishedPages) {
  const LINK_RE = /(!?)\[((?:[^\]\\]|\\.)*)\]\(\s*([^()\s]+)((?:\s+"[^"]*")?)\s*\)/g;
  return content.replace(LINK_RE, (full, bang, text, target, title) => {
    if (bang) return full;
    const t = target.trim();
    if (!t) return full;
    if (t.startsWith('#') || t.startsWith('//') || /^[a-z][a-z0-9+.-]*:/i.test(t)) return full;

    let core = t;
    let hash = '';
    const hi = core.indexOf('#');
    if (hi >= 0) { hash = core.slice(hi); core = core.slice(0, hi); }
    if (!core) return full; // pure in-page anchor

    const isDir = core.endsWith('/');
    const absTarget = path.resolve(fragmentDir, core);
    const relToRoot = path.relative(ROOT, absTarget).replace(/\\/g, '/');
    if (relToRoot.startsWith('..')) return full;

    const key = absTarget.replace(/\\/g, '/').toLowerCase();
    if (!isDir && publishedPages.has(key)) {
      return `[${text}](${challengePageUrl(challengeId, publishedPages.get(key), hash)}${title})`;
    }
    return `[${text}](${repoUrlFor(relToRoot, isDir)}${hash}${title})`;
  });
}

function stripSourceNavigationFooter(content) {
  const lines = content.split(/\r?\n/);
  const kept = [];
  const navigationLine = /^\s*(?:(?:previous|next|back to|return to)\s*:?\s*)?\[(?:previous|next|back|return)[^\]]*\]\([^)]+\)(?:\s*\|\s*(?:(?:previous|next|back to|return to)\s*:?\s*)?\[(?:previous|next|back|return)[^\]]*\]\([^)]+\))*\s*$/i;
  const labeledNavigationLine = /^\s*(?:previous|next|back to|return to)\s*:\s*\[[^\]]+\]\([^)]+\)(?:\s*\|\s*(?:previous|next|back to|return to)\s*:\s*\[[^\]]+\]\([^)]+\))*\s*$/i;

  for (const line of lines) {
    if (!navigationLine.test(line) && !labeledNavigationLine.test(line)) {
      kept.push(line);
      continue;
    }

    let separatorIndex = kept.length - 1;
    while (separatorIndex >= 0 && !kept[separatorIndex].trim()) separatorIndex--;
    if (separatorIndex < 0 || !/^\s*---\s*$/.test(kept[separatorIndex])) {
      kept.push(line);
      continue;
    }

    kept.length = separatorIndex;
    while (kept.length && !kept[kept.length - 1].trim()) kept.pop();
  }

  return kept.join('\n').trim();
}

function markdownTitle(content, fallback) {
  const heading = content.match(/^\s*#\s+(.+?)\s*$/m);
  return heading ? heading[1].replace(/\s+#*$/, '').trim() : fallback;
}

function numericPageSort(a, b) {
  const aMatch = a.name.match(/^(?:stage|phase)-(\d+)/i);
  const bMatch = b.name.match(/^(?:stage|phase)-(\d+)/i);
  const numberDiff = Number(aMatch && aMatch[1]) - Number(bMatch && bMatch[1]);
  return numberDiff || a.name.localeCompare(b.name, undefined, { numeric: true });
}

function walkMarkdownFiles(dir) {
  const files = [];
  for (const entry of readDirSafe(dir).sort((a, b) => a.name.localeCompare(b.name, undefined, { numeric: true }))) {
    const entryPath = path.join(dir, entry.name);
    if (entry.isDirectory()) files.push(...walkMarkdownFiles(entryPath));
    else if (entry.isFile() && entry.name.endsWith('.md')) files.push(entryPath);
  }
  return files;
}

function collectChallengePages(challenge) {
  const errors = [];
  const trackPath = path.join(ROOT, challenge.track_url);
  const contentsPath = path.join(ROOT, challenge.contents_url);

  if (!fs.existsSync(trackPath)) {
    errors.push(`Challenge ${challenge.id}: track file not found at ${challenge.track_url}`);
  }
  if (!fs.existsSync(contentsPath)) {
    errors.push(`Challenge ${challenge.id}: contents file not found at ${challenge.contents_url}`);
  }
  if (fs.existsSync(contentsPath)) {
    const contentsType = path.basename(contentsPath, '.md').toLowerCase();
    if (!['stages', 'phases'].includes(contentsType)) {
      errors.push(`Challenge ${challenge.id}: contents_url must point to stages.md or phases.md`);
    } else {
      const rawContents = readFileSafe(contentsPath);
      if (rawContents === null) {
        errors.push(`Challenge ${challenge.id}: could not read ${challenge.contents_url}`);
      } else {
        const expectedTitle = `${challenge.title}: ${contentsType === 'stages' ? 'Stages' : 'Phases'}`;
        const actualTitle = markdownTitle(rawContents, '');
        if (actualTitle !== expectedTitle) {
          errors.push(
            `Challenge ${challenge.id}: ${challenge.contents_url} H1 must be '${expectedTitle}' (found '${actualTitle || '(missing)'}')`
          );
        }
      }
    }
  }
  if (errors.length) return { pages: [], sources: new Map(), errors };

  const trackDir = path.dirname(trackPath);
  const stageDir = path.join(trackDir, path.basename(trackPath, '.md'));
  const topLevelFiles = readDirSafe(stageDir)
    .filter(entry => entry.isFile() && /^(stage|phase)-\d+.*\.md$/i.test(entry.name))
    .sort(numericPageSort)
    .map(entry => path.join(stageDir, entry.name));
  if (!topLevelFiles.length) {
    errors.push(`Challenge ${challenge.id}: page sequence has no numeric stage or phase files in ${path.relative(ROOT, stageDir)}`);
    return { pages: [], sources: new Map(), errors };
  }

  const definitions = [
    { id: 'overview', kind: 'overview', parent_id: null, sourcePath: trackPath },
    { id: 'contents', kind: 'contents', parent_id: null, sourcePath: contentsPath }
  ];

  for (const topLevelPath of topLevelFiles) {
    const relativePath = path.relative(stageDir, topLevelPath);
    const topLevelId = pageIdFromRelativePath(relativePath);
    const kind = path.basename(topLevelPath).toLowerCase().startsWith('stage-') ? 'stage' : 'phase';
    definitions.push({ id: topLevelId, kind, parent_id: null, sourcePath: topLevelPath });

    const nestedDir = topLevelPath.slice(0, -3);
    for (const nestedPath of walkMarkdownFiles(nestedDir)) {
      const nestedRelativePath = path.relative(stageDir, nestedPath);
      definitions.push({
        id: pageIdFromRelativePath(nestedRelativePath),
        kind: 'role',
        parent_id: topLevelId,
        sourcePath: nestedPath,
        rolePath: path.relative(nestedDir, nestedPath).replace(/\\/g, '/').toLowerCase()
      });
    }
  }

  const ids = new Set();
  const sources = new Map();
  for (const definition of definitions) {
    if (!definition.id) {
      errors.push(`Challenge ${challenge.id}: could not derive a page ID from ${path.relative(ROOT, definition.sourcePath)}`);
      continue;
    }
    if (ids.has(definition.id)) {
      errors.push(`Challenge ${challenge.id}: duplicate page ID '${definition.id}'`);
    }
    ids.add(definition.id);
    sources.set(definition.sourcePath.replace(/\\/g, '/').toLowerCase(), definition.id);
  }

  const topLevel = definitions.filter(page => !page.parent_id);
  for (let i = 0; i < topLevel.length; i++) {
    if (i > 0) topLevel[i].previous_id = topLevel[i - 1].id;
    if (i < topLevel.length - 1) topLevel[i].next_id = topLevel[i + 1].id;
  }

  const nestedByParent = new Map();
  for (const page of definitions.filter(item => item.parent_id)) {
    if (!nestedByParent.has(page.parent_id)) nestedByParent.set(page.parent_id, new Map());
    nestedByParent.get(page.parent_id).set(page.rolePath, page);
  }
  const stagePages = topLevel.filter(page => page.kind === 'stage' || page.kind === 'phase');
  for (let i = 0; i < stagePages.length; i++) {
    const rolePages = nestedByParent.get(stagePages[i].id);
    if (!rolePages) continue;
    for (const [rolePath, rolePage] of rolePages) {
      const previous = i > 0 ? nestedByParent.get(stagePages[i - 1].id)?.get(rolePath) : null;
      const next = i < stagePages.length - 1 ? nestedByParent.get(stagePages[i + 1].id)?.get(rolePath) : null;
      rolePage.previous_id = previous ? previous.id : 'contents';
      if (next) rolePage.next_id = next.id;
    }
  }

  if (!definitions.length) {
    errors.push(`Challenge ${challenge.id}: page sequence is empty`);
  }
  for (const page of definitions) {
    if (page.parent_id && !ids.has(page.parent_id)) {
      errors.push(`Challenge ${challenge.id}: page '${page.id}' has unknown parent '${page.parent_id}'`);
    }
    for (const neighbor of [page.previous_id, page.next_id]) {
      if (neighbor && !ids.has(neighbor)) {
        errors.push(`Challenge ${challenge.id}: page '${page.id}' references unknown page '${neighbor}'`);
      }
    }
  }

  const pages = definitions.map((definition) => {
    const raw = readFileSafe(definition.sourcePath);
    if (raw === null) {
      errors.push(`Challenge ${challenge.id}: could not read ${path.relative(ROOT, definition.sourcePath)}`);
    }
    const relativeSource = path.relative(ROOT, definition.sourcePath).replace(/\\/g, '/');
    const page = {
      id: definition.id,
      title: markdownTitle(raw || '', path.basename(definition.sourcePath, '.md')),
      kind: definition.kind,
      parent_id: definition.parent_id,
      content_url: `assets/data/challenges/${challenge.id}/pages/${definition.id}.md`,
      source_path: relativeSource
    };
    if (definition.previous_id) page.previous_id = definition.previous_id;
    if (definition.next_id) page.next_id = definition.next_id;
    return page;
  });

  return { pages, definitions, sources, errors };
}

function buildChallengePages(challenges) {
  const errors = [];
  const collected = [];

  for (const ch of challenges) {
    const result = collectChallengePages(ch);
    errors.push(...result.errors);
    collected.push({ challenge: ch, ...result });
  }

  if (errors.length) return errors;

  for (const item of collected) {
    const pagesDir = path.join(OUT_CHALLENGES_DIR, item.challenge.id, 'pages');
    fs.rmSync(pagesDir, { recursive: true, force: true });
    ensureDir(pagesDir);

    item.challenge.pages = item.pages;
    for (let i = 0; i < item.definitions.length; i++) {
      const definition = item.definitions[i];
      const raw = readFileSafe(definition.sourcePath);
      const withoutFooter = stripSourceNavigationFooter(raw);
      const rewritten = rewriteChallengeLinks(
        withoutFooter,
        path.dirname(definition.sourcePath),
        item.challenge.id,
        item.sources
      );
      const outputPath = path.join(pagesDir, `${definition.id}.md`);
      ensureDir(path.dirname(outputPath));
      fs.writeFileSync(outputPath, `${rewritten}\n`, 'utf8');
    }
  }

  return errors;
}

/* ─── Build content pages ─────────────────────────────────────────────────── */
function buildContentPages() {
  ensureDir(OUT_PAGES_DIR);

  const pages = [
    { slug: 'copilot-guide', source: path.join(DOCS_DIR, 'copilot-guide.md') },
    { slug: 'prompt-engineering', source: path.join(DOCS_DIR, 'prompt-engineering.md') },
    { slug: 'mcp-servers', source: path.join(DOCS_DIR, 'mcp-servers.md') },
    { slug: 'facilitator-guide', source: FACILITATOR_PATH },
    { slug: 'troubleshooting', source: TROUBLESHOOT_PATH },
    { slug: 'getting-started', source: path.join(TRACKS_DIR, 'getting-started.md') }
  ];

  for (const page of pages) {
    const content = readFileSafe(page.source);
    if (content) {
      fs.writeFileSync(path.join(OUT_PAGES_DIR, `${page.slug}.md`), content, 'utf8');
    }
  }
}

/* ─── Load learning paths ─────────────────────────────────────────────────── */
function loadLearningPaths() {
  const raw = readFileSafe(LEARNING_PATHS_PATH);
  if (!raw) return { paths: [] };

  try {
    const data = JSON.parse(raw);
    return data;
  } catch (e) {
    console.warn(`Warning: could not parse learning-paths.json: ${e.message}`);
    return { paths: [] };
  }
}

/* ─── Load role collections ─────────────────────────────────────────────── */
function loadRoleCollections() {
  const raw = readFileSafe(ROLE_COLLECTIONS_PATH);
  if (!raw) return { roles: [], error: 'Could not read role-collections.json' };

  try {
    const data = JSON.parse(raw);
    return { ...data, error: null };
  } catch (e) {
    return { roles: [], error: `Could not parse role-collections.json: ${e.message}` };
  }
}

/* ─── Validate references ─────────────────────────────────────────────────── */
function validateReferences(challenges, paths, roles, roleLoadError) {
  const errors = [];
  const challengeIds = new Set(challenges.map(c => c.id));

  for (const ch of challenges) {
    for (const prereq of ch.prerequisites) {
      if (!challengeIds.has(prereq)) {
        errors.push(`Challenge ${ch.id}: prerequisite '${prereq}' does not exist`);
      }
    }
  }

  for (const p of paths) {
    for (const cid of (p.challenge_ids || [])) {
      if (!challengeIds.has(cid)) {
        errors.push(`Learning path '${p.id}': challenge_id '${cid}' does not exist`);
      }
    }
  }

  if (roleLoadError) errors.push(roleLoadError);
  if (!Array.isArray(roles)) {
    errors.push('role-collections.json: roles must be an array');
    return errors;
  }

  const roleIds = new Set();
  const assignedChallengeIds = new Set();
  for (const role of roles) {
    if (!role || typeof role !== 'object') {
      errors.push('role-collections.json: every role must be an object');
      continue;
    }
    if (typeof role.id !== 'string' || !role.id.trim()) {
      errors.push('role-collections.json: every role must have a non-empty string id');
    } else if (!/^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(role.id)) {
      errors.push(`Role '${role.id}': id must be a lowercase URL-safe slug`);
    } else if (roleIds.has(role.id)) {
      errors.push(`role-collections.json: duplicate role id '${role.id}'`);
    } else {
      roleIds.add(role.id);
    }
    if (typeof role.name !== 'string' || !role.name.trim()) {
      errors.push(`Role '${role.id || '(unknown)'}': missing non-empty name`);
    }
    if (typeof role.description !== 'string' || !role.description.trim()) {
      errors.push(`Role '${role.id || '(unknown)'}': missing non-empty description`);
    }
    if (!Array.isArray(role.challenge_ids) || role.challenge_ids.length === 0) {
      errors.push(`Role '${role.id || '(unknown)'}': challenge_ids must be a non-empty array`);
      continue;
    }

    const roleChallengeIds = new Set();
    for (const cid of role.challenge_ids) {
      if (roleChallengeIds.has(cid)) {
        errors.push(`Role '${role.id}': duplicate challenge_id '${cid}'`);
        continue;
      }
      roleChallengeIds.add(cid);
      if (!challengeIds.has(cid)) {
        errors.push(`Role '${role.id}': challenge_id '${cid}' does not exist`);
        continue;
      }
      assignedChallengeIds.add(cid);
    }
  }

  for (const challenge of challenges) {
    if (!assignedChallengeIds.has(challenge.id)) {
      errors.push(`Challenge ${challenge.id}: not assigned to any role collection`);
    }
  }

  return errors;
}

/* ─── Main ────────────────────────────────────────────────────────────────── */
function main() {
  console.log('Building GitHub Copilot Adoption site data...\n');

  ensureDir(OUT_DATA_DIR);
  ensureDir(OUT_CHALLENGES_DIR);

  const { challenges, errors: collectErrors } = collectChallenges();
  
  if (collectErrors.length) {
    console.error('Errors during collection:');
    collectErrors.forEach(e => console.error(`  - ${e}`));
    process.exit(1);
  }

  if (challenges.length === 0) {
    console.warn('Warning: No challenges found with meta.yml. Build will produce empty data files.');
  }

  challenges.sort((a, b) => a.number - b.number);

  const pageErrors = buildChallengePages(challenges);
  if (pageErrors.length) {
    console.error('Challenge page validation errors:');
    pageErrors.forEach(e => console.error(`  - ${e}`));
    process.exit(1);
  }

  const categories = Object.entries(CATEGORY_CONFIG).map(([id, cfg]) => ({
    id,
    name: cfg.name,
    description: cfg.description,
    color: cfg.color
  }));

  const platform = {
    generated_by: 'web/build.js',
    source: 'challenges/*/meta.yml',
    count: challenges.length,
    categories,
    challenges
  };

  fs.writeFileSync(
    path.join(OUT_DATA_DIR, 'platform.json'),
    JSON.stringify(platform, null, 2),
    'utf8'
  );

  const learningPaths = loadLearningPaths();
  fs.writeFileSync(
    path.join(OUT_DATA_DIR, 'paths.json'),
    JSON.stringify(learningPaths, null, 2),
    'utf8'
  );

  const roleCollections = loadRoleCollections();
  fs.writeFileSync(
    path.join(OUT_DATA_DIR, 'roles.json'),
    JSON.stringify({
      schema_version: roleCollections.schema_version || 1,
      roles: roleCollections.roles || []
    }, null, 2),
    'utf8'
  );

  buildContentPages();

  const refErrors = validateReferences(
    challenges,
    learningPaths.paths || [],
    roleCollections.roles,
    roleCollections.error
  );
  if (refErrors.length) {
    console.error('\nValidation errors:');
    refErrors.forEach(e => console.error(`  - ${e}`));
    process.exit(1);
  }

  console.log('Build complete:');
  console.log(`  ${challenges.length} challenges`);
  console.log(`  ${categories.length} categories`);
  console.log(`  ${(learningPaths.paths || []).length} learning paths`);
  console.log(`  ${(roleCollections.roles || []).length} role collections`);
  console.log(`  Output: web/assets/data/`);
  console.log('');
}

main();
