const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Serve static files from 'public' directory
app.use(express.static('public'));

// Health check endpoint for Kubernetes probes
app.get('/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// API endpoint for quotes
app.get('/api/quote', (req, res) => {
    const quotes = [
        "Infrastructure as Code is the key to reliable, repeatable, and scalable systems.",
        "Automation is cost cutting by tightening the corners and not cutting them.",
        "The most powerful tool we have as developers is automation.",
        "DevOps is not a goal, but a never-ending process of continual improvement."
    ];
    const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];
    res.json({ 
        quote: randomQuote,
        timestamp: new Date().toISOString(),
        pod: process.env.HOSTNAME || 'local'
    });
});

app.listen(port, () => {
    console.log(`Quote app listening on port ${port}`);
});
