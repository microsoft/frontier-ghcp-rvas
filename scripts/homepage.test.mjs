import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import test from 'node:test';
import { runInNewContext } from 'node:vm';

const source = readFileSync(new URL('../web/assets/js/home.js', import.meta.url), 'utf8');

function homepage(loadRoles) {
  const listeners = {};
  const errors = [];
  const destinations = [];
  const elements = {
    roleForm: {
      hidden: true,
      addEventListener: (name, handler) => { listeners[name] = handler; }
    },
    roleSelect: {
      disabled: true,
      value: '',
      innerHTML: '',
      reportValidity() { return this.value !== ''; }
    },
    roleSubmit: { disabled: true },
    roleStatus: { hidden: true, textContent: 'Loading roles...' }
  };
  runInNewContext(source, {
    document: {
      getElementById: (id) => elements[id],
      addEventListener: (name, handler) => { listeners[name] = handler; }
    },
    FP: {
      loadRoles,
      esc: (value) => String(value).replace(/[&<>"']/g, (character) =>
        ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[character])),
      renderError: (id, message) => { errors.push({ id, message }); }
    },
    window: { location: { assign: (url) => { destinations.push(url); } } }
  });
  return { elements, listeners, errors, destinations, ready: listeners.DOMContentLoaded() };
}

test('role finder stays disabled while loading, then uses the configured roles', async () => {
  let resolveRoles;
  const page = homepage(() => new Promise((resolve) => { resolveRoles = resolve; }));
  assert.equal(page.elements.roleForm.hidden, false);
  assert.equal(page.elements.roleStatus.hidden, false);
  assert.equal(page.elements.roleSelect.disabled, true);
  assert.equal(page.elements.roleSubmit.disabled, true);
  resolveRoles({ roles: [{ id: 'engineering', name: 'Engineering & <Review>' }] });
  await page.ready;
  assert.equal(page.elements.roleSelect.disabled, false);
  assert.equal(page.elements.roleSubmit.disabled, false);
  assert.match(page.elements.roleSelect.innerHTML, /value="engineering"/);
  assert.match(page.elements.roleSelect.innerHTML, /Engineering &amp; &lt;Review&gt;/);
  assert.equal(page.elements.roleStatus.textContent, '');
});

test('role finder requires a selection and opens the selected collection', async () => {
  const page = homepage(async () => ({ roles: [{ id: 'engineering & ops', name: 'Engineering' }] }));
  await page.ready;
  let prevented = 0;
  const event = { preventDefault: () => { prevented++; } };
  page.listeners.submit(event);
  assert.deepEqual(page.destinations, []);
  page.elements.roleSelect.value = 'engineering & ops';
  page.listeners.submit(event);
  assert.equal(prevented, 2);
  assert.deepEqual(page.destinations, ['roles.html#engineering%20%26%20ops']);
});

test('role load failure explains how to continue without enabling a broken form', async () => {
  const page = homepage(async () => { throw new Error('Role data unavailable'); });
  await page.ready;
  assert.equal(page.elements.roleSelect.disabled, true);
  assert.equal(page.elements.roleSubmit.disabled, true);
  assert.equal(page.errors.length, 1);
  assert.equal(page.errors[0].id, 'roleStatus');
  assert.match(page.errors[0].message, /Role data unavailable/);
  assert.match(page.errors[0].message, /Browse all challenges/);
  assert.equal(page.listeners.submit, undefined);
});

test('empty role data offers recovery instead of an unusable selection', async () => {
  const page = homepage(async () => ({ roles: [] }));
  await page.ready;
  assert.equal(page.elements.roleSubmit.disabled, true);
  assert.equal(page.errors.length, 1);
  assert.match(page.errors[0].message, /No role collections are available/);
  assert.match(page.errors[0].message, /Browse all challenges/);
});
