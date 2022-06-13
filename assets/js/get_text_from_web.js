//how to run this script:
//node get_text_from_web.js
//create a template to get text from web:
//https://www.w3schools.com/html/html_tables.asp
//
//



//create script to get text from web:
//https://www.w3schools.com/html/html_tables.asp

const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');
const url = 'https://www.w3schools.com/html/html_tables.asp';
const getTextFromWeb = async () => {
    const browser = await puppeteer.launch({
        headless: false,
        defaultViewport: null,
        args: ['--start-maximized']
    });
    const page = await browser.newPage();
    await page.goto(url);
    await page.waitForSelector('table');
    const text = await page.evaluate(() => {
        const table = document.querySelector('table');
        return table.innerText;
    });
    await browser.close();
    return text;
}
//run
getTextFromWeb().then(text => {
    console.log(text);
});