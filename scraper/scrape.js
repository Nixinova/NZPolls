function parseOrg(org) {
    if (/1 News/.test(org)) return 'COL';
    if (/Roy Morgan/.test(org)) return 'ROY';
    if (/Curia/.test(org)) return 'CUR';
    if (/Talbot/.test(org)) return 'TBM';
    else return org;
}

function parseData(label, value) {
    if (/date/i.test(label)) return ['date', `[${value}]`];
    if (/org/i.test(label)) return ['org', parseOrg(value)];
    if (/size/i.test(label)) return ['n', value.replace(/[^\d.-]/g, '')];
    if (/lead/i.test(label)) return [,];
    else return [label, value.replace(/\W/g, '')];
}

async function scrape() {
    const inElem = document.querySelector('#in');
    const outElem = document.querySelector('#out');

    const tableContents = inElem.value.trim();
    const [headerRow, ...contentRows] = tableContents.split('\n').map(row => row.split('\t'))
        .filter(rows => rows.length > 5);
    const headersObj = headerRow.map(header => ({ [header]: [] })); // turn array into keyset

    // construct yaml output
    let output = "";
    for (const rowData of contentRows) {
        output += '- {';
        const rowArr = [];
        for (const i in rowData) {
            const [label, val] = parseData(headerRow[i], rowData[i]);
            if (label == null || val == null) continue;
            rowArr.push(label + ': ' + (val || '~'));
        }
        output += rowArr.join(', ');
        output += '}\n';
    }
    outElem.value = output;
}
