const identity = document.querySelector("#identity");
const register = document.querySelector("#requests");
const errorBox = document.querySelector("#error");
const notice = document.querySelector("#notice");
const form = document.querySelector("#create-form");
const fields = document.querySelector("#create-fields");
let users = [];
let requests = [];

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
    submit.addEventListener("click", async () => {
      clearMessages();
      submit.disabled = true;
      try {
        const updated = await api(`/api/requests/${request.id}/submit`, { method: "POST" });
        requests = requests.map((item) => item.id === updated.id ? updated : item);
        render();
        notice.textContent = `${updated.id} submitted.`;
      } catch (error) {
        showError(error);
        submit.disabled = false;
      }
    });
    register.append(card);
  }
}

async function refresh() {
  register.setAttribute("aria-busy", "true");
  try {
    const [loadedUsers, loadedRequests] = await Promise.all([api("/api/users"), api("/api/requests")]);
    const selected = identity.value;
    users = loadedUsers;
    requests = loadedRequests;
    identity.replaceChildren(...users.map((user) => new Option(`${user.name} / ${user.role}`, user.id)));
    if (users.some((user) => user.id === selected)) identity.value = selected;
    identity.disabled = false;
    fields.disabled = false;
    render();
  } finally {
    register.setAttribute("aria-busy", "false");
  }
}

identity.addEventListener("change", () => {
  clearMessages();
  render();
});
document.querySelector("#refresh").addEventListener("click", async (event) => {
  clearMessages();
  const button = event.currentTarget;
  button.disabled = true;
  try {
    await refresh();
    notice.textContent = "Register refreshed.";
  } catch (error) {
    showError(error);
  } finally {
    button.disabled = false;
  }
});

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  clearMessages();
  const data = new FormData(form);
  const [whole, fraction = ""] = String(data.get("cost")).split(".");
  const costCents = Number(whole) * 100 + Number(fraction.padEnd(2, "0"));
  if (!Number.isSafeInteger(costCents)) {
    showError(new Error("The estimated cost is too large."));
    return;
  }
  fields.disabled = true;
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
    fields.disabled = false;
  }
});

refresh().catch(showError);
