// app/index.js

const express = require('express')
const app = express()
const port = 8086
const host = "0.0.0.0"

const commondHandler = require('./CommonHandler')

/* Serve Static Files */
app.use(express.static('public'));

app.get('/simple', (request, response) => {
	const jsonData = Math.floor(Math.random() * 1000);
	response.setHeader('Content-Type', 'text/plain');
	response.status(200).send(JSON.stringify(jsonData));
})

app.get('/json', (request, response) => {
	const jsonData = commondHandler.makeJSON();
	response.setHeader('Content-Type', 'application/json');
	response.send(JSON.stringify(jsonData));
})

app.listen(port, host, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on ${host}:${port}`)
})
