const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

function getData() {
	const dataFile = path.join(__dirname, 'data.yml');
	const rawData = fs.readFileSync(dataFile);
	const data = yaml.load(rawData);
	return data;
}

module.exports = getData();
