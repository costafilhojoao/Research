# Business Cycle Accounting: What Have We Learned So Far?

Brinca, Pedro, Costa-Filho, João and Loria, Francesca

Available [here](https://onlinelibrary.wiley.com/doi/full/10.1111/joes.12581).

## Abstract

What drives recessions and expansions? Since it was introduced in 2007, there have been hundreds of business cycle accounting (BCA) exercises, a procedure aimed at identifying classes of models that hold quantitative promise to explain economic fluctuations. This paper contributes with a software -- a graphical user interface that allows practitioners to perform BCA exercises with minimal effort -- and exemplifies the procedure by studying the U.S. recessions in 1973 and 1990 and reflect upon the critiques BCA has been subject to. We look into the many equivalence theorems that the literature has produced and that allow BCA practitioners to identify the theories that are quantitatively relevant for the economic period under study. The methodological extensions that have been brought forth since BCA’s original inception are addressed as well as conclusions regarding the relative contribution of each wedge: GDP and  investment are usually driven by an efficiency wedge, hours worked are closely related to the labor wedge and, in an open economy extension, the investment wedge helps to explain country risk spreads on international bonds. Finally, larger changes in interest rates and currency crises are usually associated with the investment and/or the labor wedge.

## Preparing data for BCA exercises

Use [makeBCAdata.R](makeBCAdata.R) file for prearing your data. Most of the data is dowloaded directly in R. Consumption-tax data is loaded from the [tax.xlsx](tax.xlsx) file. The script will generate the 'data.mat'file. After that, type and run the following commands in Matlab:

``` matlab data
load('data.mat')
mled  = [t,ypc,xpc,hpc/1300,gpc,iP]
save('data.dat','mled','-ascii')
````
This creates a Matlab data file to be uploaded in the BCAppIt!.

## Business Cycles Accounting

### The accounting procedure

Download the BCAppIt! from https://pedrobrinca.pt/software/bcappit-2/.

Then, use the data from  Matlab data file ('data.dat') created in the previous step. See the appendix of the paper for the user guide. The results are stored in the [BCAresults.mat](BCAresults.mat) file. 

After running the simulations, the graphs from the paper were made with the [wedges.R](wedges.R) script.

### The drivers of the recessions and expansions

See the Excel file [recessions and expansions.xlsx](https://github.com/costafilhojoao/Research/blob/main/Business%20Cycle%20Accounting%3B%20What%20have%20we%20learned%20so%20far/recessions%20and%20expansions.xlsx) for the average relative contribution of each wedge in recessions and expansions in the US.
