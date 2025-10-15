function parseOrg(org) {
    if (/1 News/.test(org)) return 'COL';
    if (/Roy Morgan/.test(org)) return 'ROY';
    if (/Curia/.test(org)) return 'CUR';
    if (/Talbot/.test(org)) return 'TBM';
    if (/Freshwater/.test(org)) return 'FWS';
    if (/Reid/.test(org)) return 'REI';
    else return org;
}

function parseParty(label) {
    if (label === 'TPM') return 'MRI';
    return label;
}

function parseDateStr(dateStr) {
    const pad = x => x.toString().padStart(2, '0');
    const toMonthNum = m => [, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'].indexOf(m);
    const sameMonthRegex = /(\d+)–(\d+) (\w+) (20\d+)/;
    const diffMonthRegex = /(\d+) (\w+) *– *(\d+) (\w+) (20\d+)/;
    if (sameMonthRegex.test(dateStr)) {
        const [, d1, d2, m, y] = dateStr.match(sameMonthRegex);
        const mn = toMonthNum(m);
        return `${y}-${pad(mn)}-${pad(d1)}, ${y}-${pad(mn)}-${pad(d2)}`;
    }
    if (diffMonthRegex.test(dateStr)) {
        const [, d1, m1, d2, m2, y] = dateStr.match(diffMonthRegex);
        const mn1 = toMonthNum(m1);
        const mn2 = toMonthNum(m2);
        return `${y}-${pad(mn1)}-${pad(d1)}, ${y}-${pad(mn2)}-${pad(d2)}`;
    }
    return dateStr;
}

function parseData(label, value) {
    if (/date/i.test(label)) return ['date', `[${parseDateStr(value)}]`];
    if (/org/i.test(label)) return ['org', parseOrg(value)];
    if (/size/i.test(label)) return ['n', value.replace(/[^\d.-]/g, '')];
    if (/lead/i.test(label)) return [,];
    else return [parseParty(label), value.replace(/[^\w.]/g, '')];
}

async function scrape() {
    const inElem = document.querySelector('#in');
    const outElem = document.querySelector('#out');

    const tableContents = inElem.value.trim();
    const [headerRow, ...contentRows] = tableContents.split('\n').map(row => row.split('\t'))
        .filter(rows => rows.length > 5);

    // construct yaml output
    let output = "";
    for (const rowData of contentRows) {
        output += '- {';
        const rowArr = [];
        for (const i in rowData) {
            const [label, val] = parseData(headerRow[i], rowData[i]);
            if (label == null || val == null) continue;
            if (label === 'Others') continue;
            rowArr.push(label + ': ' + (val || '~'));
        }
        output += rowArr.join(', ');
        output += '}\n';
    }
    outElem.value = output;
}

