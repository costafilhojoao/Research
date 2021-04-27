# Generated on 2019-12-09 17:11:54 by gEcon ver. 1.2.0 (2019-09-08)
# http://gecon.r-forge.r-project.org/

# Model name: dsge_model

# info
info__ <- c("dsge_model", "C:/Users/jcfil/Documents/2020 1 Bayesian Econometrics/Aulas/Aula 11 - Modelos DSGE/dsge_model.gcn", "2019-12-09 17:11:54", "false")

# index sets
index_sets__ <- list()

# variables
variables__ <- c("C",
                 "CapUt",
                 "G",
                 "H",
                 "I",
                 "K",
                 "K_ut",
                 "SPI",
                 "U",
                 "W",
                 "Y",
                 "Z")

variables_tex__ <- c("C",
                     "{C\\!a\\!p\\!U\\!t}",
                     "G",
                     "H",
                     "I",
                     "K",
                     "K^{\\mathrm{ut}}",
                     "{S\\!P\\!I}",
                     "U",
                     "W",
                     "Y",
                     "Z")

# shocks
shocks__ <- c("epsilon_G",
              "epsilon_Z")

shocks_tex__ <- c("\\epsilon^{\\mathrm{G}}",
                  "\\epsilon^{\\mathrm{Z}}")

# parameters
parameters__ <- c("alpha",
                  "beta",
                  "delta",
                  "omega",
                  "phi_G",
                  "phi_Z",
                  "psi")

parameters_tex__ <- c("\\alpha",
                     "\\beta",
                     "\\delta",
                     "\\omega",
                     "\\phi^{\\mathrm{G}}",
                     "\\phi^{\\mathrm{Z}}",
                     "\\psi")

# free parameters
parameters_free__ <- c("alpha",
                       "beta",
                       "delta",
                       "omega",
                       "phi_G",
                       "phi_Z",
                       "psi")

# free parameters' values
parameters_free_val__ <- c(0.33,
                           0.99,
                           0.0265,
                           1.45,
                           0.9,
                           0.9,
                           1.75)

# equations
equations__ <- c("-1 + beta * C[] * E[][C[1]^-1 * (1 - delta * CapUt[1]^omega + alpha * CapUt[1] * H[1]^(1 - alpha) * (exp(Z[1]))^(1 - alpha) * (K[] * CapUt[1])^(-1 + alpha))] = 0",
                 "-K_ut[] + K[-1] * CapUt[] = 0",
                 "-W[] + (1 - alpha) * H[]^(-alpha) * (exp(Z[]))^(1 - alpha) * (K[-1] * CapUt[])^alpha = 0",
                 "-Y[] + H[]^(1 - alpha) * (exp(Z[]))^(1 - alpha) * (K[-1] * CapUt[])^alpha = 0",
                 "C[]^-1 * W[] - psi * (1 - H[])^-1 = 0",
                 "-delta * omega * K[-1] * CapUt[]^(-1 + omega) + alpha * K[-1] * H[]^(1 - alpha) * (exp(Z[]))^(1 - alpha) * (K[-1] * CapUt[])^(-1 + alpha) = 0",
                 "epsilon_G[] - G[] + phi_G * G[-1] = 0",
                 "epsilon_Z[] - Z[] + phi_Z * Z[-1] = 0",
                 "I[] - K[] + K[-1] * (1 - delta * CapUt[]^omega) = 0",
                 "U[] - log(C[]) - beta * E[][U[1]] - psi * log(1 - H[]) = 0",
                 "-C[] - G[] + SPI[] + H[] * W[] - beta * C[] * E[][C[1]^-1 * SPI[1]] = 0",
                 "-I[] - SPI[] + Y[] - H[] * W[] + beta * C[] * E[][C[1]^-1 * SPI[1]] = 0")

# calibrating equations
calibr_equations__ <- character(0)

# variables / equations map
vareqmap__ <- sparseMatrix(i = c(1, 1, 1, 1, 1, 2, 2, 2, 3, 3,
                                 3, 3, 3, 4, 4, 4, 4, 4, 5, 5,
                                 5, 6, 6, 6, 6, 7, 8, 9, 9, 9,
                                 10, 10, 10, 11, 11, 11, 11, 11, 12, 12,
                                 12, 12, 12, 12),
                           j = c(1, 2, 4, 6, 12, 2, 6, 7, 2, 4,
                                 6, 10, 12, 2, 4, 6, 11, 12, 1, 4,
                                 10, 2, 4, 6, 12, 3, 12, 2, 5, 6,
                                 1, 4, 9, 1, 3, 4, 8, 10, 1, 4,
                                 5, 8, 10, 11),
                           x = c(6, 4, 4, 2, 4, 2, 1, 2, 2, 2,
                                 1, 2, 2, 2, 2, 1, 2, 2, 2, 2,
                                 2, 2, 2, 1, 2, 3, 3, 2, 2, 3,
                                 2, 2, 6, 6, 2, 2, 6, 2, 6, 2,
                                 2, 6, 2, 2),
                           dims = c(12, 12))

# variables / calibrating equations map
varcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 12))

# calibrated parameters / equations map
calibrpareqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(12, 0))

# calibrated parameters / calibrating equations map
calibrparcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 0))

# free parameters / equations map
freepareqmap__ <- sparseMatrix(i = c(1, 1, 1, 1, 3, 4, 5, 6, 6, 6,
                                     7, 8, 9, 9, 10, 10, 11, 12),
                               j = c(1, 2, 3, 4, 1, 1, 7, 1, 3, 4,
                                     5, 6, 3, 4, 2, 7, 2, 2),
                               x = rep(1, 18), dims = c(12, 7))

# free parameters / calibrating equations map
freeparcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 7))

# shocks / equations map
shockeqmap__ <- sparseMatrix(i = c(7, 8),
                             j = c(1, 2),
                             x = rep(1, 2), dims = c(12, 2))

# steady state equations
ss_eq__ <- function(v, pc, pf)
{
    r <- numeric(12)
    C__ss = v[1]
    CapUt__ss = v[2]
    G__ss = v[3]
    H__ss = v[4]
    I__ss = v[5]
    K__ss = v[6]
    K_ut__ss = v[7]
    SPI__ss = v[8]
    U__ss = v[9]
    W__ss = v[10]
    Y__ss = v[11]
    Z__ss = v[12]

    alpha = pf[1]
    beta = pf[2]
    delta = pf[3]
    omega = pf[4]
    phi_G = pf[5]
    phi_Z = pf[6]
    psi = pf[7]

    r[1] = -1 + beta * (1 - delta * CapUt__ss^omega + alpha * CapUt__ss * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha))
    r[2] = -K_ut__ss + CapUt__ss * K__ss
    r[3] = -W__ss + (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^alpha
    r[4] = -Y__ss + H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^alpha
    r[5] = C__ss^-1 * W__ss - psi * (1 - H__ss)^-1
    r[6] = -delta * omega * K__ss * CapUt__ss^(-1 + omega) + alpha * K__ss * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    r[7] = -G__ss + phi_G * G__ss
    r[8] = -Z__ss + phi_Z * Z__ss
    r[9] = I__ss - K__ss + K__ss * (1 - delta * CapUt__ss^omega)
    r[10] = U__ss - log(C__ss) - beta * U__ss - psi * log(1 - H__ss)
    r[11] = -C__ss - G__ss + SPI__ss - beta * SPI__ss + H__ss * W__ss
    r[12] = -I__ss - SPI__ss + Y__ss + beta * SPI__ss - H__ss * W__ss

    return(r)
}

# calibrating equations
calibr_eq__ <- function(v, pc, pf)
{
    r <- numeric(0)
    C__ss = v[1]
    CapUt__ss = v[2]
    G__ss = v[3]
    H__ss = v[4]
    I__ss = v[5]
    K__ss = v[6]
    K_ut__ss = v[7]
    SPI__ss = v[8]
    U__ss = v[9]
    W__ss = v[10]
    Y__ss = v[11]
    Z__ss = v[12]

    alpha = pf[1]
    beta = pf[2]
    delta = pf[3]
    omega = pf[4]
    phi_G = pf[5]
    phi_Z = pf[6]
    psi = pf[7]


    return(r)
}

# steady state and calibrating equations Jacobian
ss_calibr_eq_jacob__ <- function(v, pc, pf)
{
    r <- numeric(0)
    C__ss = v[1]
    CapUt__ss = v[2]
    G__ss = v[3]
    H__ss = v[4]
    I__ss = v[5]
    K__ss = v[6]
    K_ut__ss = v[7]
    SPI__ss = v[8]
    U__ss = v[9]
    W__ss = v[10]
    Y__ss = v[11]
    Z__ss = v[12]

    alpha = pf[1]
    beta = pf[2]
    delta = pf[3]
    omega = pf[4]
    phi_G = pf[5]
    phi_Z = pf[6]
    psi = pf[7]

    jacob <- Matrix(0, nrow = 12, ncol = 12, sparse = TRUE)
    jacob[1, 2] = beta * (-delta * omega * CapUt__ss^(-1 + omega) + alpha * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha) + alpha * CapUt__ss * K__ss * (-1 + alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-2 + alpha))
    jacob[1, 4] = alpha * beta * CapUt__ss * (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    jacob[1, 6] = alpha * beta * CapUt__ss^2 * (-1 + alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-2 + alpha)
    jacob[1, 12] = alpha * beta * CapUt__ss * exp(Z__ss) * (1 - alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(-alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    jacob[2, 2] = K__ss
    jacob[2, 6] = CapUt__ss
    jacob[2, 7] = -1
    jacob[3, 2] = alpha * K__ss * (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    jacob[3, 4] = -alpha * (1 - alpha) * H__ss^(-1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^alpha
    jacob[3, 6] = alpha * CapUt__ss * (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    jacob[3, 10] = -1
    jacob[3, 12] = exp(Z__ss) * (1 - alpha)^2 * H__ss^(-alpha) * (exp(Z__ss))^(-alpha) * (CapUt__ss * K__ss)^alpha
    jacob[4, 2] = alpha * K__ss * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    jacob[4, 4] = (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^alpha
    jacob[4, 6] = alpha * CapUt__ss * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    jacob[4, 11] = -1
    jacob[4, 12] = exp(Z__ss) * (1 - alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(-alpha) * (CapUt__ss * K__ss)^alpha
    jacob[5, 1] = -C__ss^-2 * W__ss
    jacob[5, 4] = -psi * (1 - H__ss)^-2
    jacob[5, 10] = C__ss^-1
    jacob[6, 2] = -delta * omega * K__ss * (-1 + omega) * CapUt__ss^(-2 + omega) + alpha * K__ss^2 * (-1 + alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-2 + alpha)
    jacob[6, 4] = alpha * K__ss * (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    jacob[6, 6] = -delta * omega * CapUt__ss^(-1 + omega) + alpha * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha) + alpha * CapUt__ss * K__ss * (-1 + alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-2 + alpha)
    jacob[6, 12] = alpha * K__ss * exp(Z__ss) * (1 - alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(-alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    jacob[7, 3] = -1 + phi_G
    jacob[8, 12] = -1 + phi_Z
    jacob[9, 2] = -delta * omega * K__ss * CapUt__ss^(-1 + omega)
    jacob[9, 5] = 1
    jacob[9, 6] = -delta * CapUt__ss^omega
    jacob[10, 1] = -C__ss^-1
    jacob[10, 4] = psi * (1 - H__ss)^-1
    jacob[10, 9] = 1 - beta
    jacob[11, 1] = -1
    jacob[11, 3] = -1
    jacob[11, 4] = W__ss
    jacob[11, 8] = 1 - beta
    jacob[11, 10] = H__ss
    jacob[12, 4] = -W__ss
    jacob[12, 5] = -1
    jacob[12, 8] = -1 + beta
    jacob[12, 10] = -H__ss
    jacob[12, 11] = 1

    return(jacob)
}

# 1st order perturbation
pert1__ <- function(v, pc, pf)
{
    C__ss = v[1]
    CapUt__ss = v[2]
    G__ss = v[3]
    H__ss = v[4]
    I__ss = v[5]
    K__ss = v[6]
    K_ut__ss = v[7]
    SPI__ss = v[8]
    U__ss = v[9]
    W__ss = v[10]
    Y__ss = v[11]
    Z__ss = v[12]

    alpha = pf[1]
    beta = pf[2]
    delta = pf[3]
    omega = pf[4]
    phi_G = pf[5]
    phi_Z = pf[6]
    psi = pf[7]

    Atm1 <- Matrix(0, nrow = 12, ncol = 12, sparse = TRUE)
    Atm1[2, 6] = CapUt__ss
    Atm1[3, 6] = alpha * CapUt__ss * (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    Atm1[4, 6] = alpha * CapUt__ss * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    Atm1[6, 6] = -delta * omega * CapUt__ss^(-1 + omega) + alpha * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha) + alpha * CapUt__ss * K__ss * (-1 + alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-2 + alpha)
    Atm1[7, 3] = phi_G
    Atm1[8, 12] = phi_Z
    Atm1[9, 6] = 1 - delta * CapUt__ss^omega

    At <- Matrix(0, nrow = 12, ncol = 12, sparse = TRUE)
    At[1, 1] = beta * C__ss^-1 * (1 - delta * CapUt__ss^omega + alpha * CapUt__ss * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha))
    At[1, 6] = alpha * beta * CapUt__ss^2 * (-1 + alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-2 + alpha)
    At[2, 2] = K__ss
    At[2, 7] = -1
    At[3, 2] = alpha * K__ss * (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    At[3, 4] = -alpha * (1 - alpha) * H__ss^(-1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^alpha
    At[3, 10] = -1
    At[3, 12] = exp(Z__ss) * (1 - alpha)^2 * H__ss^(-alpha) * (exp(Z__ss))^(-alpha) * (CapUt__ss * K__ss)^alpha
    At[4, 2] = alpha * K__ss * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    At[4, 4] = (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^alpha
    At[4, 11] = -1
    At[4, 12] = exp(Z__ss) * (1 - alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(-alpha) * (CapUt__ss * K__ss)^alpha
    At[5, 1] = -C__ss^-2 * W__ss
    At[5, 4] = -psi * (1 - H__ss)^-2
    At[5, 10] = C__ss^-1
    At[6, 2] = -delta * omega * K__ss * (-1 + omega) * CapUt__ss^(-2 + omega) + alpha * K__ss^2 * (-1 + alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-2 + alpha)
    At[6, 4] = alpha * K__ss * (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    At[6, 12] = alpha * K__ss * exp(Z__ss) * (1 - alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(-alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    At[7, 3] = -1
    At[8, 12] = -1
    At[9, 2] = -delta * omega * K__ss * CapUt__ss^(-1 + omega)
    At[9, 5] = 1
    At[9, 6] = -1
    At[10, 1] = -C__ss^-1
    At[10, 4] = psi * (1 - H__ss)^-1
    At[10, 9] = 1
    At[11, 1] = -1 - beta * C__ss^-1 * SPI__ss
    At[11, 3] = -1
    At[11, 4] = W__ss
    At[11, 8] = 1
    At[11, 10] = H__ss
    At[12, 1] = beta * C__ss^-1 * SPI__ss
    At[12, 4] = -W__ss
    At[12, 5] = -1
    At[12, 8] = -1
    At[12, 10] = -H__ss
    At[12, 11] = 1

    Atp1 <- Matrix(0, nrow = 12, ncol = 12, sparse = TRUE)
    Atp1[1, 1] = -beta * C__ss^-1 * (1 - delta * CapUt__ss^omega + alpha * CapUt__ss * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha))
    Atp1[1, 2] = beta * (-delta * omega * CapUt__ss^(-1 + omega) + alpha * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha) + alpha * CapUt__ss * K__ss * (-1 + alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-2 + alpha))
    Atp1[1, 4] = alpha * beta * CapUt__ss * (1 - alpha) * H__ss^(-alpha) * (exp(Z__ss))^(1 - alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    Atp1[1, 12] = alpha * beta * CapUt__ss * exp(Z__ss) * (1 - alpha) * H__ss^(1 - alpha) * (exp(Z__ss))^(-alpha) * (CapUt__ss * K__ss)^(-1 + alpha)
    Atp1[10, 9] = -beta
    Atp1[11, 1] = beta * C__ss^-1 * SPI__ss
    Atp1[11, 8] = -beta
    Atp1[12, 1] = -beta * C__ss^-1 * SPI__ss
    Atp1[12, 8] = beta

    Aeps <- Matrix(0, nrow = 12, ncol = 2, sparse = TRUE)
    Aeps[7, 1] = 1
    Aeps[8, 2] = 1

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
