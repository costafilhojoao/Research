# Retrieving the state-space representation from Dynare

João Costa-Filho

Latest version of the working paper is available [here](https://www.joaocostafilho.com/research).

## Abstract

How is it possible to recover the state-space representation after solving a DSGE model in Dynare? This note presents how to simulate impulse-response functions and the dynamics of a system after a series of exogenous shocks after solving the model with Dynare. I present a step-by-step framework and apply it to a simple Real Business Cycles model and a basic New Keynesian model. Nevertheless, the same structure can be used in large DSGE models.

## Simulations

Make sure both the [RBC.mod](RBC.mod) and the [NK.mod](NK.mod) files are in the working directory. 

### RBC simulations (IRF and stochastic simulations)

Run [simulations.m](simulations.m) file for the two examples in the paper.

### NK simulations (stochastic simulations)

Run [simulations_NK.m](simulations_NK.m) file for the example in the paper.



Note: I am still trying to figure out how to do it using [Google Collab](https://colab.research.google.com/). If you have any thoughts on the matter, please contact me (I have started a Jupyter notebook entitled [RBC.ipynb](RBC.ipynb), but it needs to be corrected).
