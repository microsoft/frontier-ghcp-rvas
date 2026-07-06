/* GitHub Copilot RVAS — guide page */
(function () {
  'use strict';

  const guides = [
    { slug: 'copilot-guide', title: 'Copilot Guide' },
    { slug: 'prompt-engineering', title: 'Prompt Engineering' },
    { slug: 'mcp-servers', title: 'MCP Servers' },
    { slug: 'facilitator-guide', title: 'Facilitator Guide' },
    { slug: 'troubleshooting', title: 'Troubleshooting' },
    { slug: 'getting-started', title: 'Getting Started' }
  ];

  async function init() {
    const slug = FP.qp('p') || 'copilot-guide';

    renderSidebar(slug);
    await loadGuide(slug);
  }

  function renderSidebar(activeSlug) {
    const nav = document.getElementById('guideNav');
    if (!nav) return;

    nav.innerHTML = guides.map((g) => {
      const url = FP.guideUrl(g.slug);
      const current = g.slug === activeSlug ? ' aria-current="page"' : '';
      const activeClass = g.slug === activeSlug ? ' active' : '';
      return `<li><a href="${url}" data-slug="${FP.esc(g.slug)}"${current} class="guide-link${activeClass}">${FP.esc(g.title)}</a></li>`;
    }).join('');
  }

  async function loadGuide(slug) {
    const content = document.getElementById('guideContent');
    if (!content) return;

    const mdUrl = `assets/data/pages/${slug}.md`;

    try {
      const res = await fetch(mdUrl, { cache: 'no-cache' });
      if (!res.ok) {
        if (res.status === 404) {
          FP.renderError(content, 'Guide not found.');
        } else {
          FP.renderError(content, `Could not load guide (${res.status}).`);
        }
        return;
      }

      const raw = await res.text();
      FP.renderMd(raw, content);
    } catch (e) {
      FP.renderError(content, e.message);
    }
  }

  document.addEventListener('DOMContentLoaded', init);
})();
