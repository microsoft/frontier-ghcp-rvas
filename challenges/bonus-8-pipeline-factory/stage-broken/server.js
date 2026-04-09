// Staging deployment of the TaskBoard API
// Copied from api-service and configured for staging environment

const express = require('express');
const cors = require('cors');
const Database = require('better-sqlite3');
const path = require('path');

require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const dbPath = process.env.DB_PATH || '/opt/taskboard/data/tasks.db';
const db = new Database(dbPath);

app.get('/health', (req, res) => {
  res.json({ status: 'ok', version: '1.0.0' });
});

app.get('/api/tasks', (req, res) => {
  try {
    const tasks = db.prepare('SELECT * FROM tasks ORDER BY created_at DESC').all();
    res.json(tasks);
  } catch (err) {
    res.json([]);
  }
});

app.post('/api/tasks', (req, res) => {
  const { title, description } = req.body;
  const result = db.prepare('INSERT INTO tasks (title, description) VALUES (?, ?)').run(title, description);
  res.json({ id: result.lastInsertRowid });
});

const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Staging API on port ${PORT}`);
});
