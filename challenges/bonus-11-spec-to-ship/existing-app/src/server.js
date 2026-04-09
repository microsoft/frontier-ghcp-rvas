const express = require('express');
const app = express();
app.use(express.json());

// In-memory data store (simulates database)
const tenants = [
  { id: 1, name: 'Acme Corp', slug: 'acme', plan: 'professional', createdAt: '2025-01-15' },
  { id: 2, name: 'Globex Inc', slug: 'globex', plan: 'starter', createdAt: '2025-03-22' },
  { id: 3, name: 'Initech Ltd', slug: 'initech', plan: 'enterprise', createdAt: '2024-11-01' },
];

const users = [
  { id: 1, tenantId: 1, email: 'alice@acme.com', role: 'admin' },
  { id: 2, tenantId: 1, email: 'bob@acme.com', role: 'user' },
  { id: 3, tenantId: 1, email: 'carol@acme.com', role: 'user' },
  { id: 4, tenantId: 2, email: 'dave@globex.com', role: 'admin' },
  { id: 5, tenantId: 2, email: 'eve@globex.com', role: 'user' },
  { id: 6, tenantId: 3, email: 'frank@initech.com', role: 'admin' },
  { id: 7, tenantId: 3, email: 'grace@initech.com', role: 'user' },
  { id: 8, tenantId: 3, email: 'heidi@initech.com', role: 'user' },
];

// Tenant endpoints
app.get('/api/tenants', (req, res) => {
  res.json(tenants);
});

app.get('/api/tenants/:id', (req, res) => {
  const tenant = tenants.find(t => t.id === parseInt(req.params.id));
  if (!tenant) return res.status(404).json({ error: 'Tenant not found' });
  res.json(tenant);
});

// User endpoints
app.get('/api/tenants/:id/users', (req, res) => {
  const tenantUsers = users.filter(u => u.tenantId === parseInt(req.params.id));
  res.json(tenantUsers);
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

const PORT = process.env.PORT || 3003;
app.listen(PORT, () => console.log(`Tenant platform running on port ${PORT}`));
