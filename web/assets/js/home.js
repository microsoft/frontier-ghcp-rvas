/* GitHub Copilot Adoption -- home page */
(function () {
  'use strict';

  async function init() {
    let data, pathsData;
    try { 
      data = await FP.loadData();
      pathsData = await FP.loadPaths();
    }
    catch (e) { 
      FP.renderError('categoryGrid', e.message);
      FP.renderError('pathsGrid', e.message);
      return;
    }

    const { categories, challenges } = data;
    const { paths } = pathsData;

    renderStats(categories, challenges, paths || []);
    renderCategoryCards(categories, challenges);
    renderPathsCards(paths || [], challenges);
    renderFeaturedChallenge(challenges);
  }

  function renderStats(categories, challenges, paths) {
    const totalChallenges = challenges.length;
    const totalPaths = paths.length;
    const totalMins = challenges.reduce((s, c) => s + (c.duration_minutes || 0), 0);

    _setText('stat-challenges', totalChallenges);
    _setText('stat-paths', totalPaths);
    const h = Math.round(totalMins / 60);
    _setText('stat-hours', h + 'h');

    const countByCategory = {};
    for (const ch of challenges) {
      countByCategory[ch.category] = (countByCategory[ch.category] || 0) + 1;
    }

    _setText('stat-core', (countByCategory['core-tracks'] || 0) + ' challenges');
    _setText('stat-sprints', (countByCategory['team-sprints'] || 0) + ' challenges');
    _setText('stat-legacy', (countByCategory['legacy-modernization'] || 0) + ' challenges');
    _setText('stat-automation', (countByCategory['workflow-automation'] || 0) + ' challenges');
    _setText('stat-azure', (countByCategory['azure-platform'] || 0) + ' challenges');
  }

  function renderCategoryCards(categories, challenges) {
    const grid = document.getElementById('categoryGrid');
    if (!grid) return;

    if (!categories.length) {
      grid.innerHTML = '<div class="empty">No categories configured.</div>';
      return;
    }

    const countByCategory = {};
    for (const ch of challenges) {
      countByCategory[ch.category] = (countByCategory[ch.category] || 0) + 1;
    }

    grid.innerHTML = categories.map((cat) => {
      const challengeCount = countByCategory[cat.id] || 0;

      return `
        <a href="${FP.catalogUrl(cat.id)}" class="mod-card cat-${FP.esc(cat.id)}" style="--cat-color:${cat.color}">
          <div class="mod-card-header">
            <div class="mod-card-title-block">
              <div class="mod-card-title">${FP.esc(cat.name)}</div>
              <div class="mod-card-id">${FP.esc(cat.id)}</div>
            </div>
          </div>
          <div class="mod-card-body">
            <p class="mod-card-desc">${FP.esc(cat.description)}</p>
            <div class="mod-card-meta" style="margin-top:auto">
              <div class="mod-stat"><strong>${challengeCount}</strong> challenges</div>
            </div>
          </div>
        </a>`;
    }).join('');
    
    FP.initReveal();
  }

  function renderPathsCards(paths, challenges) {
    const grid = document.getElementById('pathsGrid');
    if (!grid) return;

    if (!paths.length) {
      grid.innerHTML = '<div class="empty">No learning paths configured.</div>';
      return;
    }

    const displayPaths = paths.slice(0, 3);

    grid.innerHTML = displayPaths.map((p) => {
      const count = (p.challenge_ids || []).length;
      const mins = (p.challenge_ids || []).reduce((sum, id) => {
        const c = challenges.find((x) => x.id === id);
        return sum + (c && c.duration_minutes ? c.duration_minutes : 0);
      }, 0);

      return `
        <a href="${FP.setUrl(p.challenge_ids, p.name)}" class="outcome-card reveal">
          <div class="outcome-card-top">
            <span class="outcome-id">${FP.esc(p.id)}</span>
            <span class="badge badge-duration">${count} challenges</span>
            ${FP.durBadge(mins)}
          </div>
          <h3>${FP.esc(p.name)}</h3>
          <p>${FP.esc(p.description || '')}</p>
        </a>`;
    }).join('');
    
    FP.initReveal();
  }

  function renderFeaturedChallenge(challenges) {
    const el = document.getElementById('featuredChallenge');
    if (!el || !challenges.length) return;

    const pick = challenges.find((c) => c.difficulty === 'beginner' && c.number === 0)
      || challenges.find((c) => c.difficulty === 'beginner')
      || challenges[0];

    el.innerHTML = `
      <a class="ch-card cat-${FP.esc(pick.category)}" href="${FP.challengeUrl(pick.id)}" style="--cat-color:${FP.categoryColor(pick.category)};background:var(--c-700)">
        <div class="ch-card-top">
          <span class="ch-mod-dot"></span>
          <span class="ch-module-label">${FP.esc(pick.category_name)} · ${FP.esc(pick.title)}</span>
        </div>
        <div class="ch-title">${FP.esc(pick.title)}</div>
        <div class="ch-desc">${FP.esc(pick.description)}</div>
        <div class="ch-footer">
          ${FP.diffBadge(pick.difficulty)}
          ${FP.durBadge(pick.duration_minutes)}
          <div class="ch-tags">${FP.tagBadges(pick.tags, 3)}</div>
        </div>
      </a>
      <a class="btn btn-ghost btn-sm" href="${FP.challengeUrl(pick.id)}" style="align-self:flex-start">
        Open challenge →
      </a>`;
  }

  function _setText(id, val) {
    const el = document.getElementById(id);
    if (el) el.textContent = val;
  }

  document.addEventListener('DOMContentLoaded', init);
})();
