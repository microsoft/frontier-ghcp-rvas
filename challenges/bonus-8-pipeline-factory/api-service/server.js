const express = require('express');
const cors = require('cors');
const Database = require('better-sqlite3');
const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());

const db = new Database(':memory:');

// Initialize schema
db.exec(`
  CREATE TABLE tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    status TEXT DEFAULT 'todo',
    priority TEXT DEFAULT 'medium',
    assignee TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
  );

  INSERT INTO tasks (title, description, status, priority, assignee) VALUES
  ('Set up CI pipeline', 'Configure GitHub Actions for automated builds', 'todo', 'high', 'alice'),
  ('Write API tests', 'Add integration tests for all endpoints', 'in-progress', 'high', 'bob'),
  ('Deploy to staging', 'Set up staging environment', 'todo', 'medium', 'carol'),
  ('Fix login bug', 'Users report intermittent login failures', 'in-progress', 'high', 'alice'),
  ('Update dependencies', 'Several packages have security advisories', 'todo', 'low', null);
`);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// List tasks
app.get('/api/tasks', (req, res) => {
  const { status, assignee } = req.query;
  let sql = 'SELECT * FROM tasks WHERE 1=1';
  const params = [];
  if (status) { sql += ' AND status = ?'; params.push(status); }
  if (assignee) { sql += ' AND assignee = ?'; params.push(assignee); }
  sql += ' ORDER BY created_at DESC';
  const tasks = db.prepare(sql).all(...params);
  res.json(tasks);
});

// Get task
app.get('/api/tasks/:id', (req, res) => {
  const task = db.prepare('SELECT * FROM tasks WHERE id = ?').get(req.params.id);
  if (!task) return res.status(404).json({ error: 'Not found' });
  res.json(task);
});

// Create task
app.post('/api/tasks', (req, res) => {
  const { title, description, priority, assignee } = req.body;
  if (!title) return res.status(400).json({ error: 'Title required' });
  const result = db.prepare(
    'INSERT INTO tasks (title, description, priority, assignee) VALUES (?, ?, ?, ?)'
  ).run(title, description || null, priority || 'medium', assignee || null);
  const task = db.prepare('SELECT * FROM tasks WHERE id = ?').get(result.lastInsertRowid);
  res.status(201).json(task);
});

// Update task
app.put('/api/tasks/:id', (req, res) => {
  const existing = db.prepare('SELECT * FROM tasks WHERE id = ?').get(req.params.id);
  if (!existing) return res.status(404).json({ error: 'Not found' });
  const { title, description, status, priority, assignee } = req.body;
  db.prepare(
    `UPDATE tasks SET title = ?, description = ?, status = ?, priority = ?, assignee = ?,
     updated_at = datetime('now') WHERE id = ?`
  ).run(
    title || existing.title,
    description !== undefined ? description : existing.description,
    status || existing.status,
    priority || existing.priority,
    assignee !== undefined ? assignee : existing.assignee,
    req.params.id
  );
  const task = db.prepare('SELECT * FROM tasks WHERE id = ?').get(req.params.id);
  res.json(task);
});

// Delete task
app.delete('/api/tasks/:id', (req, res) => {
  const result = db.prepare('DELETE FROM tasks WHERE id = ?').run(req.params.id);
  if (result.changes === 0) return res.status(404).json({ error: 'Not found' });
  res.status(204).send();
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => console.log(`API running on port ${PORT}`));
