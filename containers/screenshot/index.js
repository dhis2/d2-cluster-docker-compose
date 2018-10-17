const express = require('express');
const cookieParser = require('cookie-parser');

const screenshot = require('./screenshot');

const app = express()
app.use(cookieParser());

app.get('/', (req, res) => {
  const sessionId = req.cookies.JSESSIONID;
  res.send(`Your session cookie is ${sessionId}`);
});

app.get('/screenshot', (req, res) => {
  console.log('take the screenshot');

  //sessionId and url must be sent from the requesting service
  const sessionId = req.cookies.JSESSIONID;
  const url = 'http://core:8080/dhis-web-maps/?id=zDP78aJU8nX';

  const timestamp = new Date().getTime();
  const filename = `/data/screenshots/dhis-${timestamp}.png`;

  // shell.exec(`node ../screenshot-poc/index.js ${url} ${sessionId} ${filename}`);
  // res.download(filename);
  screenshot(url, sessionId, filename)
    .then(msg => {
      console.log(msg);
      res.download(filename); // Set disposition and send it.
    });
});

console.log('Starting...');
app.listen(9000, () => console.log('Screenshot service listening on port 9000!'));
