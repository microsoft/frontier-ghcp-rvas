<!-- markdownlint-disable MD033 -->

# Challenge Set Builder

Use this page when a workshop needs a short, coach-picked list instead of the full catalog. Select top-level challenges, give the set a name if it helps, then share the generated link.

The link keeps its state in the URL. There is no sign-in, saved browser state, backend, or database.

<div class="challenge-curator challenge-curator--builder" data-curator-page="builder">
  <section class="challenge-curator-hero" aria-labelledby="challengeBuilderHeading">
    <span class="challenge-curator-kicker">Coach toolkit</span>
    <h2 id="challengeBuilderHeading">Build a focused challenge set</h2>
    <p>Pick complete challenges only. The student view will keep them in catalog order so the set reads the same way as the main selection guide.</p>
  </section>

  <section class="challenge-curator-toolbar" aria-label="Find challenges">
    <label class="challenge-curator-field" for="challengeSearch">
      <span>Search</span>
      <input id="challengeSearch" type="search" autocomplete="off" placeholder="Search by role, technology, or challenge number">
    </label>

    <div class="challenge-curator-filters" aria-label="Filter by category">
      <span class="challenge-curator-filter-label">Category</span>
      <span id="categoryFilters" class="challenge-curator-filters" role="group" aria-label="Challenge categories"></span>
      <button id="clearChallengeFilters" class="challenge-curator-chip" type="button">Clear</button>
      <span id="visibleChallengeCount" class="challenge-curator-count" aria-live="polite">0 shown</span>
    </div>
  </section>

  <section aria-labelledby="challengeBuilderGridHeading">
    <h3 id="challengeBuilderGridHeading">Available challenges</h3>
    <div id="challengeBuilderGrid" class="challenge-curator-grid" role="list" aria-label="Selectable challenges"></div>
  </section>

  <section class="challenge-curator-tray" aria-label="Generated challenge set">
    <strong id="selectedChallengeCount" class="challenge-curator-count">0 selected</strong>
    <label class="challenge-curator-field" for="setName">
      <span>Set name</span>
      <input id="setName" type="text" autocomplete="off" maxlength="80" placeholder="For example: Security basics">
    </label>
    <button id="clearSelection" class="challenge-curator-button" type="button" disabled>Clear selection</button>
    <button id="generateSetLink" class="challenge-curator-button challenge-curator-button--primary" type="button" disabled>Generate link</button>

    <div id="setLinkRow" class="challenge-curator-link-row" hidden>
      <input id="setLink" type="text" readonly aria-label="Generated challenge set link">
      <button id="copySetLink" class="challenge-curator-button" type="button">Copy</button>
      <a id="openSetLink" class="challenge-curator-button" href="../challenge-set/" target="_blank" rel="noopener">Open</a>
      <span id="setLinkFeedback" class="challenge-curator-feedback" aria-live="polite"></span>
    </div>
  </section>
</div>
