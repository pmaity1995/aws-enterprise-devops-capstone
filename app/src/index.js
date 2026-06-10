const express = require('express');

const app = express();

app.get('/', (req, res) => {
  res.send('AWS Enterprise DevOps Capstone');
});

module.exports = app;