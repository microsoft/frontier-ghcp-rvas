(function () {
  'use strict';

  const CC = window.ChallengeCurator;
  if (!CC) return;

  function init() {
    const root = document.querySelector('[data-curator-page="set"]');
    if (!root) return;

    const grid = document.getElementById('challengeSetGrid');
    const params = CC.parseSetQuery(window.location.search);
    CC.applyCuratedMode('../challenge-selection/');

    if (!params.hasIds) {
      renderEmptySet(grid);
      return;
    }

    CC.renderStatus(grid, 'Loading challenge set', 'Reading the selected IDs from the catalog.');
    CC.loadCatalog()
      .then((catalog) => renderSet(catalog, params))
      .catch((error) => {
        CC.renderStatus(grid, 'Could not load the challenge set', error.message, 'error');
      });
  }

  function renderSet(catalog, params) {
    const grid = document.getElementById('challengeSetGrid');
    const warning = document.getElementById('challengeSetWarning');
    const items = CC.catalogSubset(catalog, params.ids);
    const foundIds = new Set(items.map((item) => item.id));
    const missing = params.ids.filter((id) => !foundIds.has(id));

    renderHeading(params.name, items.length);
    renderWarnings(warning, params.invalid, missing);

    if (!items.length) {
      CC.renderStatus(grid, 'No matching challenges found', 'Check the link or build a new challenge set.', 'error');
      return;
    }

    grid.innerHTML = items.map((challenge) => renderCard(challenge, params)).join('');
  }

  function renderHeading(name, count) {
    const title = name || 'Curated challenge set';
    document.title = title + ' - GitHub Copilot Enterprise Hackathon';

    const heading = document.getElementById('challengeSetHeading');
    const intro = document.getElementById('challengeSetIntro');
    if (heading) heading.textContent = title;
    if (intro) {
      intro.textContent = 'This view contains ' + count + ' selected challenge' + (count === 1 ? '' : 's') + ' in catalog order.';
    }
  }

  function renderWarnings(container, invalid, missing) {
    if (!container) return;

    const messages = [];
    if (invalid.length) messages.push('Ignored invalid IDs: ' + invalid.join(', ') + '.');
    if (missing.length) messages.push('These IDs were not found in the catalog: ' + missing.join(', ') + '.');

    if (!messages.length) {
      container.hidden = true;
      container.textContent = '';
      return;
    }

    container.hidden = false;
    container.textContent = messages.join(' ');
  }

  function renderCard(challenge, params) {
    return '<a class="challenge-curator-card" role="listitem" href="' + CC.escapeHtml(CC.challengeLink(challenge, params)) + '">' +
      '<span class="challenge-curator-kicker">Challenge ' + challenge.number + '</span>' +
      '<strong>' + CC.escapeHtml(challenge.title) + '</strong>' +
      '<p>' + CC.escapeHtml(challenge.selection_hint || challenge.focus) + '</p>' +
      '<span class="challenge-curator-meta">' +
      CC.badge(challenge.category, 'category') +
      CC.badge(challenge.duration || 'Duration varies', 'duration') +
      '</span>' +
      '</a>';
  }

  function renderEmptySet(grid) {
    const heading = document.getElementById('challengeSetHeading');
    const intro = document.getElementById('challengeSetIntro');
    if (heading) heading.textContent = 'No challenge set selected';
    if (intro) intro.textContent = 'Open a link from the builder, or create a new challenge set.';
    if (!grid) return;
    grid.innerHTML = '<div class="challenge-curator-status challenge-curator-status--empty" role="status">' +
      '<strong>No IDs were provided.</strong>' +
      '<p><a href="../challenge-builder/">Build a challenge set</a> and share the generated link.</p>' +
      '</div>';
  }

  document.addEventListener('DOMContentLoaded', init);
}());
