const express = require('express');
const next = require('next');
const path = require('path');

const dev = process.env.NODE_ENV !== 'production';
const app = next({ dev });
const handle = app.getRequestHandler();

app.prepare().then(() => {
  const server = express();

  server.get('/2.0.0/_next/static/:path(*)', (req, res) => {
    const actualPath = path.join(__dirname, '2.0.0', '.next', 'static', req.params.path);
    console.log("Attempting to serve:", actualPath);
    res.sendFile(actualPath);
  });

  server.all('*', (req, res) => handle(req, res));

  server.listen(3000, (err) => {
    if (err) throw err;
    console.log('> Ready on http://localhost:3000');
  });
});
