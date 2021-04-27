# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# RBC Model with home production based on Benhabib J., 
# Rogerson R. & Wright R. "Homework in macroeconomics: 
# Household production and aggregate fluctuations." (1991)
#
# Due to the expression 'log(1 - N_m[] - N_h[])' finding model 
# steady state requires setting initial values 
# for the following variables: N_h, N_m, N and N_m_d. 
# A sample set of initial values: N = 0.5, N_h = 0.25, N_m = 0.25.
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
hp <- make_model("home_production.gcn")

# set initial values
hp <- initval_var(hp, list(N = 0.5,
                           N_h = 0.25,
                           N_m = 0.25))
                           
# find and print steady-state values
hp <- steady_state(hp)
get_ss_values(hp, to_tex = TRUE)

# find and print perturbation solution
hp <- solve_pert(model = hp, loglin = TRUE)
get_pert_solution(hp, to_tex = TRUE)

# set the shock distribution parameters
hp <- set_shock_cov_mat(hp, 
                        cov_matrix = matrix(c(0.49, 0.33, 0.33, 0.49), 2, 2),
                        shock_order = c("epsilon_h", "epsilon_m"))
shock_info(hp, all = TRUE)
                              
# compute and print correlations                 
hp <- compute_model_stats(hp, ref_var = "Y")

get_model_stats(model = hp, 
                variables = c("C_m", "C_h", "Y", "I_m", "I_h",
                              "K_m", "K_h", "N_m", "N_h", "W"),
                to_tex = TRUE)

# compute and print the IRFs
hp_irf <- compute_irf(model = hp, 
                      variables = c("C_m", "C_h", "Y", "I_m", "I_h",
                                    "K_m", "K_h", "N_m", "N_h", "W"))
plot_simulation(hp_irf, to_eps = TRUE)

# print summary of the model results
summary(hp)
