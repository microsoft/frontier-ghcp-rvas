/* GitHub Copilot Adoption -- guide page */
(function () {
  'use strict';

  const guides = [
    { slug: 'getting-started', title: 'Getting Started' },
    { slug: 'troubleshooting', title: 'Troubleshooting' },
    { slug: 'facilitator-guide', title: 'Facilitator Guide' }
  ];

  async function init() {
    const slug = FP.qp('p') || 'getting-started';

    renderSidebar(slug);
    const page = guides.find((guide) => guide.slug === slug);
    if (!page) {
      FP.renderError('guideContent', 'Page not found.');
      return;
    }
    document.title = page.title + ' - GitHub Copilot Adoption';
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
          FP.renderError(content, 'Page not found.');
        } else {
          FP.renderError(content, `Could not load page (${res.status}).`);
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
