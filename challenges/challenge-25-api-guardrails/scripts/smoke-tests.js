import assert from "node:assert/strict";
import { startAllMocks, stopAllMocks } from "../mocks/services.js";

const running = await startAllMocks();

try {
  const customers = await fetch("http://127.0.0.1:4101/v1/customers?offset=0&limit=5");
  assert.equal(customers.status, 200);
  const customerBody = await customers.json();
  assert.equal(customerBody.items[0].customerId, "cus-100");

  const unauthenticatedOrders = await fetch("http://127.0.0.1:4102/orders/v2");
  assert.equal(unauthenticatedOrders.status, 401);

  const orders = await fetch("http://127.0.0.1:4102/orders/v2?page=1&page_size=5", {
    headers: {
      "X-API-Key": "local-smoke-test"
    }
  });
  assert.equal(orders.status, 200);
  const orderBody = await orders.json();
  assert.equal(orderBody.order_items[0].order_id, "ord-900");
  assert.ok(orders.headers.get("x-trace-id"));

  const invoices = await fetch("http://127.0.0.1:4103/api/invoices?maxResults=5");
  assert.equal(invoices.status, 200);
  const invoiceBody = await invoices.json();
  assert.equal(invoiceBody.Invoices[0].InvoiceNumber, "INV-2026-0801");
  assert.ok(invoices.headers.get("x-request-id"));

  console.log("Mock smoke tests passed for all three services.");
} finally {
  await stopAllMocks(running);
}
