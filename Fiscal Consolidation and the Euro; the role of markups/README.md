# Fiscal Consolidation and the Euro Crisis: the role of markups

Working paper version.

## Markups

The file [markups.R](markups.R) estimates for European countries using Eurostat data. It also reproduces tables and figures...

1) Define the working directory (working_path) and directory to save the figures (figures_path).
2) Run the code. For each country in the paper it will:
* Call the R packages;
* Download data directly from Eurostat API;
* List the countries in the sample;
* Create matrices for annual data on gross production and intermediate consumption by sector (NACE rev 2);
* Interpolate annual data to quarterly using the Denton-Cholette Method of temporal disaggregation of time series in Sax & Steiner (2013).
* Calculate the weights of each sectors.
* Aggregate markups of each sector.
* Create the aforesaid tables.

## BVAR

The file [lbvar.R](lbvar.R) estimates the large BVAR following Banbura, M., Giannone, D., & Reichlin, L. (2010).
