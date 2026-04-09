const express = require('express');
const app = express();
app.use(express.json());

// Simplified Order Gateway for testing ops tooling locally
// Supports query params to simulate different failure modes

let orders = [
  { id: 'ORD-001', customer: 'alice', status: 'PENDING', total: 150.00 },
  { id: 'ORD-002', customer: 'bob', status: 'SHIPPED', total: 89.99 },
  { id: 'ORD-003', customer: 'carol', status: 'DELIVERED', total: 250.00 },
];

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    uptime: process.uptime(),
    memory: process.memoryUsage(),
    timestamp: new Date().toISOString()
  });
});

app.get('/api/orders', (req, res) => {
  // simulate slow response if query param simulate=slow
  if (req.query.simulate === 'slow') {
    setTimeout(() => res.json(orders), 3000);
    return;
  }
  // simulate error if query param simulate=error
  if (req.query.simulate === 'error') {
    res.status(500).json({ error: 'Database connection pool exhausted' });
    return;
  }
  res.json(orders);
});

app.get('/api/orders/:id', (req, res) => {
  const order = orders.find(o => o.id === req.params.id);
  if (!order) return res.status(404).json({ error: 'Order not found' });
  res.json(order);
});

app.post('/api/orders', (req, res) => {
  const { customer, total } = req.body;
  if (!customer || !total) {
    return res.status(400).json({ error: 'customer and total required' });
  }
  const order = { id: `ORD-${String(orders.length + 1).padStart(3, '0')}`, customer, status: 'PENDING', total };
  orders.push(order);
  console.log(`[${new Date().toISOString()}] INFO  Order created: ${order.id}`);
  res.status(201).json(order);
});

const PORT = process.env.PORT || 3002;
app.listen(PORT, () => console.log(`Order Gateway (demo) running on port ${PORT}`));
