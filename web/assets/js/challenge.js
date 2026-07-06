/* GitHub Copilot RVAS — challenge detail page (?id=<challengeId>) */
(function () {
  'use strict';

  let _kiosk = null;

  /* Internal challenge link that preserves kiosk state when active */
  function cUrl(id) {
    return _kiosk ? FP.kioskChallengeUrl(id, _kiosk) : FP.challengeUrl(id);
  }

  async function init() {
    const challengeId = FP.qp('id');
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

    document.title = challenge.title + ' — GitHub Copilot RVAS';
    applyCategoryColor(challenge.category);
    renderHero(challenge, data.categories || []);
    renderSidebar(challenge, allChallenges);
    renderInfoPanel(challenge, data.categories || []);
    applyKioskLinks();
    loadGuide(challenge);
  }

  function applyCategoryColor(categoryId) {
    const color = FP.categoryColor(categoryId);
    document.documentElement.style.setProperty('--cat-color', color);
  }

  function renderHero(c, categories) {
    const color = FP.categoryColor(c.category);
    const catName = FP.categoryName(c.category, categories);

    // Breadcrumbs
    const crumbs = document.getElementById('breadcrumbs');
    if (crumbs) {
      crumbs.innerHTML = `
        <a href="index.html">Home</a>
        <span>›</span>
        <a href="catalog.html">Catalog</a>
        <span>›</span>
        <a href="${FP.catalogUrl(c.category)}" style="color:${color}">${FP.esc(catName)}</a>
        <span>›</span>
        <span>${FP.esc(c.id)}</span>`;
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
    // Starter link
    const starterLink = document.getElementById('starterLink');
    if (starterLink && c.starter_path) {
      const repoUrl = 'https://github.com/microsoft/frontier-ghcp-rvas';
      starterLink.href = repoUrl + '/tree/main/' + c.starter_path;
      starterLink.target = '_blank';
      starterLink.rel = 'noopener';
    }

    // Prerequisites
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

    // Tags
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

  async function loadGuide(c) {
    const body = document.getElementById('guideBody');
    if (!body) return;

    if (!c.guide) {
      body.innerHTML = '<p class="text-dim" style="font-size:.875rem">No guide available for this challenge.</p>';
      return;
    }

    body.innerHTML = '<p class="text-dim" style="font-size:.875rem;font-family:var(--font-mono)">Loading guide…</p>';

    try {
      const res = await fetch(c.guide, { cache: 'no-cache' });
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const md = await res.text();
      FP.renderMd(md, body);
    } catch (e) {
      body.innerHTML = `<p class="text-dim" style="font-size:.875rem">Could not load guide: ${FP.esc(e.message)}</p>`;
    }
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
