#!/usr/bin/env node
/**
 * GitHub Copilot Hackathon — build step (dependency-free, Node core only).
 *
 * Reads challenges/<slug>/meta.yml as the single source of truth and emits:
 *   web/assets/data/platform.json
 *   web/assets/data/paths.json
 *   web/assets/data/challenges/<id>/guide.md
 *   web/assets/data/pages/<slug>.md
 *
 * Validation (exits non-zero on errors):
 *   - Every meta.yml has required fields
 *   - Category is one of the 5 valid categories
 *   - Every learning-path challenge_id and prerequisites[] entry resolves to a real challenge
 *
 *   node web/build.js
 */
'use strict';

const fs   = require('fs');
const path = require('path');

/* ─── Category config (LOCKED per contract) ─────────────────────────────────
 * These are the 5 categories for this hackathon.
 * ─────────────────────────────────────────────────────────────────────────── */
const CATEGORY_CONFIG = {
  'core-tracks': {
    name: 'Core Tracks',
    description: 'Foundational GitHub Enterprise and Copilot skills -- API development, machine learning, DevOps, and frontend engineering.',
    color: '#58a6ff'
  },
  'team-sprints': {
    name: 'Team Sprints',
    description: 'Multi-role sprint challenges -- product management, business analysis, development, QA, and DevOps working together.',
    color: '#3fb950'
  },
  'legacy-modernization': {
    name: 'Legacy Modernization',
    description: 'Migrate MUMPS, COBOL, and WCF systems to modern platforms with GitHub Copilot assistance.',
    color: '#d29922'
  },
  'workflow-automation': {
    name: 'Workflow Automation',
    description: 'Build AI-powered automation for documentation, pipelines, backlog generation, ops assistance, and end-to-end delivery.',
    color: '#a371f7'
  },
  'azure-platform': {
    name: 'Azure Platform',
    description: 'Azure infrastructure and deployment automation with Terraform, PowerShell, and GitHub Actions.',
    color: '#ec6547'
  }
};

/* ─── Outcome config (additive, outcome-driven framing) ─────────────────────
 * Business outcomes that challenges produce. Multi-valued: one challenge can
 * deliver multiple outcomes. Additive to category (category controls color
 * grouping, outcomes describe work results).
 * ─────────────────────────────────────────────────────────────────────────── */
const OUTCOME_CONFIG = {
  'modernize-legacy': {
    name: 'Modernize Legacy Systems',
    description: 'Reverse-engineer, characterize, and migrate legacy codebases to modern platforms.'
  },
  'ship-features': {
    name: 'Ship Product Features Faster',
    description: 'Move from requirements to working, demoable software across the stack.'
  },
  'raise-quality': {
    name: 'Raise Quality and Confidence',
    description: 'Improve test coverage, accessibility, documentation, or reliability.'
  },
  'automate-delivery': {
    name: 'Automate Delivery and Ops Toil',
    description: 'Replace manual delivery or operations work with automated pipelines and tooling.'
  },
  'platform-foundation': {
    name: 'Stand Up Cloud Platform Foundations',
    description: 'Provision and harden Azure infrastructure with IaC, identity, and policy guardrails.'
  },
  'build-ai': {
    name: 'Build AI-Powered Capabilities',
    description: 'Develop and ship ML models, agents, or AI-driven features into production.'
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
const FACILITATOR_PATH    = path.join(ROOT, 'FACILITATOR_GUIDE.md');
const TROUBLESHOOT_PATH   = path.join(ROOT, 'TROUBLESHOOTING.md');

/* ─── Repository (for resolving relative links in guides) ─────────────────── */
const REPO_URL    = 'https://github.com/microsoft/frontier-ghcp-hackathon';
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

      const outcomes = Array.isArray(meta.outcomes) ? meta.outcomes : [];
      for (const outcomeId of outcomes) {
        if (!OUTCOME_CONFIG[outcomeId]) {
          errors.push(`${slug}/meta.yml: invalid outcome '${outcomeId}' (must be one of: ${Object.keys(OUTCOME_CONFIG).join(', ')})`);
        }
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
        outcomes: outcomes,
        prerequisites: Array.isArray(meta.prerequisites) ? meta.prerequisites : [],
        track_url: meta.track_url || '',
        starter_path: `challenges/${slug}/`,
        guide: `assets/data/challenges/${meta.id}/guide.md`
      };

      challenges.push(challenge);
    } catch (e) {
      errors.push(`${slug}/meta.yml: parse error: ${e.message}`);
    }
  }

  return { challenges, errors };
}

/* ─── Guide link resolution ───────────────────────────────────────────────────
 * A guide is built by concatenating a track file with its stage/phase files into
 * one rendered page. Relative links inside those source files (e.g. the stage
 * table-of-contents links, "Back to track" links, resource links) would 404 when
 * served, because the individual .md files are not published. We rewrite them:
 *   - Links that point to another file inlined into the SAME guide become
 *     in-page anchors (#…) that jump to that section.
 *   - All other relative links resolve to absolute GitHub URLs so they never 404.
 * ─────────────────────────────────────────────────────────────────────────── */
function fragmentAnchorId(relPathFromRoot) {
  return 'src-' + relPathFromRoot
    .replace(/\\/g, '/')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function repoUrlFor(relPathFromRoot, isDir) {
  const clean = relPathFromRoot.replace(/\\/g, '/').replace(/\/+$/, '');
  return `${REPO_URL}/${isDir ? 'tree' : 'blob'}/${REPO_BRANCH}/${clean}`;
}

/* Rewrite markdown links (not images) in a single fragment. `inlinedAnchors`
 * maps a normalized absolute file path -> in-page anchor id. */
function rewriteFragmentLinks(content, fragmentDir, inlinedAnchors) {
  const LINK_RE = /(!?)\[((?:[^\]\\]|\\.)*)\]\(\s*([^()\s]+)((?:\s+"[^"]*")?)\s*\)/g;
  return content.replace(LINK_RE, (full, bang, text, target, title) => {
    if (bang) return full; // leave images untouched
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
    if (relToRoot.startsWith('..')) return full; // outside repo — leave as-is

    const key = absTarget.replace(/\\/g, '/').toLowerCase();
    if (!isDir && inlinedAnchors.has(key)) {
      return `${bang}[${text}](#${inlinedAnchors.get(key)})`;
    }
    return `${bang}[${text}](${repoUrlFor(relToRoot, isDir)}${hash})`;
  });
}

/* ─── Build challenge guides ──────────────────────────────────────────────── */
function buildChallengeGuides(challenges) {
  const errors = [];

  for (const ch of challenges) {
    if (!ch.track_url) continue;

    const trackPath = path.join(ROOT, ch.track_url);
    const trackDir = path.dirname(trackPath);
    const trackBasename = path.basename(trackPath, '.md');

    const trackRaw = readFileSafe(trackPath);
    if (!trackRaw) {
      errors.push(`Challenge ${ch.id}: track file not found at ${ch.track_url}`);
      continue;
    }

    /* Stage/phase files live in a sibling subdirectory named after the track,
     * e.g. tracks/<track>.md + tracks/<track>/stage-*.md */
    const stageDir = path.join(trackDir, trackBasename);
    const stageFiles = readDirSafe(stageDir)
      .filter(e => e.isFile() && (e.name.startsWith('stage-') || e.name.startsWith('phase-')) && e.name.endsWith('.md'))
      .map(e => e.name)
      .sort();

    /* All fragments inlined into this guide, in render order. */
    const fragments = [{ absPath: trackPath, content: trackRaw }];
    for (const stageFile of stageFiles) {
      const stagePath = path.join(stageDir, stageFile);
      const stageContent = readFileSafe(stagePath);
      if (stageContent) fragments.push({ absPath: stagePath, content: stageContent });
    }

    /* Map each inlined file to a stable in-page anchor id. */
    const inlinedAnchors = new Map();
    for (const frag of fragments) {
      const relToRoot = path.relative(ROOT, frag.absPath).replace(/\\/g, '/');
      frag.anchorId = fragmentAnchorId(relToRoot);
      inlinedAnchors.set(frag.absPath.replace(/\\/g, '/').toLowerCase(), frag.anchorId);
    }

    const parts = fragments.map((frag) => {
      const dir = path.dirname(frag.absPath);
      const rewritten = rewriteFragmentLinks(frag.content, dir, inlinedAnchors);
      return `<a id="${frag.anchorId}"></a>\n\n${rewritten}`;
    });
    const guide = parts.join('\n\n');

    const outDir = path.join(OUT_CHALLENGES_DIR, ch.id);
    ensureDir(outDir);
    fs.writeFileSync(path.join(outDir, 'guide.md'), guide, 'utf8');
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

/* ─── Validate references ─────────────────────────────────────────────────── */
function validateReferences(challenges, paths) {
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

  return errors;
}

/* ─── Main ────────────────────────────────────────────────────────────────── */
function main() {
  console.log('Building GitHub Copilot Hackathon site data...\n');

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
    outcomeConfig: Object.entries(OUTCOME_CONFIG).map(([id, cfg]) => ({
      id,
      name: cfg.name,
      description: cfg.description
    })),
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

  const guideErrors = buildChallengeGuides(challenges);
  if (guideErrors.length) {
    console.warn('Warnings during guide building:');
    guideErrors.forEach(e => console.warn(`  - ${e}`));
  }

  buildContentPages();

  const refErrors = validateReferences(challenges, learningPaths.paths || []);
  if (refErrors.length) {
    console.error('\nValidation errors:');
    refErrors.forEach(e => console.error(`  - ${e}`));
    process.exit(1);
  }

  console.log('Build complete:');
  console.log(`  ${challenges.length} challenges`);
  console.log(`  ${categories.length} categories`);
  console.log(`  ${(learningPaths.paths || []).length} learning paths`);
  console.log(`  Output: web/assets/data/`);
  console.log('');
}

main();
