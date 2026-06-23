/* GitHub Copilot Enterprise Hackathon — learning paths page */
(function () {
  'use strict';

  async function init() {
    let data, pathsData;
    try {
      data = await FP.loadData();
      pathsData = await FP.loadPaths();
    } catch (e) {
      FP.renderError('pathsGrid', e.message);
      return;
    }

    const { challenges } = data;
    const { paths } = pathsData;

    renderPaths(paths || [], challenges);
  }

  function renderPaths(paths, challenges) {
    const grid = document.getElementById('pathsGrid');
    if (!grid) return;

    if (!paths.length) {
      grid.innerHTML = '<div class="empty">No learning paths configured.</div>';
      return;
    }

    grid.innerHTML = paths.map((p, idx) => {
      const count = (p.challenge_ids || []).length;
      const mins = (p.challenge_ids || []).reduce((sum, id) => {
        const c = challenges.find((x) => x.id === id);
        return sum + (c && c.duration_minutes ? c.duration_minutes : 0);
      }, 0);

      const chList = (p.challenge_ids || [])
        .map((id) => {
          const c = challenges.find((x) => x.id === id);
          return c ? `<li><a href="${FP.challengeUrl(c.id)}">${FP.esc(c.title)}</a></li>` : '';
        })
        .filter(Boolean)
        .join('');

      const setUrl = FP.setUrl(p.challenge_ids, p.name);
      const absUrl = new URL(setUrl, window.location.href).href;

      const shareId = 'share-' + idx;
      const inputId = 'link-' + idx;

      const outcomeHtml = (p.outcomes || []).length
        ? '<div class="path-outcomes">' + (p.outcomes || []).map((o) => {
            const oc = FP._cache?.outcomeConfig?.find((x) => x.id === o);
            return `<span class="badge badge-outcome" title="${FP.esc(oc ? oc.description : '')}">${FP.esc(oc ? oc.name : o)}</span>`;
          }).join('') + '</div>'
        : '';

      return `
        <div class="path-card reveal card">
          <div class="path-card-header">
            <div>
              <span class="path-id">${FP.esc(p.id)}</span>
              <h3 class="path-title">${FP.esc(p.name)}</h3>
              <p class="path-desc">${FP.esc(p.description || '')}</p>
              ${outcomeHtml}
            </div>
            <div class="path-meta">
              <span class="badge badge-duration">${count} challenges</span>
              ${FP.durBadge(mins)}
            </div>
          </div>
          <div class="path-challenges">
            <h4>Challenges</h4>
            <ol class="challenge-list">${chList}</ol>
          </div>
          <div class="path-share" id="${shareId}">
            <button class="btn btn-sm btn-ghost" type="button" data-action="show">Share with students</button>
            <div class="share-controls" style="display:none">
              <label for="${inputId}" class="sr-only">Student link</label>
              <input type="text" id="${inputId}" class="share-input" value="${FP.esc(absUrl)}" readonly />
              <button class="btn btn-sm btn-ghost" type="button" data-action="copy">Copy</button>
              <a class="btn btn-sm btn-primary" href="${setUrl}" target="_blank">Open</a>
            </div>
          </div>
        </div>`;
    }).join('');

    FP.initReveal();
    attachShareListeners();
  }

  function attachShareListeners() {
    document.querySelectorAll('.path-share').forEach((el) => {
      const showBtn = el.querySelector('[data-action="show"]');
      const copyBtn = el.querySelector('[data-action="copy"]');
      const controls = el.querySelector('.share-controls');
      const input = el.querySelector('.share-input');

      if (showBtn && controls) {
        showBtn.addEventListener('click', () => {
          showBtn.style.display = 'none';
          controls.style.display = 'flex';
        });
      }

      if (copyBtn && input) {
        copyBtn.addEventListener('click', () => {
          input.select();
          input.setSelectionRange(0, 99999);
          navigator.clipboard.writeText(input.value).then(() => {
            const orig = copyBtn.textContent;
            copyBtn.textContent = 'Copied!';
            setTimeout(() => { copyBtn.textContent = orig; }, 1200);
          }).catch(() => {
            copyBtn.textContent = 'Failed';
          });
        });
      }
    });
  }

  document.addEventListener('DOMContentLoaded', init);
})();
