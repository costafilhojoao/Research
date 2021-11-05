#### Fiscal Consolidation and the Euro Crisis: the role of markups
#### 
#### Corresponding author: João Costa-Filho
#### E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao

#### Steady State ####

library(gEcon)
library(gEcon.estimation)

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

model <- make_model("model.gcn")

model <- set_free_par( model, free_par = list( 

  sigma = 2.9,                              # price-elasticity of demand 
  alpha = 1/3,                              # 1 - alpha: share of labor in the production
  phi   = 0.75,                             # future demand sensitivity to current sales
  eta   = 0.5,                              # demand ``loss"
  rho   = 0.09,                               # discount rate
  gamma = 2,                                # elasticity of intertemporal substitution
  omega = 1.455,                            # exponent of labor in utility function 
  zetaA = 0.9,                              # technology process autoregressive weight
  zetaG = 0.9,                              # government spending process autoregressive weight
  zetai = 0.9,                              # 
  zetaX = 0.9, 
  psi   = 1.470967536,                      # demand
  kappa = 0.007

    ), warnings = FALSE 
  )

model <- steady_state( model )

get_residuals(model)

list_eq(model, eq_idx = c(5, 12, 13, 16, 21))

model <- solve_pert( model, loglin = TRUE)

#### IRFs ####

compute_irf(model, variables = NULL, shocks = NULL,
            sim_length = 40, cholesky = TRUE)