/* GitHub Copilot Adoption -- home page */
(function () {
  'use strict';

  async function init() {
    const form = document.getElementById('roleForm');
    const select = document.getElementById('roleSelect');
    const submit = document.getElementById('roleSubmit');
    const status = document.getElementById('roleStatus');
    form.hidden = false;
    status.hidden = false;

    try {
      const { roles } = await FP.loadRoles();
      if (!Array.isArray(roles) || !roles.length) {
        throw new Error('No role collections are available.');
      }

      select.innerHTML = '<option value="" disabled selected>Choose a role</option>'
        + roles.map((role) =>
          `<option value="${FP.esc(role.id)}">${FP.esc(role.name)}</option>`
        ).join('');
      select.disabled = false;
      submit.disabled = false;
      status.textContent = '';
    } catch (e) {
      FP.renderError('roleStatus', e.message + ' Use Browse all challenges to continue.');
      return;
    }

    form.addEventListener('submit', (event) => {
      event.preventDefault();
      if (!select.reportValidity()) return;
      window.location.assign('roles.html#' + encodeURIComponent(select.value));
    });
  }

  document.addEventListener('DOMContentLoaded', init);
})();
