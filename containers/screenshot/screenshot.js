const puppeteer = require("puppeteer");

// const url = process.argv[2];
// const sessionId = process.argv[3];
// const filename = process.argv[4];

//IMPORTANT - this code requires node >= 8.11.5

async function run(url, sessionId, filename) {
  const browser = await puppeteer.launch({
    //   executablePath: '/usr/bin/chromium-browser',
      args: ['--disable-dev-shm-usage', '--no-sandbox']
  });
  console.log("browser launched", new Date().getTime());

  const page = await browser.newPage();
  page.on("console", msg => console.log("PAGE LOG:", msg.text()));

  console.log("set cookie to ", sessionId);

  await page.setCookie({
    name: "JSESSIONID",
    value: sessionId,
    url
  });

  console.log("cookie set", new Date().getTime());

  await page.goto(url);
  await page.waitFor(2000);
  // await page.waitForSelector('.leaflet-zoom-animated');
  await page.screenshot({ path: filename });
  console.log("screenshot taken", new Date().getTime());

  await browser.close();
  console.log("done with file creation", new Date().getTime());

  return Promise.resolve("finished");
}

module.exports = run;
