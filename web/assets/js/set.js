/* GitHub Copilot Adoption -- curated set view (?ids=a,b,c&name=…), opens in kiosk mode */
(function () {
  'use strict';

  async function init() {
    const params = FP.kioskParams();
    if (!params) {
      showEmpty('No challenge set specified. <a href="builder.html">Build one →</a>');
      return;
    }

    let data;
    try { data = await FP.loadData(); }
    catch (e) { FP.renderError('grid', e.message); return; }

    const byId = new Map((data.challenges || []).map((c) => [c.id, c]));
    const categories = data.categories || [];
    const items = params.ids.map((id) => byId.get(id)).filter(Boolean);

    renderHeading(params.name, items.length);

    if (!items.length) {
      showEmpty('None of the challenges in this set could be found.');
      return;
    }

    renderGrid(items, categories, params);
  }

  function renderHeading(name, n) {
    const title = name || 'Your challenges';
    document.title = title + ' - GitHub Copilot Adoption';
    const h = document.getElementById('setHeading');
    if (h) h.textContent = name ? name : 'Your challenges.';
    const intro = document.getElementById('setIntro');
    if (intro) {
      intro.textContent =
        `A focused selection of ${n} challenge${n === 1 ? '' : 's'} prepared for you. ` +
        'Work through them at your own pace.';
    }
  }

  function renderGrid(items, categories, params) {
    const grid = document.getElementById('grid');
    if (!grid) return;

    const groups = {};
    categories.forEach((cat) => { groups[cat.id] = { cat, items: [] }; });
    items.forEach((c) => {
      if (groups[c.category]) groups[c.category].items.push(c);
      else groups[c.category] = { cat: { id: c.category, name: c.category }, items: [c] };
    });

    let html = '';
    Object.values(groups).forEach(({ cat, items: gItems }) => {
      if (!gItems.length) return;
      const color = FP.categoryColor(cat.id);
      html += `<div class="group-head cat-${FP.esc(cat.id)}" style="--cat-color:${color}">
        <span class="group-count cat-${FP.esc(cat.id)}" style="color:${color};font-family:var(--font-mono);font-size:0.72rem;font-weight:700">${cat.id.toUpperCase()}</span>
        <h3>${FP.esc(cat.name)}</h3>
        <span class="group-count">${gItems.length} challenge${gItems.length === 1 ? '' : 's'}</span>
      </div>
      <div class="challenge-grid">`;
      html += gItems.map((c) => card(c, params)).join('');
      html += '</div>';
    });

    grid.innerHTML = html;
    FP.initReveal();
  }

  function card(c, params) {
    const color = FP.categoryColor(c.category);
    return `
      <a href="${FP.kioskChallengeUrl(c.id, params)}" class="ch-card cat-${FP.esc(c.category)} reveal"
         style="--cat-color:${color}">
        <div class="ch-card-top">
          <span class="ch-mod-dot"></span>
          <span class="ch-module-label">${FP.esc(c.category_name || c.category)}</span>
        </div>
        <div class="ch-title">${FP.esc(c.title)}</div>
        <div class="ch-desc">${FP.esc(c.description)}</div>
        <div class="ch-footer">
          ${FP.diffBadge(c.difficulty)}
          ${FP.durBadge(c.duration_minutes)}
          <div class="ch-tags">${FP.tagBadges(c.tags, 3)}</div>
        </div>
      </a>`;
  }

  function showEmpty(msgHtml) {
    const grid = document.getElementById('grid');
    if (grid) grid.innerHTML = `<div class="no-results">${msgHtml}</div>`;
  }

  document.addEventListener('DOMContentLoaded', init);
})();
