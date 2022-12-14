# Accounting for Mexican Business Cycles

Brinca, Pedro and Costa-Filho, João

 ## Abstract
 
The Mexican economy experienced two large crises: in 1995 and in 2008. The dynamics and origins of the episodes are very different, nevertheless, is there a common underlying mechanism? First, by applying the Business Cycle Accounting method, we find that the efficiency wedge is the main driver of output during each episode. We present an equivalence between the neoclassical growth model with distortions and a small open-economy with imported intermediates goods inputs, in which a real exchange rate depreciation manifest itself as a decrease in the efficiency wedge. This result proposes a solution for the theoretical puzzle regarding the relationship between terms of trade shocks and productivity. Finally, the model is able to reproduce both the intensities and velocities of the crises in Mexico.

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
This creates a Matlab data file to be uploaded in the [BCAppIt!](https://pedrobrinca.pt/software/bcappit-2/). Moreover, the script is also used to produce Figures 1 and 8.

2) Download the BCAppIt! from https://pedrobrinca.pt/software/bcappit-2/. Then, use the data from  Matlab data file ('data.dat') created in the previous step. See the appendix of the paper for the user guide. The results are stored in the [BCAresults.mat](BCAresults.mat) file. 

After running the simulations, the graphs from the paper were made with the [wedges.R](wedges.R) script.

## Detailed derivation of the model
