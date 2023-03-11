/*
 Converts the YAML data into a CSV
*/

const fs = require('fs');
const yaml = require('js-yaml');
const dateToString = date => date.toISOString().split('T')[0];

const args = process.argv.slice(1);

// Load data
const baseFolder = __dirname + '/';
const rawData = fs.readFileSync(baseFolder + '../data.yml', { encoding: 'utf8' });
const data = yaml.load(rawData);

// Check year input
const DEFAULT_ELECTION_YEAR = 2023;
const year = /\d{4}/.test(args[1]) ? args[1] : DEFAULT_ELECTION_YEAR;
if (!data[year])
    throw `There is no data recorded for a ${year} election.`;

// Prepare output data
const PARTIES = ['ACT', 'GRN', 'INM', 'INT', 'LAB', 'MNA', 'MRI', 'NAT', 'NCP', 'NZF', 'TOP', 'UNF'];
const partyData = { date: [], org: [], n: [] };
for (const party of PARTIES)
    partyData[party] = [];

// Parse data
let count = 0;
let electionDate;
for (const poll of data[year]) {
    // Load election date
    if (poll.date.length < 2) {
        electionDate = poll.date[0] ?? new Date(`${year}-12-31`);
        continue;
    }
    // Add data 
    for (const key in poll) {
        if (poll[key]?.[0] instanceof Date) {
            poll[key] = poll[key].map(dateToString);
        }
        partyData[key].push(poll[key] || 0);
    }
    // Pad data if party not listed in poll
    count++;
    for (const key in partyData) {
        if (partyData[key].length === count)
            continue;
        partyData[key].push(NaN);
    }
}
// Fix crash when trying to plot future parties
for (const party of PARTIES) {
    if (partyData[party].length === 0)
        partyData[party] = [0];
}

// Collate parties into blocs
const BLOCS = {
    'left': ['LAB', 'GRN', 'MRI'],
    'right': ['NAT', 'ACT'],
};
BLOCS['other'] = PARTIES.filter(party => !BLOCS['left'].includes(party) && !BLOCS['right'].includes(party));
for (const bloc of ['left', 'right', 'other']) {
    partyData[bloc] = new Array(partyData.date.length).fill();
    for (let i in partyData[bloc]) {
        for (const party of BLOCS[bloc]) {
            if (partyData[party][i]) {
                partyData[bloc][i] ??= 0;
                partyData[bloc][i] += partyData[party][i];
            }
        }
    }
}

// Create CSV
let csvData = '';
const headerData = ['startDate', 'endDate', ...Object.keys(partyData).filter(key => !['date', 'org', 'n'].includes(key))]
csvData += headerData.join(',') + '\n';
csvData += ',' + dateToString(electionDate) + '\n';
for (let i = 0; i < count; i++) {
    csvData += partyData.date[i].join(',') + ',';
    const pollData = [];
    for (const party of PARTIES)
        pollData.push(partyData[party][i]);
    for (const bloc in BLOCS) {
        pollData.push(partyData[bloc][i]);
    }
    csvData += pollData.join(',') + '\n';
}
csvData = csvData.replace(/NaN/g, '');

const outFileName = baseFolder + 'local-data.csv';
try { fs.rmSync(outFileName); } catch { }
fs.writeFileSync(outFileName, csvData);
