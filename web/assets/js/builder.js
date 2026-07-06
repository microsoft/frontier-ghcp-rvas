/* GitHub Copilot RVAS — coach set builder: multi-select challenges → shareable link */
(function () {
  'use strict';

  let _all = [];
  let _categories = [];
  let _activeCategory = null;
  let _activeDiff = null;
  let _query = '';
  const _selected = new Set();

  const CHECK_SVG =
    '<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="#03050d" stroke-width="3.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20 6L9 17l-5-5"/></svg>';

  async function init() {
    let data;
    try { data = await FP.loadData(); }
    catch (e) { FP.renderError('grid', e.message); return; }

    _all = data.challenges || [];
    _categories = data.categories || [];

    buildCategoryChips();
    buildDiffChips();
    initSearch();
    initTray();
    render();
  }

  function buildCategoryChips() {
    const container = document.getElementById('categoryChips');
    if (!container) return;
    container.innerHTML = _categories.map((c) =>
      `<button class="chip" data-category="${FP.esc(c.id)}"
         aria-pressed="false" type="button"
         style="--cat-color:${c.color}">
         ${FP.esc(c.name)}
       </button>`
    ).join('');

    container.querySelectorAll('.chip').forEach((btn) => {
      btn.addEventListener('click', () => {
        const id = btn.dataset.category;
        _activeCategory = _activeCategory === id ? null : id;
        container.querySelectorAll('.chip').forEach((b) => {
          b.classList.toggle('active', b.dataset.category === _activeCategory);
          b.setAttribute('aria-pressed', String(b.dataset.category === _activeCategory));
        });
        render();
      });
    });
  }

  function buildDiffChips() {
    const container = document.getElementById('diffChips');
    if (!container) return;
    const diffs = ['beginner', 'intermediate', 'advanced'];
    container.innerHTML = diffs.map((d) =>
      `<button class="chip" data-diff="${d}" aria-pressed="false" type="button">${d}</button>`
    ).join('');

    container.querySelectorAll('.chip').forEach((btn) => {
      btn.addEventListener('click', () => {
        const d = btn.dataset.diff;
        _activeDiff = _activeDiff === d ? null : d;
        container.querySelectorAll('.chip').forEach((b) => {
          b.classList.toggle('active', b.dataset.diff === _activeDiff);
          b.setAttribute('aria-pressed', String(b.dataset.diff === _activeDiff));
        });
        render();
      });
    });
  }

  function initSearch() {
    const input = document.getElementById('searchInput');
    if (input) {
      input.addEventListener('input', () => {
        _query = input.value.trim().toLowerCase();
        render();
      });
    }
    const clearBtn = document.getElementById('clearBtn');
    if (clearBtn) {
      clearBtn.addEventListener('click', () => {
        _query = '';
        if (input) input.value = '';
        _activeCategory = null;
        _activeDiff = null;
        document.querySelectorAll('.filters .chip').forEach((b) => {
          b.classList.remove('active');
          b.setAttribute('aria-pressed', 'false');
        });
        render();
      });
    }
  }

  function initTray() {
    document.getElementById('deselectBtn')?.addEventListener('click', () => {
      _selected.clear();
      hideLink();
      syncSelectionUI();
      render();
    });

    document.getElementById('generateBtn')?.addEventListener('click', generateLink);

    document.getElementById('copyBtn')?.addEventListener('click', async () => {
      const link = document.getElementById('setLink');
      if (!link || !link.value) return;
      try {
        await navigator.clipboard.writeText(link.value);
        flash(document.getElementById('copyBtn'), 'Copied!');
      } catch (e) {
        link.select();
        document.execCommand('copy');
        flash(document.getElementById('copyBtn'), 'Copied!');
      }
    });

    document.getElementById('setName')?.addEventListener('input', () => {
      if (!document.getElementById('linkRow').hidden) generateLink();
    });

    syncSelectionUI();
  }

  function filtered() {
    return _all.filter((c) => {
      if (_activeCategory && c.category !== _activeCategory) return false;
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
      document.getElementById('inlineClrBtn')?.addEventListener('click', () => document.getElementById('clearBtn')?.click());
      return;
    }

    const groups = {};
    _categories.forEach((cat) => { groups[cat.id] = { cat, items: [] }; });
    items.forEach((c) => {
      if (groups[c.category]) groups[c.category].items.push(c);
      else groups[c.category] = { cat: { id: c.category, name: c.category_name || c.category, color: FP.categoryColor(c.category) }, items: [c] };
    });

    let html = '';
    Object.values(groups).forEach(({ cat, items: gItems }) => {
      if (!gItems.length) return;
      const color = cat.color || FP.categoryColor(cat.id);
      html += `<div class="group-head cat-${FP.esc(cat.id)}" style="--cat-color:${color}">
        <h3>${FP.esc(cat.name)}</h3>
        <span class="group-count">${gItems.length} challenge${gItems.length === 1 ? '' : 's'}</span>
      </div>
      <div class="challenge-grid">`;
      html += gItems.map((c) => selectCard(c)).join('');
      html += '</div>';
    });

    grid.innerHTML = html;
    grid.querySelectorAll('.sel-card').forEach((card) => {
      card.addEventListener('click', () => toggle(card.dataset.id, card));
    });
  }

  function selectCard(c) {
    const color = FP.categoryColor(c.category);
    const on = _selected.has(c.id);
    return `
      <button class="sel-card cat-${FP.esc(c.category)}" type="button"
         data-id="${FP.esc(c.id)}" aria-pressed="${on}"
         style="--cat-color:${color}">
        <span class="sel-check" aria-hidden="true">${CHECK_SVG}</span>
        <div class="ch-card-top">
          <span class="ch-mod-dot" style="background:${color}"></span>
          <span class="ch-module-label">${FP.esc(c.category_name)}</span>
        </div>
        <div class="ch-title">${FP.esc(c.title)}</div>
        <div class="ch-desc">${FP.esc(c.description)}</div>
        <div class="ch-footer">
          ${FP.diffBadge(c.difficulty)}
          ${FP.durBadge(c.duration_minutes)}
          <div class="ch-tags">${FP.tagBadges(c.tags, 3)}</div>
        </div>
      </button>`;
  }

  function toggle(id, card) {
    if (_selected.has(id)) _selected.delete(id);
    else _selected.add(id);
    if (card) card.setAttribute('aria-pressed', String(_selected.has(id)));
    hideLink();
    syncSelectionUI();
  }

  function syncSelectionUI() {
    const n = _selected.size;
    const countEl = document.getElementById('setCount');
    if (countEl) countEl.innerHTML = `<strong>${n}</strong> selected`;
    const gen = document.getElementById('generateBtn');
    if (gen) gen.disabled = n === 0;
    const deselect = document.getElementById('deselectBtn');
    if (deselect) deselect.disabled = n === 0;
  }

  function orderedIds() {
    return _all.filter((c) => _selected.has(c.id)).map((c) => c.id);
  }

  function generateLink() {
    const ids = orderedIds();
    if (!ids.length) return;
    const name = (document.getElementById('setName')?.value || '').trim();
    const relative = FP.setUrl(ids, name);
    const absolute = new URL(relative, window.location.href).href;

    const row = document.getElementById('linkRow');
    const link = document.getElementById('setLink');
    const open = document.getElementById('openBtn');
    if (link) link.value = absolute;
    if (open) open.href = relative;
    if (row) row.hidden = false;
  }

  function hideLink() {
    const row = document.getElementById('linkRow');
    if (row) row.hidden = true;
  }

  function flash(btn, text) {
    if (!btn) return;
    const prev = btn.textContent;
    btn.textContent = text;
    setTimeout(() => { btn.textContent = prev; }, 1400);
  }

  document.addEventListener('DOMContentLoaded', init);
})();
