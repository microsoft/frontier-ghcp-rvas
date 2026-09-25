const identity = document.querySelector("#identity");
const register = document.querySelector("#requests");
const errorBox = document.querySelector("#error");
const notice = document.querySelector("#notice");
const form = document.querySelector("#create-form");
const fields = document.querySelector("#create-fields");
const refreshButton = document.querySelector("#refresh");
let users = [];
let requests = [];
let busy = false;

function setBusy(value) {
  busy = value;
  refreshButton.disabled = busy;
  identity.disabled = busy || users.length === 0;
  fields.disabled = busy || users.length === 0;
  register.setAttribute("aria-busy", String(busy));
  for (const button of register.querySelectorAll(".submit-request")) {
    button.disabled = busy;
  }
}

function showError(error) {
  errorBox.textContent = error instanceof Error ? error.message : String(error);
  errorBox.hidden = false;
}

function clearMessages() {
  errorBox.hidden = true;
  errorBox.textContent = "";
  notice.textContent = "";
}

async function api(path, options = {}) {
  const response = await fetch(path, {
    ...options,
    headers: { "Content-Type": "application/json", "x-demo-user-id": identity.value },
  });
  const result = await response.json();
  if (!response.ok) throw new Error(result.error ?? `Request failed (${response.status}).`);
  return result;
}

function render() {
  register.replaceChildren();
  for (const request of requests) {
    const card = document.querySelector("#request-template").content.cloneNode(true);
    card.querySelector(".request-id").textContent = request.id;
    card.querySelector("h3").textContent = request.title;
    card.querySelector(".description").textContent = request.description;
    card.querySelector(".status").textContent = request.status;
    card.querySelector(".requester").textContent =
      users.find((user) => user.id === request.requesterId)?.name ?? request.requesterId;
    card.querySelector(".cost").textContent =
      new Intl.NumberFormat("en-US", { style: "currency", currency: "USD" }).format(request.costCents / 100);
    const submit = card.querySelector(".submit-request");
    submit.hidden = request.status !== "draft" || request.requesterId !== identity.value;
    submit.disabled = busy;
    submit.addEventListener("click", async () => {
      if (busy) return;
      clearMessages();
      setBusy(true);
      try {
        const updated = await api(`/api/requests/${request.id}/submit`, { method: "POST" });
        requests = requests.map((item) => item.id === updated.id ? updated : item);
        render();
        notice.textContent = `${updated.id} submitted.`;
      } catch (error) {
        showError(error);
      } finally {
        setBusy(false);
      }
    });
    register.append(card);
  }
}

async function refresh() {
  setBusy(true);
  try {
    const [loadedUsers, loadedRequests] = await Promise.all([api("/api/users"), api("/api/requests")]);
    const selected = identity.value;
    users = loadedUsers;
    requests = loadedRequests;
    identity.replaceChildren(...users.map((user) => new Option(`${user.name} / ${user.role}`, user.id)));
    if (users.some((user) => user.id === selected)) identity.value = selected;
    render();
  } finally {
    setBusy(false);
  }
}

identity.addEventListener("change", () => {
  clearMessages();
  render();
});
refreshButton.addEventListener("click", async () => {
  if (busy) return;
  clearMessages();
  try {
    await refresh();
    notice.textContent = "Register refreshed.";
  } catch (error) {
    showError(error);
  }
});

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  if (busy) return;
  clearMessages();
  const data = new FormData(form);
  const [whole, fraction = ""] = String(data.get("cost")).split(".");
  const costCents = Number(whole) * 100 + Number(fraction.padEnd(2, "0"));
  if (!Number.isSafeInteger(costCents)) {
    showError(new Error("The estimated cost is too large."));
    return;
  }
  setBusy(true);
  try {
    const created = await api("/api/requests", {
      method: "POST",
      body: JSON.stringify({ title: data.get("title"), description: data.get("description"), costCents }),
    });
    requests.push(created);
    render();
    form.reset();
    notice.textContent = `${created.id} created as a draft.`;
  } catch (error) {
    showError(error);
  } finally {
    setBusy(false);
  }
});

refresh().catch(showError);
