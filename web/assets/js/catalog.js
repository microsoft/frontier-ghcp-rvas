/* GitHub Copilot Enterprise Hackathon — catalog page: filterable + searchable challenge grid */
(function () {
  'use strict';

  let _all = [];
  let _categories = [];
  let _outcomeConfig = [];
  let _activeCat = null;
  let _activeOutcome = null;
  let _activeDiff = null;
  let _query = '';

  async function init() {
    let data;
    try { data = await FP.loadData(); }
    catch (e) { FP.renderError('grid', e.message); return; }

    _all = data.challenges || [];
    _categories = data.categories || [];
    _outcomeConfig = data.outcomeConfig || [];

    buildCategoryChips();
    buildOutcomeChips();
    buildDiffChips();
    initSearch();
    applyUrlState();
    render();
  }

  const DIFFS = ['beginner', 'intermediate', 'advanced'];

  /* Seed filter state from the URL query string (?cat=&outcome=&difficulty=&q=) and
     reflect it on the chips + search input before the first render. Invalid
     values are ignored rather than applied. */
  function applyUrlState() {
    const cat = FP.qp('cat');
    if (cat && _categories.some((c) => c.id === cat)) _activeCat = cat;

    const outcome = FP.qp('outcome');
    if (outcome && _outcomeConfig.some((o) => o.id === outcome)) _activeOutcome = outcome;

    const diff = FP.qp('difficulty');
    if (diff && DIFFS.indexOf(diff) !== -1) _activeDiff = diff;

    const q = (FP.qp('q') || '').trim();
    if (q) {
      _query = q.toLowerCase();
      const input = document.getElementById('searchInput');
      if (input) input.value = q;
    }

    syncChipState();
    syncUrl();
  }

  /* Reflect _activeCat / _activeOutcome / _activeDiff onto the rendered chips. */
  function syncChipState() {
    document.querySelectorAll('#catChips .chip').forEach((b) => {
      const on = b.dataset.cat === _activeCat;
      b.classList.toggle('active', on);
      b.setAttribute('aria-pressed', String(on));
    });
    document.querySelectorAll('#outcomeChips .chip').forEach((b) => {
      const on = b.dataset.outcome === _activeOutcome;
      b.classList.toggle('active', on);
      b.setAttribute('aria-pressed', String(on));
    });
    document.querySelectorAll('#diffChips .chip').forEach((b) => {
      const on = b.dataset.diff === _activeDiff;
      b.classList.toggle('active', on);
      b.setAttribute('aria-pressed', String(on));
    });
  }

  /* Keep the address bar in sync with the active filters so the view is
     shareable. replaceState avoids polluting back/forward history. */
  function syncUrl() {
    const q = new URLSearchParams();
    if (_activeCat) q.set('cat', _activeCat);
    if (_activeOutcome) q.set('outcome', _activeOutcome);
    if (_activeDiff) q.set('difficulty', _activeDiff);
    if (_query) q.set('q', _query);
    const qs = q.toString();
    const url = window.location.pathname + (qs ? '?' + qs : '');
    window.history.replaceState(null, '', url);
  }

  function buildCategoryChips() {
    const container = document.getElementById('catChips');
    if (!container) return;

    container.innerHTML = _categories.map((c) =>
      `<button class="chip" data-cat="${FP.esc(c.id)}"
         aria-pressed="false" type="button"
         style="--cat-color:${c.color}">
         ${FP.esc(c.name)}
       </button>`
    ).join('');

    container.querySelectorAll('.chip').forEach((btn) => {
      btn.addEventListener('click', () => {
        const id = btn.dataset.cat;
        _activeCat = _activeCat === id ? null : id;
        syncChipState();
        syncUrl();
        render();
      });
    });
  }

  function buildOutcomeChips() {
    const container = document.getElementById('outcomeChips');
    if (!container) return;

    container.innerHTML = _outcomeConfig.map((o) =>
      `<button class="chip" data-outcome="${FP.esc(o.id)}"
         aria-pressed="false" type="button"
         title="${FP.esc(o.description)}">
         ${FP.esc(o.name)}
       </button>`
    ).join('');

    container.querySelectorAll('.chip').forEach((btn) => {
      btn.addEventListener('click', () => {
        const id = btn.dataset.outcome;
        _activeOutcome = _activeOutcome === id ? null : id;
        syncChipState();
        syncUrl();
        render();
      });
    });
  }

  function buildDiffChips() {
    const container = document.getElementById('diffChips');
    if (!container) return;
    container.innerHTML = DIFFS.map((d) =>
      `<button class="chip" data-diff="${d}" aria-pressed="false" type="button">${d}</button>`
    ).join('');

    container.querySelectorAll('.chip').forEach((btn) => {
      btn.addEventListener('click', () => {
        const d = btn.dataset.diff;
        _activeDiff = _activeDiff === d ? null : d;
        syncChipState();
        syncUrl();
        render();
      });
    });
  }

  function initSearch() {
    const input = document.getElementById('searchInput');
    if (!input) return;
    input.addEventListener('input', () => {
      _query = input.value.trim().toLowerCase();
      syncUrl();
      render();
    });

    const clearBtn = document.getElementById('clearBtn');
    if (clearBtn) {
      clearBtn.addEventListener('click', () => {
        _query = '';
        input.value = '';
        _activeCat = null;
        _activeDiff = null;
        syncChipState();
        syncUrl();
        render();
      });
    }
  }

  function filtered() {
    return _all.filter((c) => {
      if (_activeCat && c.category !== _activeCat) return false;
      if (_activeDiff && c.difficulty !== _activeDiff) return false;
      if (_query) {
        const hay = [c.title, c.description, c.category_name, ...(c.tags || [])]
          .join(' ').toLowerCase();
        if (!hay.includes(_query)) return false;
      }
      return true;
    });
  }

  function render() {
    const grid = document.getElementById('grid');
    const countEl = document.getElementById('count');
    if (!grid) return;

    const items = filtered();

    if (countEl) countEl.textContent = items.length + ' challenge' + (items.length === 1 ? '' : 's');

    if (!items.length) {
      grid.innerHTML = '<div class="no-results">No challenges match those filters. <button class="btn btn-ghost btn-sm" id="inlineClrBtn" type="button">Clear filters</button></div>';
      const b = document.getElementById('inlineClrBtn');
      if (b) b.addEventListener('click', () => document.getElementById('clearBtn')?.click());
      return;
    }

    // Group by category
    const groups = {};
    _categories.forEach((c) => { groups[c.id] = { cat: c, items: [] }; });
    items.forEach((c) => {
      if (groups[c.category]) groups[c.category].items.push(c);
      else groups[c.category] = { cat: { id: c.category, name: c.category_name, color: '#ccc' }, items: [c] };
    });

    let html = '';
    Object.values(groups).forEach(({ cat, items: gItems }) => {
      if (!gItems.length) return;
      const color = cat.color || FP.categoryColor(cat.id);
      html += `<div class="group-head cat-${FP.esc(cat.id)}" style="--cat-color:${color}">
        <span class="group-count cat-${FP.esc(cat.id)}" style="color:${color};font-family:var(--font-mono);font-size:0.72rem;font-weight:700">${cat.id.toUpperCase().replace(/-/g, ' ')}</span>
        <h3>${FP.esc(cat.name)}</h3>
        <span class="group-count">${gItems.length} challenge${gItems.length === 1 ? '' : 's'}</span>
      </div>
      <div class="challenge-grid">`;
      html += gItems.map((c) => challengeCard(c)).join('');
      html += '</div>';
    });

    grid.innerHTML = html;
    FP.initReveal();
  }

  function challengeCard(c) {
    const color = _categories.find((cat) => cat.id === c.category)?.color || FP.categoryColor(c.category);
    return `
      <a href="${FP.challengeUrl(c.id)}" class="ch-card cat-${FP.esc(c.category)} reveal"
         style="--cat-color:${color}">
        <div class="ch-card-top">
          <span class="ch-mod-dot"></span>
          <span class="ch-module-label">${FP.esc(c.category_name)}</span>
          <span class="ch-number">#${c.number}</span>
        </div>
        <div class="ch-title">${FP.esc(c.title)}</div>
        <div class="ch-desc">${FP.esc(c.description)}</div>
        <div class="ch-footer">
          ${FP.diffBadge(c.difficulty)}
          ${FP.durBadge(c.duration_minutes)}
          <div class="ch-tags">${FP.tagBadges(c.tags, 3)}</div>
        </div>
        <div class="ch-outcomes">${FP.outcomeBadges(c.outcomes || [], _outcomeConfig)}</div>
      </a>`;
  }

  document.addEventListener('DOMContentLoaded', init);
})();
