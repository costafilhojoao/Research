# Business cycles in the State of Rio Grande do Sul: A Regional DSGE approach

## Abstract

What drives macroeconomic fluctuations in Rio Grande do Sul (RS), Brazil? We extend the fiscal block of a regional DSGE model, dividing government spending into local and central -- including public investment -- and find that the dynamics of productivity.

## Model and simulations

We use Dynare 4.6.1 and Matlab 2020a for running the DSGE model. We take advantage of Dynare's modularization and use the following .mod files for solving and simulating the model:

* [variables.mod](variables.mod): contains the endogenous and exogenous variables of the model;
* [parameters.mod](parameters.mod): contains the parameters and the calibration (see Tables 1 and 2 in Section 3.1);
* [model.mod](model.mod): contains the log-linearized equations of the model presented in Section 2;
* [ss.mod](ss.mod): calculates the steady-state of the model.
* [irf.mod](irf.mod): produces the impulse-response functions after a shock (see section )
* [simulation.mod](simulation.mod): stochastic simulation with a sequence of shocks.
* [decomposition.mod](decomposition.mod):

### Figure 1

Run [irf.mod](irf.mod) and then run [figure1.m](figure1.m).

### Figure 2

Run [irf.mod](irf.mod) and then run [figure2.m](figure2.m).

### Figure 3

Run [irf.mod](irf.mod) and then run [figure2.m](figure2.m).
