/*
 Converts the YAML data into a CSV
*/

const ELECTION = 2023; // the election to poll for

const fs = require('fs');
const yaml = require('js-yaml');

Date.prototype.toString = function () {
    return this.toISOString().split('T')[0];
}

const baseFolder = __dirname + '/';
const rawData = fs.readFileSync(baseFolder + '../data.yml', { encoding: 'utf8' });
const data = yaml.load(rawData);

let csvData = '';
let headerKeys = new Set();

for (const entry of data[ELECTION]) {
    if (entry.date.length < 2) continue;
    for (const key in entry) headerKeys.add(key);
    csvData += Object.values(entry) + '\n';
}

headerKeys.delete('date');
headerKeys = new Set(['startDate', 'endDate', 'org', ...headerKeys]);
csvData = `${ELECTION}-12-31,${ELECTION}-12-31`;

const output = [...headerKeys] + '\n' + csvData;
const outFileName = baseFolder + 'local-data.csv';
try { fs.rmSync(outFileName); } catch { }
fs.writeFileSync(outFileName, output);
