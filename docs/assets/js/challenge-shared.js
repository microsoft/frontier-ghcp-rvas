(function () {
  'use strict';

  const namespace = (window.ChallengeCurator = window.ChallengeCurator || {});
  const currentScript = document.currentScript || Array.from(document.scripts).find((script) => /challenge-shared\.js(?:\?|$)/.test(script.src));
  const dataUrl = currentScript ? new URL('../data/challenges.json', currentScript.src).href : 'assets/data/challenges.json';

  namespace.dataUrl = dataUrl;

  namespace.loadCatalog = async function loadCatalog() {
    if (namespace.catalog) return namespace.catalog;

    const response = await fetch(namespace.dataUrl, { cache: 'no-cache' });
    if (!response.ok) {
      throw new Error('Challenge catalog returned HTTP ' + response.status + '. Run scripts/generate-challenge-catalog.py and rebuild the docs.');
    }

    const catalog = await response.json();
    if (!catalog || !Array.isArray(catalog.challenges)) {
      throw new Error('Challenge catalog is missing the challenges array.');
    }
    if (catalog.challenges.length !== 22) {
      throw new Error('Challenge catalog has ' + catalog.challenges.length + ' entries. Expected 22.');
    }

    namespace.catalog = catalog;
    return catalog;
  };

  namespace.escapeHtml = function escapeHtml(value) {
    return String(value == null ? '' : value).replace(/[&<>"']/g, (char) => ({
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#39;',
    }[char]));
  };

  namespace.parseSetQuery = function parseSetQuery(search) {
    const params = new URLSearchParams(search || window.location.search);
    const rawIds = params.get('ids') || params.get('set') || '';
    const ids = [];
    const invalid = [];
    const seen = new Set();

    rawIds.split(',').map((part) => part.trim()).filter(Boolean).forEach((part) => {
      if (!/^\d+$/.test(part)) {
        invalid.push(part);
        return;
      }
      const id = Number(part);
      if (id < 0 || id > 21) {
        invalid.push(part);
        return;
      }
      if (!seen.has(id)) {
        seen.add(id);
        ids.push(id);
      }
    });

    return {
      ids,
      invalid,
      name: (params.get('name') || '').trim(),
      hasIds: rawIds.trim().length > 0,
    };
  };

  namespace.catalogSubset = function catalogSubset(catalog, ids) {
    const selected = new Set(ids);
    return (catalog.challenges || []).filter((challenge) => selected.has(challenge.id));
  };

  namespace.setUrl = function setUrl(ids, name) {
    let url = '../challenge-set/?ids=' + ids.join(',');
    if (name) url += '&name=' + encodeURIComponent(name);
    return url;
  };

  namespace.absoluteUrl = function absoluteUrl(relativeUrl) {
    return new URL(relativeUrl, window.location.href).href;
  };

  namespace.challengeLink = function challengeLink(challenge, setParams) {
    let url = '../' + String(challenge.track_url || '')
      .replace(/^\.\//, '')
      .replace(/\.md$/, '/');

    if (setParams && Array.isArray(setParams.ids) && setParams.ids.length) {
      const params = new URLSearchParams();
      params.set('set', setParams.ids.join(','));
      if (setParams.name) params.set('name', setParams.name);
      url += '?' + params.toString();
    }

    return url;
  };

  namespace.badge = function badge(text, tone) {
    const cssTone = tone ? ' challenge-curator-badge--' + namespace.escapeHtml(tone) : '';
    return '<span class="challenge-curator-badge' + cssTone + '">' + namespace.escapeHtml(text) + '</span>';
  };

  namespace.renderStatus = function renderStatus(container, title, detail, tone) {
    if (!container) return;
    const cssTone = tone ? ' challenge-curator-status--' + namespace.escapeHtml(tone) : '';
    container.innerHTML = '<div class="challenge-curator-status' + cssTone + '" role="status">' +
      '<strong>' + namespace.escapeHtml(title) + '</strong>' +
      (detail ? '<p>' + namespace.escapeHtml(detail) + '</p>' : '') +
      '</div>';
  };

  namespace.applyCuratedMode = function applyCuratedMode(exitHref) {
    document.documentElement.setAttribute('data-challenge-curated', 'true');
    if (document.getElementById('challengeCuratorExit')) return;

    const exit = document.createElement('a');
    exit.id = 'challengeCuratorExit';
    exit.className = 'challenge-curator-exit';
    exit.href = exitHref || '../challenge-selection/';
    exit.textContent = 'Exit view';
    exit.setAttribute('aria-label', 'Exit curated view and return to the full challenge selection');
    document.body.appendChild(exit);
  };

  document.addEventListener('DOMContentLoaded', () => {
    const params = new URLSearchParams(window.location.search);
    if (!params.has('set')) return;
    const setParams = namespace.parseSetQuery(window.location.search);
    if (setParams.hasIds) namespace.applyCuratedMode('../challenge-selection/');
  });
}());
