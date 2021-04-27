# Generated on 2019-12-09 14:31:17 by gEcon ver. 1.2.0 (2019-09-08)
# http://gecon.r-forge.r-project.org/

# Model name: home_production

# info
info__ <- c("home_production", "C:/Users/jcfil/Documents/2020 1 Bayesian Econometrics/Aulas/Aula 11 - Modelos DSGE/home_production.gcn", "2019-12-09 14:31:17", "false")

# index sets
index_sets__ <- list()

# variables
variables__ <- c("r",
                 "C_m",
                 "C_h",
                 "I",
                 "I_m",
                 "I_h",
                 "K",
                 "K_m",
                 "K_h",
                 "N",
                 "N_m",
                 "N_h",
                 "U",
                 "W",
                 "Y",
                 "Z_h",
                 "Z_m")

variables_tex__ <- c("r",
                     "C^{\\mathrm{m}}",
                     "C^{\\mathrm{h}}",
                     "I",
                     "I^{\\mathrm{m}}",
                     "I^{\\mathrm{h}}",
                     "K",
                     "K^{\\mathrm{m}}",
                     "K^{\\mathrm{h}}",
                     "N",
                     "N^{\\mathrm{m}}",
                     "N^{\\mathrm{h}}",
                     "U",
                     "W",
                     "Y",
                     "Z^{\\mathrm{h}}",
                     "Z^{\\mathrm{m}}")

# shocks
shocks__ <- c("epsilon_h",
              "epsilon_m")

shocks_tex__ <- c("\\epsilon^{\\mathrm{h}}",
                  "\\epsilon^{\\mathrm{m}}")

# parameters
parameters__ <- c("a",
                  "alpha",
                  "b",
                  "beta",
                  "delta",
                  "e",
                  "phi",
                  "psi",
                  "theta",
                  "Gamma")

parameters_tex__ <- c("a",
                     "\\alpha",
                     "b",
                     "\\beta",
                     "\\delta",
                     "e",
                     "\\phi",
                     "\\psi",
                     "\\theta",
                     "\\Gamma")

# free parameters
parameters_free__ <- c("a",
                       "alpha",
                       "b",
                       "beta",
                       "delta",
                       "e",
                       "phi",
                       "psi",
                       "theta",
                       "Gamma")

# free parameters' values
parameters_free_val__ <- c(0.337,
                           0.36,
                           0.63,
                           0.99,
                           0.025,
                           0.8,
                           0.95,
                           0.95,
                           0.08,
                           1)

# equations
equations__ <- c("-r[] + alpha * Gamma * Z_m[] * K_m[-1]^(-1 + alpha) * N_m[]^(1 - alpha) = 0",
                 "-C_h[] + Gamma * Z_h[] * K_h[-1]^theta * N_h[]^(1 - theta) = 0",
                 "-W[] + Gamma * Z_m[] * (1 - alpha) * K_m[-1]^alpha * N_m[]^(-alpha) = 0",
                 "-Y[] + Gamma * Z_m[] * K_m[-1]^alpha * N_m[]^(1 - alpha) = 0",
                 "-Z_h[] + exp(epsilon_h[] + psi * log(Z_h[-1])) = 0",
                 "-Z_m[] + exp(epsilon_m[] + phi * log(Z_m[-1])) = 0",
                 "beta * (a * b * E[][r[1] * (a * C_m[1]^e + (1 - a) * C_h[1]^e)^-1 * C_m[1]^(-1 + e)] + a * b * (1 - delta) * E[][(a * C_m[1]^e + (1 - a) * C_h[1]^e)^-1 * C_m[1]^(-1 + e)]) - a * b * (a * C_m[]^e + (1 - a) * C_h[]^e)^-1 * C_m[]^(-1 + e) = 0",
                 "beta * (a * b * (1 - delta) * E[][(a * C_m[1]^e + (1 - a) * C_h[1]^e)^-1 * C_m[1]^(-1 + e)] + b * theta * Gamma * (1 - a) * K_h[]^(-1 + theta) * E[][Z_h[1] * (a * C_m[1]^e + (1 - a) * C_h[1]^e)^-1 * C_h[1]^(-1 + e) * N_h[1]^(1 - theta)]) - a * b * (a * C_m[]^e + (1 - a) * C_h[]^e)^-1 * C_m[]^(-1 + e) = 0",
                 "-(1 - b) * (1 - N_m[] - N_h[])^-1 + a * b * W[] * (a * C_m[]^e + (1 - a) * C_h[]^e)^-1 * C_m[]^(-1 + e) = 0",
                 "-(1 - b) * (1 - N_m[] - N_h[])^-1 + b * Gamma * Z_h[] * (1 - a) * (1 - theta) * (a * C_m[]^e + (1 - a) * C_h[]^e)^-1 * K_h[-1]^theta * C_h[]^(-1 + e) * N_h[]^(-theta) = 0",
                 "-I[] + I_m[] + I_h[] = 0",
                 "I_m[] - K_m[] + K_m[-1] * (1 - delta) = 0",
                 "I_h[] - K_h[] + K_h[-1] * (1 - delta) = 0",
                 "-K[] + K_m[] + K_h[] = 0",
                 "-N[] + N_m[] + N_h[] = 0",
                 "-C_m[] - I_m[] - I_h[] + Y[] = 0",
                 "U[] - beta * E[][U[1]] - log(1 - N_m[] - N_h[]) * (1 - b) - b * e^-1 * log(a * C_m[]^e + (1 - a) * C_h[]^e) = 0")

# calibrating equations
calibr_equations__ <- character(0)

# variables / equations map
vareqmap__ <- sparseMatrix(i = c(1, 1, 1, 1, 2, 2, 2, 2, 3, 3,
                                 3, 3, 4, 4, 4, 4, 5, 6, 7, 7,
                                 7, 8, 8, 8, 8, 8, 9, 9, 9, 9,
                                 9, 10, 10, 10, 10, 10, 10, 11, 11, 11,
                                 12, 12, 13, 13, 14, 14, 14, 15, 15, 15,
                                 16, 16, 16, 16, 17, 17, 17, 17, 17),
                           j = c(1, 8, 11, 17, 3, 9, 12, 16, 8, 11,
                                 14, 17, 8, 11, 15, 17, 16, 17, 1, 2,
                                 3, 2, 3, 9, 12, 16, 2, 3, 11, 12,
                                 14, 2, 3, 9, 11, 12, 16, 4, 5, 6,
                                 5, 8, 6, 9, 7, 8, 9, 10, 11, 12,
                                 2, 5, 6, 15, 2, 3, 11, 12, 13),
                           x = c(2, 1, 2, 2, 2, 1, 2, 2, 1, 2,
                                 2, 2, 1, 2, 2, 2, 3, 3, 4, 6,
                                 6, 6, 6, 2, 4, 4, 2, 2, 2, 2,
                                 2, 2, 2, 1, 2, 2, 2, 2, 2, 2,
                                 2, 3, 2, 3, 2, 2, 2, 2, 2, 2,
                                 2, 2, 2, 2, 2, 2, 2, 2, 6),
                           dims = c(17, 17))

# variables / calibrating equations map
varcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 17))

# calibrated parameters / equations map
calibrpareqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(17, 0))

# calibrated parameters / calibrating equations map
calibrparcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 0))

# free parameters / equations map
freepareqmap__ <- sparseMatrix(i = c(1, 1, 2, 2, 3, 3, 4, 4, 5, 6,
                                     7, 7, 7, 7, 7, 8, 8, 8, 8, 8,
                                     8, 8, 9, 9, 9, 10, 10, 10, 10, 10,
                                     12, 13, 17, 17, 17, 17),
                               j = c(2, 10, 9, 10, 2, 10, 2, 10, 8, 7,
                                     1, 3, 4, 5, 6, 1, 3, 4, 5, 6,
                                     9, 10, 1, 3, 6, 1, 3, 6, 9, 10,
                                     5, 5, 1, 3, 4, 6),
                               x = rep(1, 36), dims = c(17, 10))

# free parameters / calibrating equations map
freeparcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 10))

# shocks / equations map
shockeqmap__ <- sparseMatrix(i = c(5, 6),
                             j = c(1, 2),
                             x = rep(1, 2), dims = c(17, 2))

# steady state equations
ss_eq__ <- function(v, pc, pf)
{
    r <- numeric(17)
    r[1] = -v[1] + pf[2] * pf[10] * v[17] * v[8]^(-1 + pf[2]) * v[11]^(1 - pf[2])
    r[2] = -v[3] + pf[10] * v[16] * v[9]^pf[9] * v[12]^(1 - pf[9])
    r[3] = -v[14] + pf[10] * v[17] * (1 - pf[2]) * v[8]^pf[2] * v[11]^(-pf[2])
    r[4] = -v[15] + pf[10] * v[17] * v[8]^pf[2] * v[11]^(1 - pf[2])
    r[5] = -v[16] + exp(pf[8] * log(v[16]))
    r[6] = -v[17] + exp(pf[7] * log(v[17]))
    r[7] = pf[4] * (pf[1] * pf[3] * v[1] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6]) + pf[1] * pf[3] * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])) - pf[1] * pf[3] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    r[8] = pf[4] * (pf[1] * pf[3] * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6]) + pf[3] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9])) - pf[1] * pf[3] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    r[9] = -(1 - pf[3]) * (1 - v[11] - v[12])^-1 + pf[1] * pf[3] * v[14] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    r[10] = -(1 - pf[3]) * (1 - v[11] - v[12])^-1 + pf[3] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^pf[9] * v[12]^(-pf[9])
    r[11] = -v[4] + v[5] + v[6]
    r[12] = v[5] - v[8] + v[8] * (1 - pf[5])
    r[13] = v[6] - v[9] + v[9] * (1 - pf[5])
    r[14] = -v[7] + v[8] + v[9]
    r[15] = -v[10] + v[11] + v[12]
    r[16] = -v[2] - v[5] - v[6] + v[15]
    r[17] = v[13] - pf[4] * v[13] - log(1 - v[11] - v[12]) * (1 - pf[3]) - pf[3] * pf[6]^-1 * log(pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])

    return(r)
}

# calibrating equations
calibr_eq__ <- function(v, pc, pf)
{
    r <- numeric(0)

    return(r)
}

# steady state and calibrating equations Jacobian
ss_calibr_eq_jacob__ <- function(v, pc, pf)
{
    r <- numeric(0)
    jac <- numeric(59)
    jac[1] = -1
    jac[2] = pf[2] * pf[10] * v[17] * (-1 + pf[2]) * v[8]^(-2 + pf[2]) * v[11]^(1 - pf[2])
    jac[3] = pf[2] * pf[10] * v[17] * (1 - pf[2]) * v[8]^(-1 + pf[2]) * v[11]^(-pf[2])
    jac[4] = pf[2] * pf[10] * v[8]^(-1 + pf[2]) * v[11]^(1 - pf[2])
    jac[5] = -1
    jac[6] = pf[9] * pf[10] * v[16] * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9])
    jac[7] = pf[10] * v[16] * (1 - pf[9]) * v[9]^pf[9] * v[12]^(-pf[9])
    jac[8] = pf[10] * v[9]^pf[9] * v[12]^(1 - pf[9])
    jac[9] = pf[2] * pf[10] * v[17] * (1 - pf[2]) * v[8]^(-1 + pf[2]) * v[11]^(-pf[2])
    jac[10] = -pf[2] * pf[10] * v[17] * (1 - pf[2]) * v[8]^pf[2] * v[11]^(-1 - pf[2])
    jac[11] = -1
    jac[12] = pf[10] * (1 - pf[2]) * v[8]^pf[2] * v[11]^(-pf[2])
    jac[13] = pf[2] * pf[10] * v[17] * v[8]^(-1 + pf[2]) * v[11]^(1 - pf[2])
    jac[14] = pf[10] * v[17] * (1 - pf[2]) * v[8]^pf[2] * v[11]^(-pf[2])
    jac[15] = -1
    jac[16] = pf[10] * v[8]^pf[2] * v[11]^(1 - pf[2])
    jac[17] = -1 + pf[8] * v[16]^-1 * exp(pf[8] * log(v[16]))
    jac[18] = -1 + pf[7] * v[17]^-1 * exp(pf[7] * log(v[17]))
    jac[19] = pf[1] * pf[3] * pf[4] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    jac[20] = pf[4] * (pf[1] * pf[3] * v[1] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) + pf[1] * pf[3] * (-1 + pf[6]) * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) - pf[1]^2 * pf[3] * pf[6] * v[1] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * (v[2]^(-1 + pf[6]))^2 - pf[1]^2 * pf[3] * pf[6] * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * (v[2]^(-1 + pf[6]))^2) - pf[1] * pf[3] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) + pf[1]^2 * pf[3] * pf[6] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * (v[2]^(-1 + pf[6]))^2
    jac[21] = pf[4] * (-pf[1] * pf[3] * pf[6] * v[1] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]) - pf[1] * pf[3] * pf[6] * (1 - pf[1]) * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6])) + pf[1] * pf[3] * pf[6] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6])
    jac[22] = pf[4] * (pf[1] * pf[3] * (-1 + pf[6]) * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) - pf[1]^2 * pf[3] * pf[6] * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * (v[2]^(-1 + pf[6]))^2 - pf[1] * pf[3] * pf[6] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9])) - pf[1] * pf[3] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) + pf[1]^2 * pf[3] * pf[6] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * (v[2]^(-1 + pf[6]))^2
    jac[23] = pf[4] * (-pf[1] * pf[3] * pf[6] * (1 - pf[1]) * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]) - pf[3] * pf[6] * pf[9] * pf[10] * v[16] * (1 - pf[1])^2 * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * (v[3]^(-1 + pf[6]))^2 * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9]) + pf[3] * pf[9] * pf[10] * v[16] * (-1 + pf[6]) * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-2 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9])) + pf[1] * pf[3] * pf[6] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6])
    jac[24] = pf[3] * pf[4] * pf[9] * pf[10] * v[16] * (-1 + pf[9]) * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-2 + pf[9]) * v[12]^(1 - pf[9])
    jac[25] = pf[3] * pf[4] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(-pf[9])
    jac[26] = pf[3] * pf[4] * pf[9] * pf[10] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9])
    jac[27] = pf[1] * pf[3] * v[14] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) - pf[1]^2 * pf[3] * pf[6] * v[14] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * (v[2]^(-1 + pf[6]))^2
    jac[28] = -pf[1] * pf[3] * pf[6] * v[14] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6])
    jac[29] = -(1 - pf[3]) * (1 - v[11] - v[12])^-2
    jac[30] = -(1 - pf[3]) * (1 - v[11] - v[12])^-2
    jac[31] = pf[1] * pf[3] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    jac[32] = -pf[1] * pf[3] * pf[6] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]) * v[9]^pf[9] * v[12]^(-pf[9])
    jac[33] = pf[3] * pf[10] * v[16] * (-1 + pf[6]) * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-2 + pf[6]) * v[9]^pf[9] * v[12]^(-pf[9]) - pf[3] * pf[6] * pf[10] * v[16] * (1 - pf[1])^2 * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * (v[3]^(-1 + pf[6]))^2 * v[9]^pf[9] * v[12]^(-pf[9])
    jac[34] = pf[3] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(-pf[9])
    jac[35] = -(1 - pf[3]) * (1 - v[11] - v[12])^-2
    jac[36] = -(1 - pf[3]) * (1 - v[11] - v[12])^-2 - pf[3] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^pf[9] * v[12]^(-1 - pf[9])
    jac[37] = pf[3] * pf[10] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^pf[9] * v[12]^(-pf[9])
    jac[38] = -1
    jac[39] = 1
    jac[40] = 1
    jac[41] = 1
    jac[42] = -pf[5]
    jac[43] = 1
    jac[44] = -pf[5]
    jac[45] = -1
    jac[46] = 1
    jac[47] = 1
    jac[48] = -1
    jac[49] = 1
    jac[50] = 1
    jac[51] = -1
    jac[52] = -1
    jac[53] = -1
    jac[54] = 1
    jac[55] = -pf[1] * pf[3] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    jac[56] = -pf[3] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6])
    jac[57] = (1 - pf[3]) * (1 - v[11] - v[12])^-1
    jac[58] = (1 - pf[3]) * (1 - v[11] - v[12])^-1
    jac[59] = 1 - pf[4]
    jacob <- sparseMatrix(i = c(1, 1, 1, 1, 2, 2, 2, 2, 3, 3,
                                3, 3, 4, 4, 4, 4, 5, 6, 7, 7,
                                7, 8, 8, 8, 8, 8, 9, 9, 9, 9,
                                9, 10, 10, 10, 10, 10, 10, 11, 11, 11,
                                12, 12, 13, 13, 14, 14, 14, 15, 15, 15,
                                16, 16, 16, 16, 17, 17, 17, 17, 17),
                          j = c(1, 8, 11, 17, 3, 9, 12, 16, 8, 11,
                                14, 17, 8, 11, 15, 17, 16, 17, 1, 2,
                                3, 2, 3, 9, 12, 16, 2, 3, 11, 12,
                                14, 2, 3, 9, 11, 12, 16, 4, 5, 6,
                                5, 8, 6, 9, 7, 8, 9, 10, 11, 12,
                                2, 5, 6, 15, 2, 3, 11, 12, 13),
                          x = jac, dims = c(17, 17))

    return(jacob)
}

# 1st order perturbation
pert1__ <- function(v, pc, pf)
{
    Atm1x <- numeric(9)
    Atm1x[1] = pf[2] * pf[10] * v[17] * (-1 + pf[2]) * v[8]^(-2 + pf[2]) * v[11]^(1 - pf[2])
    Atm1x[2] = pf[9] * pf[10] * v[16] * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9])
    Atm1x[3] = pf[2] * pf[10] * v[17] * (1 - pf[2]) * v[8]^(-1 + pf[2]) * v[11]^(-pf[2])
    Atm1x[4] = pf[2] * pf[10] * v[17] * v[8]^(-1 + pf[2]) * v[11]^(1 - pf[2])
    Atm1x[5] = pf[8] * v[16]^-1 * exp(pf[8] * log(v[16]))
    Atm1x[6] = pf[7] * v[17]^-1 * exp(pf[7] * log(v[17]))
    Atm1x[7] = pf[3] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(-pf[9])
    Atm1x[8] = 1 - pf[5]
    Atm1x[9] = 1 - pf[5]
    Atm1 <- sparseMatrix(i = c(1, 2, 3, 4, 5, 6, 10, 12, 13),
                         j = c(8, 9, 8, 8, 16, 17, 9, 8, 9),
                         x = Atm1x, dims = c(17, 17))

    Atx <- numeric(51)
    Atx[1] = -1
    Atx[2] = pf[2] * pf[10] * v[17] * (1 - pf[2]) * v[8]^(-1 + pf[2]) * v[11]^(-pf[2])
    Atx[3] = pf[2] * pf[10] * v[8]^(-1 + pf[2]) * v[11]^(1 - pf[2])
    Atx[4] = -1
    Atx[5] = pf[10] * v[16] * (1 - pf[9]) * v[9]^pf[9] * v[12]^(-pf[9])
    Atx[6] = pf[10] * v[9]^pf[9] * v[12]^(1 - pf[9])
    Atx[7] = -pf[2] * pf[10] * v[17] * (1 - pf[2]) * v[8]^pf[2] * v[11]^(-1 - pf[2])
    Atx[8] = -1
    Atx[9] = pf[10] * (1 - pf[2]) * v[8]^pf[2] * v[11]^(-pf[2])
    Atx[10] = pf[10] * v[17] * (1 - pf[2]) * v[8]^pf[2] * v[11]^(-pf[2])
    Atx[11] = -1
    Atx[12] = pf[10] * v[8]^pf[2] * v[11]^(1 - pf[2])
    Atx[13] = -1
    Atx[14] = -1
    Atx[15] = pf[1]^2 * pf[3] * pf[6] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-2 + 2 * pf[6]) - pf[1] * pf[3] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6])
    Atx[16] = pf[1] * pf[3] * pf[6] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6])
    Atx[17] = pf[1]^2 * pf[3] * pf[6] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-2 + 2 * pf[6]) - pf[1] * pf[3] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6])
    Atx[18] = pf[1] * pf[3] * pf[6] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6])
    Atx[19] = pf[3] * pf[4] * pf[9] * pf[10] * v[16] * (-1 + pf[9]) * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-2 + pf[9]) * v[12]^(1 - pf[9])
    Atx[20] = pf[1] * pf[3] * v[14] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) - pf[1]^2 * pf[3] * pf[6] * v[14] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-2 + 2 * pf[6])
    Atx[21] = -pf[1] * pf[3] * pf[6] * v[14] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6])
    Atx[22] = (-1 + pf[3]) * (1 - v[11] - v[12])^-2
    Atx[23] = (-1 + pf[3]) * (1 - v[11] - v[12])^-2
    Atx[24] = pf[1] * pf[3] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    Atx[25] = -pf[1] * pf[3] * pf[6] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]) * v[9]^pf[9] * v[12]^(-pf[9])
    Atx[26] = pf[3] * pf[10] * v[16] * (-1 + pf[6]) * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-2 + pf[6]) * v[9]^pf[9] * v[12]^(-pf[9]) - pf[3] * pf[6] * pf[10] * v[16] * (1 - pf[1])^2 * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[3]^(-2 + 2 * pf[6]) * v[9]^pf[9] * v[12]^(-pf[9])
    Atx[27] = (-1 + pf[3]) * (1 - v[11] - v[12])^-2
    Atx[28] = -(1 - pf[3]) * (1 - v[11] - v[12])^-2 - pf[3] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^pf[9] * v[12]^(-1 - pf[9])
    Atx[29] = pf[3] * pf[10] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^pf[9] * v[12]^(-pf[9])
    Atx[30] = -1
    Atx[31] = 1
    Atx[32] = 1
    Atx[33] = 1
    Atx[34] = -1
    Atx[35] = 1
    Atx[36] = -1
    Atx[37] = -1
    Atx[38] = 1
    Atx[39] = 1
    Atx[40] = -1
    Atx[41] = 1
    Atx[42] = 1
    Atx[43] = -1
    Atx[44] = -1
    Atx[45] = -1
    Atx[46] = 1
    Atx[47] = -pf[1] * pf[3] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    Atx[48] = -pf[3] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6])
    Atx[49] = (1 - pf[3]) * (1 - v[11] - v[12])^-1
    Atx[50] = (1 - pf[3]) * (1 - v[11] - v[12])^-1
    Atx[51] = 1
    At <- sparseMatrix(i = c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4,
                             4, 4, 5, 6, 7, 7, 8, 8, 8, 9,
                             9, 9, 9, 9, 10, 10, 10, 10, 10, 11,
                             11, 11, 12, 12, 13, 13, 14, 14, 14, 15,
                             15, 15, 16, 16, 16, 16, 17, 17, 17, 17,
                             17),
                       j = c(1, 11, 17, 3, 12, 16, 11, 14, 17, 11,
                             15, 17, 16, 17, 2, 3, 2, 3, 9, 2,
                             3, 11, 12, 14, 2, 3, 11, 12, 16, 4,
                             5, 6, 5, 8, 6, 9, 7, 8, 9, 10,
                             11, 12, 2, 5, 6, 15, 2, 3, 11, 12,
                             13),
                         x = Atx, dims = c(17, 17))

    Atp1x <- numeric(8)
    Atp1x[1] = pf[1] * pf[3] * pf[4] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-1 + pf[6])
    Atp1x[2] = pf[4] * (pf[1] * pf[3] * (v[1] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) - pf[1] * pf[6] * v[1] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-2 + 2 * pf[6])) + pf[1] * pf[3] * (1 - pf[5]) * ((-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) - pf[1] * pf[6] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-2 + 2 * pf[6])))
    Atp1x[3] = pf[4] * (-pf[1] * pf[3] * pf[6] * v[1] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]) - pf[1] * pf[3] * pf[6] * (1 - pf[1]) * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]))
    Atp1x[4] = pf[4] * (pf[1] * pf[3] * (1 - pf[5]) * ((-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[2]^(-2 + pf[6]) - pf[1] * pf[6] * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-2 + 2 * pf[6])) - pf[1] * pf[3] * pf[6] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9]))
    Atp1x[5] = pf[4] * (pf[3] * pf[9] * pf[10] * (1 - pf[1]) * (v[16] * (-1 + pf[6]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-2 + pf[6]) * v[12]^(1 - pf[9]) - pf[6] * v[16] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[3]^(-2 + 2 * pf[6]) * v[12]^(1 - pf[9])) * v[9]^(-1 + pf[9]) - pf[1] * pf[3] * pf[6] * (1 - pf[1]) * (1 - pf[5]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-2 * v[2]^(-1 + pf[6]) * v[3]^(-1 + pf[6]))
    Atp1x[6] = pf[3] * pf[4] * pf[9] * pf[10] * v[16] * (1 - pf[1]) * (1 - pf[9]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(-pf[9])
    Atp1x[7] = pf[3] * pf[4] * pf[9] * pf[10] * (1 - pf[1]) * (pf[1] * v[2]^pf[6] + (1 - pf[1]) * v[3]^pf[6])^-1 * v[3]^(-1 + pf[6]) * v[9]^(-1 + pf[9]) * v[12]^(1 - pf[9])
    Atp1x[8] = -pf[4]
    Atp1 <- sparseMatrix(i = c(7, 7, 7, 8, 8, 8, 8, 17),
                         j = c(1, 2, 3, 2, 3, 12, 16, 13),
                         x = Atp1x, dims = c(17, 17))

    Aepsx <- numeric(2)
    Aepsx[1] = exp(pf[8] * log(v[16]))
    Aepsx[2] = exp(pf[7] * log(v[17]))
    Aeps <- sparseMatrix(i = c(5, 6),
                         j = c(1, 2),
                         x = Aepsx, dims = c(17, 2))

    return(list(Atm1, At, Atp1, Aeps))
}

ext__ <- list()

# create model object
gecon_model(model_info = info__,
            index_sets = index_sets__,
            variables = variables__,
            variables_tex = variables_tex__,
            shocks = shocks__,
            shocks_tex = shocks_tex__,
            parameters = parameters__,
            parameters_tex = parameters_tex__,
            parameters_free = parameters_free__,
            parameters_free_val = parameters_free_val__,
            equations = equations__,
            calibr_equations = calibr_equations__,
            var_eq_map = vareqmap__,
            shock_eq_map = shockeqmap__,
            var_ceq_map = varcalibreqmap__,
            cpar_eq_map = calibrpareqmap__,
            cpar_ceq_map = calibrparcalibreqmap__,
            fpar_eq_map = freepareqmap__,
            fpar_ceq_map = freeparcalibreqmap__,
            ss_function = ss_eq__,
            calibr_function = calibr_eq__,
            ss_calibr_jac_function = ss_calibr_eq_jacob__,
            pert = pert1__,
            ext = ext__)
