# Business Cycle Accounting: What Have We Learned So Far?

Brinca, Pedro, Costa-Filho, João and Loria, Francesca

Latest version of the working paper is available [here](https://www.joaocostafilho.com/research).

## Abstract

What drives recessions and expansions? Since it was introduced in 2007, there have been hundreds of business cycle accounting (BCA) exercises, a procedure aimed at identifying classes of models that hold quantitative promise to explain economic fluctuations. This paper contributes with a software -- a graphical user interface that allows practitioners to perform BCA exercises with minimal effort -- and exemplifies the procedure by studying the U.S. recessions in 1973 and 1990 and reflect upon the critiques BCA has been subject to. We look into the many equivalence theorems that the literature has produced and that allow BCA practitioners to identify the theories that are quantitatively relevant for the economic period under study. The methodological extensions that have been brought forth since BCA’s original inception are addressed as well as conclusions regarding the relative contribution of each wedge: GDP and  investment are usually driven by an efficiency wedge, hours worked are closely related to the labor wedge and, in an open economy extension, the investment wedge helps to explain country risk spreads on international bonds. Finally, larger changes in interest rates and currency crises are usually associated with the investment and/or the labor wedge.

## Preparing data for BCA exercises

Use [makeBCAdata.R](makeBCAdata.R) file for prearing your data. the script will generate the 'data.mat'file. After that, type the following commands in Matlab:

load('data.mat')
mled  = [t,ypc,xpc,hpc/1300,gpc,iP];
save('data.dat','mled','-ascii');

This creates a Matlab data file.

## Business Cycles Accounting

### The accounting procedure

Download the BCAAppIt! from https://pedrobrinca.pt/software/bcappit-2/ or https://francescaloria.wixsite.com/francescaloria/bcappit.

Then, use the data from  Matlab data file ('data.dat') created in the previous step. See the appendix of the paper for the user guide. The results are store in the [BCAresults.mat](BCAresults.mat) file. 

After running the simulations, the graphs were made with the [wedges.R](wedges.R) script.

### The drivers of the recessions and expansions

See the excel file [recessions and expansions.xlsx](recessions and expansions.xlsx) for the average relative contribution of each wedge in recessions and expansions in the US.
