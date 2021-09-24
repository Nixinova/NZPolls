# NZPolls Graphing
Political polling data and R code to generate charts for New Zealand election polling data.

## Prerequisites
Data CSV generation is written in JavaScript for use by Node.
The graphing script is written in the R programming language.

- [Node.js](https://nodejs.org)
- [R programming language](https://cran.rstudio.com)
- [RStudio](https://www.rstudio.com/products/rstudio/download/), a development environment

## Generate polling data
1. Open your CLI and `cd` into `[...]/nzpolls/graphing`.
2. Run `npm install` to install the necessary dependencies.
3. Run `node . 2023` (or any other election year) to generate the CSV data file.

## Generate chart
1. Open RStudio
2. Open Tools and click "Install Packages"
3. Install the ggplot2 package
4. Open `graphing.r` in RStudio and adjust the working directory to `[...]/nzpolls/graphing`.
5. Select all the code in polling-graph.r and press the Run button.
6. Export the generated charts as SVG by opening the "Export" option in the plotting window and selecting "Save as image".
