# Documentation

> [data.yml](data.yml)

## Data format

This repository's data is stored in a YAML file.
Each election has its own root-level array sorted in reverse chronological order, with the election proper as the first item.

### Annotated example
```js
{ // root
	// ... other years
	2017: [
		// First item: data relating to the election itself
		{
			date: [
				// only one item: the date of the election itself
				new Date('2017-09-23')
			],
			// no org
			NAT: 44.4, LAB: 36.9, GRN: 6.3, NZF: 7.2, MRI: 1.2, ACT: 0.5, UNF: 0.1, NCP: 0.2, MNA: 0.1, TOP: 2.4 // data for each party
		},
		// Remaining items: data for each public poll conducted, in reverse chronological order
		{
			date: [
				new Date('2017-09-15'), // start date
				new Date('2017-09-19')  // end date
			],
			org: 'COL',
			NAT: 46, LAB: 37, GRN: 8, NZF: 4.9, MRI: 0.5, ACT: 0.3, TOP: 2.3 // data for each party
		},
		// ... remaining polls
	],
	// ... other years
}
```

### Party IDs

- ACT: ACT
- GRN: Green
- LAB: Labour
- MRI: Maori
- MNA: Mana
- NAT: National
- NCP: New Conservative
- NZF: NZ First
- TOP: Opportunities
- UNF: United Future

### Organisation IDs
- BAU: Bauer Media
- COL: Colman Brunton (1 News)
- DGI: DigiPoll (NZ Herald)
- DYN: Dynata (Newsroom)
- REI: Reid Research (Newshub)
- ROY: Roy Morgan
- YGV: YouGov (Stuff)

## Version format

Versioning format of the [npm package](https://www.npmjs.com/package/nzpolls) is `<breaking>.<compatible>.<date>`.
