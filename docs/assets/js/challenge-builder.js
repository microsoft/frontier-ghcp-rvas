(function () {
  'use strict';

  const CC = window.ChallengeCurator;
  if (!CC) return;

  let catalog = null;
  let activeCategory = 'all';
  let query = '';
  const selected = new Set();

  function init() {
    const root = document.querySelector('[data-curator-page="builder"]');
    if (!root) return;

    const grid = document.getElementById('challengeBuilderGrid');
    CC.renderStatus(grid, 'Loading challenges', 'Reading the generated challenge catalog.');

    CC.loadCatalog()
      .then((data) => {
        catalog = data;
        bindControls();
        renderCategoryFilters();
        renderGrid();
        syncTray();
      })
      .catch((error) => {
        CC.renderStatus(grid, 'Could not load the challenge catalog', error.message, 'error');
      });
  }

  function bindControls() {
    const search = document.getElementById('challengeSearch');
    if (search) {
      search.addEventListener('input', () => {
        query = search.value.trim().toLowerCase();
        renderGrid();
      });
    }

    document.getElementById('clearChallengeFilters')?.addEventListener('click', clearFilters);
    document.getElementById('clearSelection')?.addEventListener('click', () => {
      selected.clear();
      hideLink();
      renderGrid();
      syncTray();
    });
    document.getElementById('generateSetLink')?.addEventListener('click', generateLink);
    document.getElementById('copySetLink')?.addEventListener('click', copyLink);
    document.getElementById('setName')?.addEventListener('input', () => {
      if (!document.getElementById('setLinkRow')?.hidden) generateLink();
    });
  }

  function renderCategoryFilters() {
    const target = document.getElementById('categoryFilters');
    if (!target || !catalog) return;

    const categories = ['all'].concat(catalog.categories || []);
    target.innerHTML = categories.map((category) => {
      const label = category === 'all' ? 'All' : category;
      return '<button class="challenge-curator-chip" type="button" data-category="' + CC.escapeHtml(category) +
        '" aria-pressed="' + String(category === activeCategory) + '">' + CC.escapeHtml(label) + '</button>';
    }).join('');

    target.querySelectorAll('button').forEach((button) => {
      button.addEventListener('click', () => {
        activeCategory = button.dataset.category || 'all';
        hideLink();
        renderCategoryFilters();
        renderGrid();
      });
    });
  }

  function clearFilters() {
    activeCategory = 'all';
    query = '';
    const search = document.getElementById('challengeSearch');
    if (search) search.value = '';
    renderCategoryFilters();
    renderGrid();
  }

  function filteredChallenges() {
    if (!catalog) return [];

    return catalog.challenges.filter((challenge) => {
      if (activeCategory !== 'all' && challenge.category !== activeCategory) return false;
      if (!query) return true;

      const haystack = [
        challenge.display_title,
        challenge.focus,
        challenge.selection_hint,
        challenge.duration,
        challenge.category,
        ...(challenge.tags || []),
      ].join(' ').toLowerCase();
      return haystack.includes(query);
    });
  }

  function renderGrid() {
    const grid = document.getElementById('challengeBuilderGrid');
    const count = document.getElementById('visibleChallengeCount');
    if (!grid || !catalog) return;

    const items = filteredChallenges();
    if (count) count.textContent = items.length + ' shown';

    if (!items.length) {
      CC.renderStatus(grid, 'No challenges match those filters', 'Clear the search or choose another category.', 'empty');
      return;
    }

    grid.innerHTML = items.map(renderSelectableCard).join('');
    grid.querySelectorAll('[data-challenge-id]').forEach((card) => {
      card.addEventListener('click', () => toggleSelection(Number(card.dataset.challengeId)));
    });
  }

  function renderSelectableCard(challenge) {
    const isSelected = selected.has(challenge.id);
    return '<button class="challenge-curator-card challenge-curator-card--select" type="button" role="listitem" ' +
      'data-challenge-id="' + challenge.id + '" aria-pressed="' + String(isSelected) + '">' +
      '<span class="challenge-curator-check" aria-hidden="true"></span>' +
      '<span class="challenge-curator-kicker">Challenge ' + challenge.number + '</span>' +
      '<strong>' + CC.escapeHtml(challenge.title) + '</strong>' +
      '<p>' + CC.escapeHtml(challenge.selection_hint || challenge.focus) + '</p>' +
      '<span class="challenge-curator-meta">' +
      CC.badge(challenge.category, 'category') +
      CC.badge(challenge.duration || 'Duration varies', 'duration') +
      '</span>' +
      '</button>';
  }

  function toggleSelection(id) {
    if (selected.has(id)) selected.delete(id);
    else selected.add(id);
    hideLink();
    renderGrid();
    syncTray();
  }

  function syncTray() {
    const count = document.getElementById('selectedChallengeCount');
    const generate = document.getElementById('generateSetLink');
    const clear = document.getElementById('clearSelection');
    const size = selected.size;

    if (count) count.textContent = size + ' selected';
    if (generate) generate.disabled = size === 0;
    if (clear) clear.disabled = size === 0;
  }

  function selectedIdsInCatalogOrder() {
    return catalog.challenges.filter((challenge) => selected.has(challenge.id)).map((challenge) => challenge.id);
  }

  function generateLink() {
    if (!catalog || selected.size === 0) return;

    const name = (document.getElementById('setName')?.value || '').trim();
    const relative = CC.setUrl(selectedIdsInCatalogOrder(), name);
    const absolute = CC.absoluteUrl(relative);
    const linkRow = document.getElementById('setLinkRow');
    const linkInput = document.getElementById('setLink');
    const openLink = document.getElementById('openSetLink');
    const feedback = document.getElementById('setLinkFeedback');

    if (linkInput) linkInput.value = absolute;
    if (openLink) openLink.href = relative;
    if (linkRow) linkRow.hidden = false;
    if (feedback) feedback.textContent = 'Link ready. It stores the selected challenge IDs in the URL.';
  }

  function hideLink() {
    const linkRow = document.getElementById('setLinkRow');
    const feedback = document.getElementById('setLinkFeedback');
    if (linkRow) linkRow.hidden = true;
    if (feedback) feedback.textContent = '';
  }

  function copyLink() {
    const linkInput = document.getElementById('setLink');
    const feedback = document.getElementById('setLinkFeedback');
    if (!linkInput || !linkInput.value) return;

    if (!navigator.clipboard || !window.isSecureContext) {
      linkInput.focus();
      linkInput.select();
      if (feedback) feedback.textContent = 'Copy is blocked in this browser context. Select the link and copy it manually.';
      return;
    }

    navigator.clipboard.writeText(linkInput.value)
      .then(() => {
        if (feedback) feedback.textContent = 'Copied to clipboard.';
      })
      .catch((error) => {
        linkInput.focus();
        linkInput.select();
        if (feedback) feedback.textContent = 'Copy failed: ' + error.message + '. Select the link and copy it manually.';
      });
  }

  document.addEventListener('DOMContentLoaded', init);
}());
