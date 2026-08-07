import { randomUUID } from "node:crypto";
import http from "node:http";

function sendJson(response, status, body, headers = {}) {
  response.writeHead(status, {
    "content-type": "application/json",
    ...headers
  });
  response.end(JSON.stringify(body));
}

function customerHandler(request, response) {
  if (request.method === "GET" && request.url?.startsWith("/v1/customers")) {
    sendJson(response, 200, {
      items: [
        {
          customerId: "cus-100",
          displayName: "Northwind Field Services",
          primaryEmail: "ops@northwind.example"
        }
      ],
      totalCount: 1
    });
    return;
  }

  sendJson(response, 404, {
    type: "https://errors.example/not-found",
    title: "Resource not found",
    status: 404
  });
}

function orderHandler(request, response) {
  if (request.method === "GET" && request.url?.startsWith("/orders/v2")) {
    if (!request.headers["x-api-key"]) {
      sendJson(response, 401, {
        error_code: "missing_key",
        message: "X-API-Key is required",
        traceId: randomUUID()
      });
      return;
    }

    sendJson(response, 200, {
      order_items: [
        {
          order_id: "ord-900",
          customer_id: "cus-100",
          created_at: "2026-08-01T09:30:00Z"
        }
      ],
      page: 1,
      pages: 1
    }, {
      "x-trace-id": randomUUID()
    });
    return;
  }

  sendJson(response, 404, {
    error_code: "not_found",
    message: "Route not found",
    traceId: randomUUID()
  });
}

function billingHandler(request, response) {
  if (request.method === "GET" && request.url?.startsWith("/api/invoices")) {
    sendJson(response, 200, {
      Invoices: [
        {
          InvoiceNumber: "INV-2026-0801",
          AccountID: "cus-100",
          AmountDue: 143.75
        }
      ],
      NextToken: null
    }, {
      "x-request-id": randomUUID()
    });
    return;
  }

  response.writeHead(500, {
    "content-type": "text/plain"
  });
  response.end("Billing route failed");
}

const definitions = [
  { name: "customer-profile", port: 4101, handler: customerHandler },
  { name: "order-management", port: 4102, handler: orderHandler },
  { name: "billing", port: 4103, handler: billingHandler }
];

export async function startAllMocks() {
  const running = [];

  for (const definition of definitions) {
    const server = http.createServer(definition.handler);
    await new Promise((resolve, reject) => {
      server.once("error", reject);
      server.listen(definition.port, "127.0.0.1", resolve);
    });
    running.push({ ...definition, server });
  }

  return running;
}

export async function stopAllMocks(running) {
  await Promise.all(running.map(({ server }) => new Promise((resolve, reject) => {
    server.close(error => error ? reject(error) : resolve());
  })));
}
