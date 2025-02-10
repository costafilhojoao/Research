# The Covid-19 Recession in Germany: A Macropidemiological Analysis

[Krause, Willi & Costa, Luís & Costa Filho, João Ricardo, 2023. "The Covid-19 Recession in Germany: A Macropidemiological Analysis," Working Papers REM 2023/0290, ISEG - Lisbon School of Economics and Management, REM, Universidade de Lisboa.](https://ideas.repec.org/p/ise/remwps/wp02902023.html)

 ## Abstract
 
What is the contribution of containment policies to output fluctuations in Germany during the COVID-19 pandemic? We extend a macro-epidemiological model based on the evidence that efficiency and labor wedges are the key distortions in the neoclassical growth model that account for the GDP dynamics during the period. We find that the consumption and labor-supply effects of containment policies and the endogenous responses of households to pandemic-associated health risks can account for almost all weekly dynamics of output in Germany between the first quarter of 2020 and the second quarter of 2021. The containment policies are found to be responsible for especially large output losses during the pandemic, but the endogenous household responses appear to play an important complementary role. We simulate a counterfactual, laissez-faire type of response to the pandemic and find that not only would it not have avoided a sizeable recession either, but it would also lead to substantially higher losses in human life and stress on the German health service.

## Mobility in Germany

* Figure 1: Consumption and Labor Mobility in Germany: January to December 2020

* Figure 2: Social Contacts in Germany: January to December 2020

## Business Cycle Accounting Analysis

The [BCA](BCA) folder contains the scripts for the Business Cycle Accounting described in the Appendix of the paper.

In order to replicate our BCA exercise, please download the BCAppIt! from [https://pedrobrinca.pt/software/bcappit-2/](https://pedrobrinca.pt/software/bcappit-2/). Then, upload the German data ([BCA_Ger.dat](https://github.com/costafilhojoao/Research/blob/main/The%20Covid-19%20Recession%20in%20Germany%3B%20%20A%20Macro-Epidemiological%20Analysis/BCA/BCA_Ger.dat)). If you need any instruction on how to use [BCAppIt!](https://pedrobrinca.pt/software/bcappit-2/), see my other paper [Business Cycle Accounting: What Have We Learned So Far?](https://onlinelibrary.wiley.com/doi/abs/10.1111/joes.12581), especially the appendix of the paper with the user guide (the appendix is downloaded along with the rest of the  [BCAppIt!](https://pedrobrinca.pt/software/bcappit-2/) files). 

Our results are stored in the [bcaresults.mat](https://github.com/costafilhojoao/Research/blob/main/The%20Covid-19%20Recession%20in%20Germany%3B%20%20A%20Macro-Epidemiological%20Analysis/BCA/bcaresults.mat) file. 

## Quantitative Analysis

In order replicate our quantitative analysis, first you need to solve the macro-epidemiological model. You will find the model's files within the [Model](model) folder. Please run the [solve.mod](https://github.com/costafilhojoao/Research/blob/main/The%20Covid-19%20Recession%20in%20Germany%3B%20%20A%20Macro-Epidemiological%20Analysis/Model/solve.mod) file in Dynare. Before you do that, make sure the other '.mod' files are in the same directory. We have used Matlab R2021a and DYNARE 4.6.1.. 

For the remaining figures of the paper, please follow the steps below:

* Figure 3: Lockdown Stringency and Daily Infections

* Figure 4: Model Containment Dynamics

* Figure 5: Calibration of Infection Risk by Activity

* Figure 6: Model implied weekly GDP growth vs OECD Weekly Tracker

* Figure 7: Deaths and Infections

* Figure 8: Model implied vs Data-implied Quarterly Growth Rates

* Figure 9: Quarterly Model implied Growth Rates without Lockdowns vs. actual Growth Rates

* Figure 10: Model implied Deaths and Infections: Lockdown vs No-Lockdown
