/* GitHub Copilot Adoption -- challenge detail page (?id=<challengeId>&page=<pageId>) */
(function () {
  'use strict';

  let _kiosk = null;

  /* Internal challenge link that preserves kiosk state when active */
  function cUrl(id) {
    return _kiosk ? FP.kioskChallengeUrl(id, _kiosk) : FP.challengeUrl(id);
  }

  function pageUrl(challengeId, pageId) {
    const query = new URLSearchParams();
    query.set('id', challengeId);
    query.set('page', pageId);
    if (_kiosk) {
      query.set('set', _kiosk.ids.join(','));
      if (_kiosk.name) query.set('name', _kiosk.name);
    }
    return 'challenge.html?' + query.toString();
  }

  async function init() {
    const challengeId = FP.qp('id');
    const requestedPageId = FP.qp('page') || 'overview';
    if (!challengeId) {
      showError('No challenge ID specified in the URL. Please provide a valid challenge ID using ?id=challenge-X');
      return;
    }

    _kiosk = FP.kioskParams();

    let data;
    try {
      data = await FP.loadData();
    } catch (e) {
      showError('Failed to load platform data: ' + e.message);
      return;
    }

    const challenge = (data.challenges || []).find((c) => c.id === challengeId);
    if (!challenge) {
      showError(
        'Challenge "' + challengeId + '" not found. <a href="catalog.html">Browse all challenges</a> to find what you are looking for.'
      );
      return;
    }

    const allChallenges = data.challenges || [];
    const pages = challenge.pages || [];
    const selectedPage = pages.find((page) => page.id === requestedPageId);

    applyCategoryColor(challenge.category);
    renderHero(challenge, data.categories || [], selectedPage);
    renderSidebar(challenge, allChallenges);
    renderChallengePages(challenge, selectedPage);
    renderInfoPanel(challenge, data.categories || []);
    applyKioskLinks();

    if (!selectedPage) {
      renderPageError(
        'Page not found',
        'The page "' + requestedPageId + '" is not part of this challenge. Choose a page from the challenge pages menu.'
      );
      return;
    }

    loadPage(challenge, selectedPage, pages);
  }

  function applyCategoryColor(categoryId) {
    const color = FP.categoryColor(categoryId);
    document.documentElement.style.setProperty('--cat-color', color);
  }

  function renderHero(c, categories, selectedPage) {
    const color = FP.categoryColor(c.category);
    const catName = FP.categoryName(c.category, categories);
    const pageTitle = selectedPage ? selectedPage.title : 'Page not found';

    document.title = pageTitle + ' - ' + c.title + ' - GitHub Copilot Adoption';

    const crumbs = document.getElementById('breadcrumbs');
    if (crumbs) {
      crumbs.innerHTML = `
        <a href="index.html">Home</a>
        <span>›</span>
        <a href="catalog.html">Catalog</a>
        <span>›</span>
        <a href="${FP.catalogUrl(c.category)}" style="color:${color}">${FP.esc(catName)}</a>
        <span>›</span>
        <a href="${pageUrl(c.id, 'overview')}">${FP.esc(c.id)}</a>
        <span>›</span>
        <span aria-current="page">${FP.esc(pageTitle)}</span>`;
    }

    _setText('challengeTitle', c.title);
    _setText('challengeId', c.id);

    const meta = document.getElementById('challengeMeta');
    if (meta) {
      meta.innerHTML = `
        <span class="badge cat-${FP.esc(c.category)}" style="--cat-color:${color}">${FP.esc(catName)}</span>
        ${FP.diffBadge(c.difficulty)}
        ${FP.durBadge(c.duration_minutes)}
        ${FP.tagBadges(c.tags || [], 3)}`;
    }

    const focus = document.getElementById('challengeFocus');
    if (focus) {
      focus.textContent = c.focus || c.description || '';
    }
  }

  function renderSidebar(c, allChallenges) {
    const starterLink = document.getElementById('starterLink');
    if (starterLink && c.starter_path) {
      const repoUrl = 'https://github.com/microsoft/frontier-ghcp-rvas';
      starterLink.href = repoUrl + '/tree/main/' + c.starter_path;
      starterLink.target = '_blank';
      starterLink.rel = 'noopener';
    }

    const prereqPanel = document.getElementById('prereqPanel');
    const prereqList = document.getElementById('prereqList');
    if (prereqPanel && prereqList) {
      if (!c.prerequisites || !c.prerequisites.length) {
        prereqPanel.style.display = 'none';
      } else {
        prereqList.innerHTML = c.prerequisites
          .map((pid) => {
            const prereq = allChallenges.find((x) => x.id === pid);
            return `<li class="prereq-item">
              ${
                prereq
                  ? `<a href="${cUrl(pid)}">${FP.esc(prereq.title)}</a>`
                  : `<span class="mono">${FP.esc(pid)}</span>`
              }
            </li>`;
          })
          .join('');
      }
    }

    const tagsList = document.getElementById('tagsList');
    if (tagsList) {
      const tags = c.tags || [];
      if (tags.length) {
        tagsList.innerHTML = tags
          .map((t) => `<span class="badge badge-tag">${FP.esc(t)}</span>`)
          .join('');
        tagsList.style.display = 'flex';
        tagsList.style.flexWrap = 'wrap';
        tagsList.style.gap = '6px';
      } else {
        tagsList.innerHTML = '<span class="text-dim" style="font-size:0.8rem">No tags</span>';
      }
    }
  }

  function renderChallengePages(challenge, selectedPage) {
    const panel = document.getElementById('challengePagesPanel');
    const nav = document.getElementById('challengePagesNav');
    const pages = challenge.pages || [];
    if (!panel || !nav) return;

    if (!pages.length) {
      panel.style.display = 'none';
      return;
    }

    const childrenByParent = new Map();
    pages.forEach((page) => {
      if (!page.parent_id) return;
      if (!childrenByParent.has(page.parent_id)) childrenByParent.set(page.parent_id, []);
      childrenByParent.get(page.parent_id).push(page);
    });

    nav.innerHTML = `
      <ul class="challenge-pages-list">
        ${pages
          .filter((page) => !page.parent_id)
          .map((page) => renderPageMenuItem(challenge.id, page, childrenByParent.get(page.id) || [], selectedPage))
          .join('')}
      </ul>`;

    const disclosure = document.getElementById('challengePagesDisclosure');
    if (disclosure && window.matchMedia('(max-width: 900px)').matches) {
      disclosure.removeAttribute('open');
    }
  }

  function renderPageMenuItem(challengeId, page, children, selectedPage) {
    const isActive = !!selectedPage && selectedPage.id === page.id;
    const isActiveGroup = isActive || (!!selectedPage && selectedPage.parent_id === page.id);
    const link = renderPageLink(challengeId, page, isActive);

    if (!children.length) {
      return `<li class="challenge-pages-item challenge-pages-item-${FP.esc(page.kind)}">${link}</li>`;
    }

    return `
      <li class="challenge-pages-item challenge-pages-item-${FP.esc(page.kind)} challenge-pages-group${isActiveGroup ? ' is-active-group' : ''}">
        <details class="challenge-pages-details"${isActiveGroup ? ' open' : ''}>
          <summary class="challenge-pages-summary">${FP.esc(page.title)}</summary>
          <div class="challenge-pages-group-body">
            ${renderPageLink(challengeId, page, isActive, page.kind === 'stage' ? 'Stage overview' : 'Phase overview')}
            <ul class="challenge-pages-children">
              ${children
                .map((child) => {
                  const childActive = !!selectedPage && selectedPage.id === child.id;
                  return `<li class="challenge-pages-item challenge-pages-item-${FP.esc(child.kind)}">${renderPageLink(challengeId, child, childActive)}</li>`;
                })
                .join('')}
            </ul>
          </div>
        </details>
      </li>`;
  }

  function renderPageLink(challengeId, page, isActive, label) {
    return `<a class="challenge-page-link${isActive ? ' is-active' : ''}" href="${pageUrl(challengeId, page.id)}"${isActive ? ' aria-current="page"' : ''}>${FP.esc(label || page.title)}</a>`;
  }

  function renderInfoPanel(c, categories) {
    const panel = document.getElementById('infoPanel');
    if (!panel) return;

    const catName = FP.categoryName(c.category, categories);
    const color = FP.categoryColor(c.category);

    panel.innerHTML = `
      <div class="info-item">
        <span class="info-label">Category</span>
        <span class="info-value">
          <a href="${FP.catalogUrl(c.category)}" class="badge cat-${FP.esc(c.category)}" style="--cat-color:${color}">${FP.esc(catName)}</a>
        </span>
      </div>
      <div class="info-item">
        <span class="info-label">Difficulty</span>
        <span class="info-value">${FP.diffBadge(c.difficulty)}</span>
      </div>
      <div class="info-item">
        <span class="info-label">Duration</span>
        <span class="info-value">${FP.durBadge(c.duration_minutes) || '—'}</span>
      </div>
      <div class="info-item">
        <span class="info-label">Number</span>
        <span class="info-value"><span class="mono">${FP.esc(String(c.number))}</span></span>
      </div>
    `;
  }

  function applyKioskLinks() {
    if (!_kiosk) return;
    const back = document.getElementById('backLink');
    if (back) {
      back.setAttribute('href', FP.setUrl(_kiosk.ids, _kiosk.name));
      back.innerHTML = '← Back to set';
    }
  }

  async function loadPage(challenge, page, pages) {
    const body = document.getElementById('guideBody');
    if (!body) return;

    if (!page.content_url) {
      renderPageError('Page unavailable', 'This page does not have a published content URL.');
      return;
    }

    body.innerHTML = '<p class="text-dim" style="font-size:.875rem;font-family:var(--font-mono)">Loading page…</p>';

    try {
      const res = await fetch(page.content_url, { cache: 'no-cache' });
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const md = await res.text();
      FP.renderMd(md, body);
      preserveKioskChallengeLinks(body);
      renderPageNavigation(body, challenge.id, page, pages);
    } catch (e) {
      renderPageError('Could not load page', e.message);
    }
  }

  function preserveKioskChallengeLinks(root) {
    if (!_kiosk) return;
    root.querySelectorAll('a[href]').forEach((link) => {
      const url = new URL(link.getAttribute('href'), window.location.href);
      if (!url.pathname.endsWith('/challenge.html') && !url.pathname.endsWith('challenge.html')) return;
      url.searchParams.set('set', _kiosk.ids.join(','));
      if (_kiosk.name) url.searchParams.set('name', _kiosk.name);
      else url.searchParams.delete('name');
      link.setAttribute('href', url.pathname.split('/').pop() + url.search + url.hash);
    });
  }

  function renderPageNavigation(body, challengeId, page, pages) {
    const previous = page.previous_id ? pages.find((item) => item.id === page.previous_id) : null;
    const next = page.next_id ? pages.find((item) => item.id === page.next_id) : null;
    if (!previous && !next) return;

    const nav = document.createElement('nav');
    nav.className = 'challenge-page-navigation';
    nav.setAttribute('aria-label', 'Challenge page navigation');
    nav.innerHTML = `
      <div class="challenge-page-navigation-previous">
        ${previous ? `<a class="challenge-page-navigation-link" href="${pageUrl(challengeId, previous.id)}"><span class="challenge-page-navigation-label">Previous</span><span class="challenge-page-navigation-title">${FP.esc(previous.title)}</span></a>` : ''}
      </div>
      <div class="challenge-page-navigation-next">
        ${next ? `<a class="challenge-page-navigation-link" href="${pageUrl(challengeId, next.id)}"><span class="challenge-page-navigation-label">Next</span><span class="challenge-page-navigation-title">${FP.esc(next.title)}</span></a>` : ''}
      </div>`;
    body.appendChild(nav);
  }

  function renderPageError(title, message) {
    const body = document.getElementById('guideBody');
    if (!body) return;
    body.innerHTML = `
      <div class="challenge-page-error empty" role="alert">
        <strong>${FP.esc(title)}</strong>
        <p>${FP.esc(message)}</p>
      </div>`;
  }

  function showError(msg) {
    const main = document.getElementById('mainContent');
    if (main) {
      main.innerHTML = `
        <div class="wrap section">
          <div class="empty" role="alert">
            <strong>Error</strong>
            <p>${msg}</p>
          </div>
        </div>`;
    }
  }

  function _setText(id, val) {
    const el = document.getElementById(id);
    if (el) el.textContent = val;
  }

  document.addEventListener('DOMContentLoaded', init);
})();
