import express, { type ErrorRequestHandler, type Request } from "express";
import { fileURLToPath } from "node:url";
import { demoUsers, RequestError, RequestStore } from "./requests.js";

function actorId(request: Request): string {
  const id = request.get("x-demo-user-id");
  if (!id || !demoUsers.some((user) => user.id === id)) {
    throw new RequestError(400, "Choose a valid demo identity.");
  }
  return id;
}

function requestInput(value: unknown) {
  if (typeof value !== "object" || value === null || Array.isArray(value)) {
    throw new RequestError(400, "Provide a JSON request object.");
  }
  const { title, description, costCents } = value as Record<string, unknown>;
  if (typeof title !== "string" || !title.trim() || title.trim().length > 100) {
    throw new RequestError(400, "Title must contain 1 to 100 characters.");
  }
  if (typeof description !== "string" || !description.trim() || description.trim().length > 1000) {
    throw new RequestError(400, "Description must contain 1 to 1000 characters.");
  }
  if (typeof costCents !== "number" || !Number.isSafeInteger(costCents) || costCents < 0) {
    throw new RequestError(400, "Cost must be a non-negative safe integer in cents.");
  }
  return { title: title.trim(), description: description.trim(), costCents };
}

export function createApp() {
  const app = express();
  const store = new RequestStore();
  app.disable("x-powered-by");
  app.use(express.json({ limit: "16kb" }));

  app.get("/api/users", (_request, response) => {
    response.json(demoUsers);
  });
  app.get("/api/requests", (_request, response) => {
    response.json(store.list());
  });
  app.get("/api/requests/:id", (request, response) => {
    response.json(store.get(request.params.id));
  });
  app.post("/api/requests", (request, response) => {
    const created = store.create(actorId(request), requestInput(request.body));
    response.status(201).location(`/api/requests/${created.id}`).json(created);
  });
  app.post("/api/requests/:id/submit", (request, response) => {
    response.json(store.submit(request.params.id, actorId(request)));
  });

  app.use(express.static(fileURLToPath(new URL("../../public/", import.meta.url))));
  app.use((_request, response) => {
    response.status(404).json({ error: "Route not found." });
  });

  const errors: ErrorRequestHandler = (error: unknown, _request, response, _next) => {
    if (error instanceof RequestError) {
      response.status(error.status).json({ error: error.message });
    } else if (error instanceof Error && "type" in error && error.type === "entity.parse.failed") {
      response.status(400).json({ error: "Invalid JSON body." });
    } else if (error instanceof Error && "type" in error && error.type === "entity.too.large") {
      response.status(413).json({ error: "Request body exceeds 16 KB." });
    } else {
      console.error("Unexpected request failure:", error);
      response.status(500).json({ error: "The server could not complete the request." });
    }
  };
  app.use(errors);
  return app;
}
