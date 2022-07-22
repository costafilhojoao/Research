# The square root of all evil; The role of market power in fiscal consolidations

Working paper version available [here]().

If you do not just load the datasets we use in our paper, you should run the scripts in the following order:

1) [markups.R](markups.R)
2) [austerity.R](austerity.R)
3) [hierarquical.R](hierarquical.R)
4) [lbvar.R](lbvar.R)

## Markups

The file [markups.R](markups.R) estimates for European countries using Eurostat data. It also reproduces tables and figures...

1) Define the directory to save the figures (figures_path).
2) Run the code. For each country in the paper it will:
* Call the R packages;
* Download data directly from Eurostat API;
* List the countries in the sample;
* Create matrices for annual data on gross production and intermediate consumption by sector (NACE rev 2);
* Interpolate annual data to quarterly using the Denton-Cholette Method of temporal disaggregation of time series in Sax & Steiner (2013).
* Calculate the weights of each sectors.
* Aggregate markups of each sector.
* Create the aforesaid tables.

You can load the [dataset](markups.RData) used in the paper directly just uncomment the '#load("markups.RData")'.

## BVAR

The file [lbvar.R](lbvar.R) estimates the large BVAR following Banbura, M., Giannone, D., & Reichlin, L. (2010).
