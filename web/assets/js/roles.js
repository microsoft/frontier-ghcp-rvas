/* GitHub Copilot Adoption -- challenges grouped by enterprise role */
(function () {
  'use strict';

  async function init() {
    let data, roleData;
    try {
      [data, roleData] = await Promise.all([FP.loadData(), FP.loadRoles()]);
    } catch (e) {
      FP.renderError('roleIndex', e.message);
      FP.renderError('roleCollections', e.message);
      return;
    }

    const roles = roleData.roles || [];
    const challenges = data.challenges || [];
    const categories = data.categories || [];
    const challengeById = new Map(challenges.map((challenge) => [challenge.id, challenge]));

    const missing = roles.flatMap((role) =>
      (role.challenge_ids || [])
        .filter((id) => !challengeById.has(id))
        .map((id) => `${role.id}: ${id}`)
    );
    if (missing.length) {
      const message = 'Role data references unavailable challenges: ' + missing.join(', ');
      FP.renderError('roleIndex', message);
      FP.renderError('roleCollections', message);
      return;
    }

    renderRoleIndex(roles);
    renderRoleCollections(roles, challengeById, categories);
    FP.initReveal();
    scrollToRequestedRole();
  }

  function scrollToRequestedRole() {
    if (!window.location.hash) return;
    const id = window.location.hash.slice(1);
    const target = document.getElementById(id);
    if (target) requestAnimationFrame(() => target.scrollIntoView());
  }

  function renderRoleIndex(roles) {
    const index = document.getElementById('roleIndex');
    if (!index) return;
    if (!roles.length) {
      index.innerHTML = '<div class="empty">No role collections configured.</div>';
      return;
    }

    index.innerHTML = roles.map((role, position) => `
      <a class="role-summary-card reveal" href="#${FP.esc(role.id)}">
        <span class="role-sequence">${String(position + 1).padStart(2, '0')}</span>
        <span class="role-summary-name">${FP.esc(role.name)}</span>
        <span class="role-summary-description">${FP.esc(role.description)}</span>
        <span class="role-summary-count">${role.challenge_ids.length} challenges</span>
      </a>
    `).join('');
  }

  function renderRoleCollections(roles, challengeById, categories) {
    const container = document.getElementById('roleCollections');
    if (!container) return;

    container.innerHTML = roles.map((role, index) => {
      const challenges = role.challenge_ids.map((id) => challengeById.get(id));
      return `
        <section class="role-section ${index % 2 ? 'role-section-alt' : ''}" id="${FP.esc(role.id)}" aria-labelledby="${FP.esc(role.id)}-heading">
          <div class="wrap">
            <div class="role-section-heading reveal">
              <div class="role-section-number">${String(index + 1).padStart(2, '0')}</div>
              <div>
                <span class="eyebrow">Role collection</span>
                <h2 id="${FP.esc(role.id)}-heading">${FP.esc(role.name)}</h2>
                <p>${FP.esc(role.description)}</p>
              </div>
              <a class="role-anchor-link" href="#${FP.esc(role.id)}" aria-label="Link to ${FP.esc(role.name)} role collection">
                ${challenges.length} challenges
              </a>
            </div>
            <div class="challenge-grid">
              ${challenges.map((challenge) => challengeCard(challenge, categories)).join('')}
            </div>
          </div>
        </section>
      `;
    }).join('');
  }

  function challengeCard(challenge, categories) {
    const color = categories.find((category) => category.id === challenge.category)?.color
      || FP.categoryColor(challenge.category);
    return `
      <a href="${FP.challengeUrl(challenge.id)}" class="ch-card cat-${FP.esc(challenge.category)} reveal"
         style="--cat-color:${color}">
        <div class="ch-card-top">
          <span class="ch-mod-dot"></span>
          <span class="ch-module-label">${FP.esc(challenge.category_name)}</span>
          <span class="ch-number">#${challenge.number}</span>
        </div>
        <div class="ch-title">${FP.esc(challenge.title)}</div>
        <div class="ch-desc">${FP.esc(challenge.description)}</div>
        <div class="ch-footer">
          ${FP.diffBadge(challenge.difficulty)}
          ${FP.durBadge(challenge.duration_minutes)}
          <div class="ch-tags">${FP.tagBadges(challenge.tags, 3)}</div>
        </div>
      </a>
    `;
  }

  document.addEventListener('DOMContentLoaded', init);
})();
