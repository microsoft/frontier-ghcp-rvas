import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import test from 'node:test';
import { runInNewContext } from 'node:vm';

const source = readFileSync(new URL('./assets/js/guide.js', import.meta.url), 'utf8');
const retired = ['copilot-guide', 'prompt-engineering', 'mcp-servers'];

function documentation(slug) {
  const elements = { guideNav: { innerHTML: '' }, guideContent: {} };
  const requests = [];
  const rendered = [];
  const errors = [];
  let initialize;
  const document = {
    getElementById: (id) => elements[id],
    addEventListener: (name, handler) => { initialize = handler; }
  };
  runInNewContext(source, {
    document,
    FP: {
      qp: () => slug,
      guideUrl: (value) => 'guide.html?p=' + value,
      esc: (value) => value,
      renderMd: (markdown) => { rendered.push(markdown); },
      renderError: (element, message) => { errors.push(message); }
    },
    fetch: async (url) => {
      requests.push(url);
      return { ok: true, text: async () => '# Session instructions' };
    }
  });
  return { document, elements, requests, rendered, errors, ready: initialize() };
}

test('documentation without a page selection opens shared setup', async () => {
  const page = documentation(null);
  await page.ready;
  assert.deepEqual(page.requests, ['assets/data/pages/getting-started.md']);
  assert.deepEqual(page.rendered, ['# Session instructions']);
  assert.equal(page.document.title, 'Getting Started - GitHub Copilot Adoption');
});

for (const slug of ['getting-started', 'troubleshooting', 'facilitator-guide']) {
  test(`documentation still opens ${slug} directly`, async () => {
    const page = documentation(slug);
    await page.ready;
    assert.deepEqual(page.requests, [`assets/data/pages/${slug}.md`]);
    assert.deepEqual(page.rendered, ['# Session instructions']);
    assert.match(page.elements.guideNav.innerHTML, new RegExp(`data-slug="${slug}" aria-current="page"`));
    assert.deepEqual(page.errors, []);
  });
}

test('retired or unknown documentation routes show a missing-page error without fetching content', async () => {
  for (const slug of [...retired, 'unknown-page']) {
    const page = documentation(slug);
    await page.ready;
    assert.deepEqual(page.requests, []);
    assert.deepEqual(page.rendered, []);
    assert.deepEqual(page.errors, ['Page not found.']);
  }
});

test('rebuilding removes stale guide payloads and preserves session instructions', () => {
  const pages = new URL('./assets/data/pages/', import.meta.url);
  mkdirSync(pages, { recursive: true });
  for (const slug of retired) {
    writeFileSync(new URL(`${slug}.md`, pages), '# Stale guide content\n');
  }
  execFileSync(process.execPath, [fileURLToPath(new URL('./build.js', import.meta.url))], {
    cwd: fileURLToPath(new URL('../', import.meta.url)),
    encoding: 'utf8'
  });
  for (const slug of retired) {
    assert.equal(existsSync(new URL(`${slug}.md`, pages)), false, slug);
  }
  for (const slug of ['getting-started', 'troubleshooting', 'facilitator-guide']) {
    assert.ok(readFileSync(new URL(`${slug}.md`, pages), 'utf8').length, slug);
  }
});
