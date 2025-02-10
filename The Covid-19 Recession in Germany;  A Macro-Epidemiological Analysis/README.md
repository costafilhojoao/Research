# Accounting for Mexican Business Cycles

[Brinca, P., & Costa Filho, J. (2023). Accounting for Mexican business cycles. Macroeconomic Dynamics, 1-23. doi:10.1017/S1365100523000159](https://www.cambridge.org/core/journals/macroeconomic-dynamics/article/abs/accounting-for-mexican-business-cycles/82BF7D4AA3DB2A83318473EB81E52C2E)

 ## Abstract
 
The Mexican economy experienced two large crises: in 1995 and in 2008. The dynamics and origins of the episodes are very different; nevertheless, is there a common underlying mechanism? First, by applying the Business Cycle Accounting method, we find that the efficiency wedge is the main driver of output during both episodes. We present an equivalence between the neoclassical growth model with distortions and a small open economy with imported intermediate goods inputs, in which relative price changes manifest themselves as changes on the efficiency wedge. This result proposes a solution for the theoretical puzzle regarding the relationship between terms of trade shocks and productivity. Finally, the model is able to reproduce both the intensities and velocities of the crises in Mexico.

## Business Cycle Accounting

The [BCA](BCA) folder contains the scripts for the Business Cycle Accounting.

1) Use [makeBCAdata.R](BCA/makeBCAdata.R) to prepare the data and create the .mat file. If you do not want to load the data from OECD, you can just run

``` R load
load("BCAData.RData")
```
and continue from there. The setwd() commands are not necessary (you should actually erase them before running the code), I just used them since I sometimes work on different projects at the same time and I prefere saving the figures in different folders (I acknowledge that this is probably not the best coding practice).

After that, type and run the following commands in Matlab:

``` matlab data
load('data.mat')
mled  = [t,ypc,xpc,hpc/1300,gpc,iP]
save('data.dat','mled','-ascii')
````
This creates a Matlab data file to be uploaded in the [BCAppIt!](https://pedrobrinca.pt/software/bcappit-2/). Moreover, the script [makeBCAdata.R](BCA/makeBCAdata.R) is also used to produce **figures 1 and 5** of the paper.

2) Download the BCAppIt! from https://pedrobrinca.pt/software/bcappit-2/. Then, use the data from  Matlab data file ('data.dat') created in the previous step. 

If you need any instruction on how to use [BCAppIt!](https://pedrobrinca.pt/software/bcappit-2/), see my other paper [Business Cycle Accounting: What Have We Learned So Far?](https://github.com/costafilhojoao/Research/tree/main/Business%20Cycle%20Accounting%3B%20What%20have%20we%20learned%20so%20far), especially the appendix of the paper with the user guide (the appendix is dowloaded along with the rest of the  [BCAppIt!](https://pedrobrinca.pt/software/bcappit-2/) files). The results are stored in the [BCAresults.mat](BCAresults.mat) file. 

After running the BCA, save the results into a .mat file (I used 'BCAresults.mat'). The data is used in the [wedges.R](BCA/wedges.R) script for producing **figures 2, 3, 4, and 10**. Alternatively, you can just run

``` R load2
load("wedges.RData")
```
without running the 'results <- readMat( "BCAresults.mat" )' command and continue from there. The previous remarks on the setwd() commands also apply.

### Investment and labor frictions

**Figure 9** of the paper is produced with the [investment.R](BCA/investment.R) script that uses both 'BCAData.RData' and 'wedges.RData'. Same as before, instead of loading data from the Economic Outlook No 110 - December 2021 from the former and estimated $\tau_{x,t}$ from the BCA exercise from the latter, you can just run

``` R load3
load("investment.RData")
```
and continue from there. The previous remarks on the setwd() commands also apply.

## Detailed derivation of the model

You can find a detailed derivation of the model (the economy, the dynamic system, the steady state, and the log-linearized functions) in the online [appendix](appendix.pdf).

## Structural interpretation of the wedges - the DSGE model

### Data

Use [makeDSGEdata.R](DSGE/makeDSGEdata.R) for producing **figures 6 and 7**.

* Data for the imported intermediate goods comes from the [WITS-Product-MEX.xlsx](DSGE/WITS-Product-MEX.xlsx) (for Mexico) and [WITS-Product-MEX.xlsx](DSGE/WITS-Product-USA.xlsx) (for the US) files.
* Data for the real effective exchange rate comes from the [reer.xlsx](DSGE/reer.xlsx.xlsx) file. Alternatively, you can just run

``` R load3
load("DSGEData.RData")
``` 
and continue from there. The previous remarks on the setwd() commands also apply.

### Calibration

The script [calibration.R](DSGE/calibration.R) uses data from the [Penn World Table](https://www.rug.nl/ggdc/productivity/pwt/) (version 10.0), the World Development Indicators, and the data for the imported intermediate goods share of GDP (%) to calculate the parameters used in the quantitative exercises presented in Section 3.3 of the paper. See Section A.3 of the appendix for more details on the data sources.

### Simulation

I use [Dynare]([DSGE/WITS-Product-MEX.xlsx](https://www.dynare.org/)) for simulating the model. Run the [mex.mod](DSGE/mex.mod) mod file in Matlab with the

``` matlab dynare
dynare mex
```
command and you will have the solution and simulation of the model, as well as the graphs presented in **figures 8 and 11** of the paper.
