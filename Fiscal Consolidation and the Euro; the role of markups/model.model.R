# Generated on 2021-04-14 21:18:54 by gEcon ver. 1.2.0 (2019-09-08)
# http://gecon.r-forge.r-project.org/

# Model name: model

# info
info__ <- c("model", "C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups/model.gcn", "2021-04-14 21:18:54", "false")

# index sets
index_sets__ <- list()

# variables
variables__ <- c("e",
                 "fPI",
                 "i",
                 "lambda",
                 "mu",
                 "p",
                 "theta",
                 "y",
                 "A",
                 "B",
                 "C",
                 "D",
                 "G",
                 "H_d",
                 "H_s",
                 "MC",
                 "P",
                 "PI",
                 "T",
                 "U",
                 "W",
                 "X",
                 "Y")

variables_tex__ <- c("e",
                     "{f\\!P\\!I}",
                     "i",
                     "\\lambda",
                     "\\mu",
                     "p",
                     "\\theta",
                     "y",
                     "A",
                     "B",
                     "C",
                     "D",
                     "G",
                     "H^{\\mathrm{d}}",
                     "H^{\\mathrm{s}}",
                     "{M\\!C}",
                     "P",
                     "\\Pi",
                     "T",
                     "U",
                     "W",
                     "X",
                     "Y")

# shocks
shocks__ <- c("si",
              "sA",
              "sG",
              "sX")

shocks_tex__ <- c("{s\\!i}",
                  "{s\\!A}",
                  "{s\\!G}",
                  "{s\\!X}")

# parameters
parameters__ <- c("alpha",
                  "eta",
                  "gamma",
                  "kappa",
                  "omega",
                  "phi",
                  "psi",
                  "rho",
                  "sigma",
                  "zetaG",
                  "zetai",
                  "zetaX",
                  "zetaA")

parameters_tex__ <- c("\\alpha",
                     "\\eta",
                     "\\gamma",
                     "\\kappa",
                     "\\omega",
                     "\\phi",
                     "\\psi",
                     "\\rho",
                     "\\sigma",
                     "{z\\!e\\!t\\!a\\!G}",
                     "{z\\!e\\!t\\!a\\!i}",
                     "{z\\!e\\!t\\!a\\!X}",
                     "{z\\!e\\!t\\!a\\!A}")

# free parameters
parameters_free__ <- c("alpha",
                       "eta",
                       "gamma",
                       "kappa",
                       "omega",
                       "phi",
                       "psi",
                       "rho",
                       "sigma",
                       "zetaG",
                       "zetai",
                       "zetaX",
                       "zetaA")

# free parameters' values
parameters_free_val__ <- c(NA,
                           NA,
                           NA,
                           NA,
                           NA,
                           NA,
                           NA,
                           NA,
                           NA,
                           NA,
                           NA,
                           NA,
                           NA)

# equations
equations__ <- c("-W[] = 0",
                 "-lambda[] + (1 + rho)^-1 * (1 + i[]) * E[][lambda[1]] = 0",
                 "-mu[] + p[] * MC[]^-1 = 0",
                 "-p[] + P[] * D[]^(sigma^-1) * (psi * e[-1] * y[]^-1)^(sigma^-1) = 0",
                 "p[] + phi * theta[] = 0",
                 "-theta[] + (1 - eta) * (1 + rho)^-1 * E[][theta[1]] = 0",
                 "-y[] + A[] * H_d[]^(1 - alpha) = 0",
                 "D[] - Y[] = 0",
                 "H_d[] - H_s[] = 0",
                 "-MC[] + W[] * (1 - alpha)^-1 * y[]^(alpha * (1 - alpha)^-1) * A[]^(-(1 - alpha)^-1) = 0",
                 "T[] - G[] * P[] = 0",
                 "-lambda[] * P[] + (C[] - omega^-1 * H_s[]^omega)^(-gamma) = 0",
                 "lambda[] * W[] - H_s[]^(-1 + omega) * (C[] - omega^-1 * H_s[]^omega)^(-gamma) = 0",
                 "-e[] + phi * y[] + e[-1] * (1 - eta) = 0",
                 "-PI[] - H_s[] * W[] + P[] * Y[] = 0",
                 "U[] - (-1 + (C[] - omega^-1 * H_s[]^omega)^(1 - gamma)) * (1 - gamma)^-1 - (1 + rho)^-1 * E[][U[1]] = 0",
                 "fPI[] - p[] * y[] + H_d[] * W[] - (1 + rho)^-1 * E[][fPI[1]] = 0",
                 "sA[] - log(A[]) + zetaA * log(A[-1]) + log(A[ss]) * (1 - zetaA) = 0",
                 "sG[] - log(G[]) + zetaG * log(G[-1]) + log(G[ss]) * (1 - zetaG) = 0",
                 "sX[] - X[] + zetaX * X[-1] + X[ss] * (1 - zetaX) = 0",
                 "C[] + G[] + X[] - Y[] = 0",
                 "-i[] + si[] + kappa * (-1 + exp(B[] * P[]^-1 * Y[]^-1 - B[ss] * P[ss]^-1 * Y[ss]^-1)) + zetai * i[-1] + i[ss] * (1 - zetai) = 0",
                 "B[-1] - B[] + PI[] - T[] + i[-1] * B[-1] - C[] * P[] + H_s[] * W[] = 0")

# calibrating equations
calibr_equations__ <- character(0)

# variables / equations map
vareqmap__ <- sparseMatrix(i = c(1, 2, 2, 3, 3, 3, 4, 4, 4, 4,
                                 4, 5, 5, 6, 7, 7, 7, 8, 8, 9,
                                 9, 10, 10, 10, 10, 11, 11, 11, 12, 12,
                                 12, 12, 13, 13, 13, 13, 14, 14, 15, 15,
                                 15, 15, 15, 16, 16, 16, 17, 17, 17, 17,
                                 17, 18, 19, 20, 21, 21, 21, 21, 22, 22,
                                 22, 22, 23, 23, 23, 23, 23, 23, 23, 23),
                           j = c(21, 3, 4, 5, 6, 16, 1, 6, 8, 12,
                                 17, 6, 7, 7, 8, 9, 14, 12, 23, 14,
                                 15, 8, 9, 16, 21, 13, 17, 19, 4, 11,
                                 15, 17, 4, 11, 15, 21, 1, 8, 15, 17,
                                 18, 21, 23, 11, 15, 20, 2, 6, 8, 14,
                                 21, 9, 13, 22, 11, 13, 22, 23, 3, 10,
                                 17, 23, 3, 10, 11, 15, 17, 18, 19, 21),
                           x = c(2, 2, 6, 2, 2, 2, 1, 2, 2, 2,
                                 2, 2, 2, 6, 2, 2, 2, 2, 2, 2,
                                 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                                 2, 2, 2, 2, 2, 2, 3, 2, 2, 2,
                                 2, 2, 2, 2, 2, 6, 6, 2, 2, 2,
                                 2, 11, 11, 11, 2, 2, 2, 2, 11, 10,
                                 10, 10, 1, 3, 2, 2, 2, 2, 2, 2),
                           dims = c(23, 23))

# variables / calibrating equations map
varcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 23))

# calibrated parameters / equations map
calibrpareqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(23, 0))

# calibrated parameters / calibrating equations map
calibrparcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 0))

# free parameters / equations map
freepareqmap__ <- sparseMatrix(i = c(2, 4, 4, 5, 6, 6, 7, 10, 12, 12,
                                     13, 13, 14, 14, 16, 16, 16, 17, 18, 19,
                                     20, 22, 22),
                               j = c(8, 7, 9, 6, 2, 8, 1, 1, 3, 5,
                                     3, 5, 2, 6, 3, 5, 8, 8, 13, 10,
                                     12, 4, 11),
                               x = rep(1, 23), dims = c(23, 13))

# free parameters / calibrating equations map
freeparcalibreqmap__ <- sparseMatrix(i = NULL, j = NULL, dims = c(0, 13))

# shocks / equations map
shockeqmap__ <- sparseMatrix(i = c(18, 19, 20, 22),
                             j = c(2, 3, 4, 1),
                             x = rep(1, 4), dims = c(23, 4))

# steady state equations
ss_eq__ <- function(v, pc, pf)
{
    r <- numeric(23)
    e__ss = v[1]
    fPI__ss = v[2]
    i__ss = v[3]
    lambda__ss = v[4]
    mu__ss = v[5]
    p__ss = v[6]
    theta__ss = v[7]
    y__ss = v[8]
    A__ss = v[9]
    B__ss = v[10]
    C__ss = v[11]
    D__ss = v[12]
    G__ss = v[13]
    H_d__ss = v[14]
    H_s__ss = v[15]
    MC__ss = v[16]
    P__ss = v[17]
    PI__ss = v[18]
    T__ss = v[19]
    U__ss = v[20]
    W__ss = v[21]
    X__ss = v[22]
    Y__ss = v[23]

    alpha = pf[1]
    eta = pf[2]
    gamma = pf[3]
    kappa = pf[4]
    omega = pf[5]
    phi = pf[6]
    psi = pf[7]
    rho = pf[8]
    sigma = pf[9]
    zetaG = pf[10]
    zetai = pf[11]
    zetaX = pf[12]
    zetaA = pf[13]

    r[1] = -W__ss
    r[2] = -lambda__ss + lambda__ss * (1 + rho)^-1 * (1 + i__ss)
    r[3] = -mu__ss + p__ss * MC__ss^-1
    r[4] = -p__ss + P__ss * D__ss^(sigma^-1) * (psi * e__ss * y__ss^-1)^(sigma^-1)
    r[5] = p__ss + phi * theta__ss
    r[6] = -theta__ss + theta__ss * (1 - eta) * (1 + rho)^-1
    r[7] = -y__ss + A__ss * H_d__ss^(1 - alpha)
    r[8] = D__ss - Y__ss
    r[9] = H_d__ss - H_s__ss
    r[10] = -MC__ss + W__ss * (1 - alpha)^-1 * y__ss^(alpha * (1 - alpha)^-1) * A__ss^(-(1 - alpha)^-1)
    r[11] = T__ss - G__ss * P__ss
    r[12] = -lambda__ss * P__ss + (C__ss - omega^-1 * H_s__ss^omega)^(-gamma)
    r[13] = lambda__ss * W__ss - H_s__ss^(-1 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-gamma)
    r[14] = -e__ss + phi * y__ss + e__ss * (1 - eta)
    r[15] = -PI__ss - H_s__ss * W__ss + P__ss * Y__ss
    r[16] = U__ss - (-1 + (C__ss - omega^-1 * H_s__ss^omega)^(1 - gamma)) * (1 - gamma)^-1 - U__ss * (1 + rho)^-1
    r[17] = fPI__ss - fPI__ss * (1 + rho)^-1 - p__ss * y__ss + H_d__ss * W__ss
    r[18] = -log(A__ss) + zetaA * log(A__ss) + log(A__ss) * (1 - zetaA)
    r[19] = -log(G__ss) + zetaG * log(G__ss) + log(G__ss) * (1 - zetaG)
    r[20] = -X__ss + zetaX * X__ss + X__ss * (1 - zetaX)
    r[21] = C__ss + G__ss + X__ss - Y__ss
    r[22] = -i__ss + zetai * i__ss + i__ss * (1 - zetai)
    r[23] = PI__ss - T__ss + i__ss * B__ss - C__ss * P__ss + H_s__ss * W__ss

    return(r)
}

# calibrating equations
calibr_eq__ <- function(v, pc, pf)
{
    r <- numeric(0)
    e__ss = v[1]
    fPI__ss = v[2]
    i__ss = v[3]
    lambda__ss = v[4]
    mu__ss = v[5]
    p__ss = v[6]
    theta__ss = v[7]
    y__ss = v[8]
    A__ss = v[9]
    B__ss = v[10]
    C__ss = v[11]
    D__ss = v[12]
    G__ss = v[13]
    H_d__ss = v[14]
    H_s__ss = v[15]
    MC__ss = v[16]
    P__ss = v[17]
    PI__ss = v[18]
    T__ss = v[19]
    U__ss = v[20]
    W__ss = v[21]
    X__ss = v[22]
    Y__ss = v[23]

    alpha = pf[1]
    eta = pf[2]
    gamma = pf[3]
    kappa = pf[4]
    omega = pf[5]
    phi = pf[6]
    psi = pf[7]
    rho = pf[8]
    sigma = pf[9]
    zetaG = pf[10]
    zetai = pf[11]
    zetaX = pf[12]
    zetaA = pf[13]


    return(r)
}

# steady state and calibrating equations Jacobian
ss_calibr_eq_jacob__ <- function(v, pc, pf)
{
    r <- numeric(0)
    e__ss = v[1]
    fPI__ss = v[2]
    i__ss = v[3]
    lambda__ss = v[4]
    mu__ss = v[5]
    p__ss = v[6]
    theta__ss = v[7]
    y__ss = v[8]
    A__ss = v[9]
    B__ss = v[10]
    C__ss = v[11]
    D__ss = v[12]
    G__ss = v[13]
    H_d__ss = v[14]
    H_s__ss = v[15]
    MC__ss = v[16]
    P__ss = v[17]
    PI__ss = v[18]
    T__ss = v[19]
    U__ss = v[20]
    W__ss = v[21]
    X__ss = v[22]
    Y__ss = v[23]

    alpha = pf[1]
    eta = pf[2]
    gamma = pf[3]
    kappa = pf[4]
    omega = pf[5]
    phi = pf[6]
    psi = pf[7]
    rho = pf[8]
    sigma = pf[9]
    zetaG = pf[10]
    zetai = pf[11]
    zetaX = pf[12]
    zetaA = pf[13]

    jacob <- Matrix(0, nrow = 23, ncol = 23, sparse = TRUE)
    jacob[1, 21] = -1
    jacob[2, 3] = lambda__ss * (1 + rho)^-1
    jacob[2, 4] = -1 + (1 + rho)^-1 * (1 + i__ss)
    jacob[3, 5] = -1
    jacob[3, 6] = MC__ss^-1
    jacob[3, 16] = -p__ss * MC__ss^-2
    jacob[4, 1] = psi * sigma^-1 * y__ss^-1 * P__ss * D__ss^(sigma^-1) * (psi * e__ss * y__ss^-1)^(-1 + sigma^-1)
    jacob[4, 6] = -1
    jacob[4, 8] = -psi * sigma^-1 * e__ss * y__ss^-2 * P__ss * D__ss^(sigma^-1) * (psi * e__ss * y__ss^-1)^(-1 + sigma^-1)
    jacob[4, 12] = sigma^-1 * P__ss * D__ss^(-1 + sigma^-1) * (psi * e__ss * y__ss^-1)^(sigma^-1)
    jacob[4, 17] = D__ss^(sigma^-1) * (psi * e__ss * y__ss^-1)^(sigma^-1)
    jacob[5, 6] = 1
    jacob[5, 7] = phi
    jacob[6, 7] = -1 + (1 - eta) * (1 + rho)^-1
    jacob[7, 8] = -1
    jacob[7, 9] = H_d__ss^(1 - alpha)
    jacob[7, 14] = A__ss * (1 - alpha) * H_d__ss^(-alpha)
    jacob[8, 12] = 1
    jacob[8, 23] = -1
    jacob[9, 14] = 1
    jacob[9, 15] = -1
    jacob[10, 8] = alpha * W__ss * (1 - alpha)^-2 * y__ss^(-1 + alpha * (1 - alpha)^-1) * A__ss^(-(1 - alpha)^-1)
    jacob[10, 9] = -W__ss * (1 - alpha)^-2 * y__ss^(alpha * (1 - alpha)^-1) * A__ss^(-1 - (1 - alpha)^-1)
    jacob[10, 16] = -1
    jacob[10, 21] = (1 - alpha)^-1 * y__ss^(alpha * (1 - alpha)^-1) * A__ss^(-(1 - alpha)^-1)
    jacob[11, 13] = -P__ss
    jacob[11, 17] = -G__ss
    jacob[11, 19] = 1
    jacob[12, 4] = -P__ss
    jacob[12, 11] = -gamma * (C__ss - omega^-1 * H_s__ss^omega)^(-1 - gamma)
    jacob[12, 15] = gamma * H_s__ss^(-1 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-1 - gamma)
    jacob[12, 17] = -lambda__ss
    jacob[13, 4] = W__ss
    jacob[13, 11] = gamma * H_s__ss^(-1 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-1 - gamma)
    jacob[13, 15] = -gamma * (H_s__ss^(-1 + omega))^2 * (C__ss - omega^-1 * H_s__ss^omega)^(-1 - gamma) - (-1 + omega) * H_s__ss^(-2 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-gamma)
    jacob[13, 21] = lambda__ss
    jacob[14, 1] = -eta
    jacob[14, 8] = phi
    jacob[15, 15] = -W__ss
    jacob[15, 17] = Y__ss
    jacob[15, 18] = -1
    jacob[15, 21] = -H_s__ss
    jacob[15, 23] = P__ss
    jacob[16, 11] = -(C__ss - omega^-1 * H_s__ss^omega)^(-gamma)
    jacob[16, 15] = H_s__ss^(-1 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-gamma)
    jacob[16, 20] = 1 - (1 + rho)^-1
    jacob[17, 2] = 1 - (1 + rho)^-1
    jacob[17, 6] = -y__ss
    jacob[17, 8] = -p__ss
    jacob[17, 14] = W__ss
    jacob[17, 21] = H_d__ss
    jacob[18, 9] = -A__ss^-1 + zetaA * A__ss^-1 + A__ss^-1 * (1 - zetaA)
    jacob[19, 13] = -G__ss^-1 + zetaG * G__ss^-1 + G__ss^-1 * (1 - zetaG)
    jacob[21, 11] = 1
    jacob[21, 13] = 1
    jacob[21, 22] = 1
    jacob[21, 23] = -1
    jacob[23, 3] = B__ss
    jacob[23, 10] = i__ss
    jacob[23, 11] = -P__ss
    jacob[23, 15] = W__ss
    jacob[23, 17] = -C__ss
    jacob[23, 18] = 1
    jacob[23, 19] = -1
    jacob[23, 21] = H_s__ss

    return(jacob)
}

# 1st order perturbation
pert1__ <- function(v, pc, pf)
{
    e__ss = v[1]
    fPI__ss = v[2]
    i__ss = v[3]
    lambda__ss = v[4]
    mu__ss = v[5]
    p__ss = v[6]
    theta__ss = v[7]
    y__ss = v[8]
    A__ss = v[9]
    B__ss = v[10]
    C__ss = v[11]
    D__ss = v[12]
    G__ss = v[13]
    H_d__ss = v[14]
    H_s__ss = v[15]
    MC__ss = v[16]
    P__ss = v[17]
    PI__ss = v[18]
    T__ss = v[19]
    U__ss = v[20]
    W__ss = v[21]
    X__ss = v[22]
    Y__ss = v[23]

    alpha = pf[1]
    eta = pf[2]
    gamma = pf[3]
    kappa = pf[4]
    omega = pf[5]
    phi = pf[6]
    psi = pf[7]
    rho = pf[8]
    sigma = pf[9]
    zetaG = pf[10]
    zetai = pf[11]
    zetaX = pf[12]
    zetaA = pf[13]

    Atm1 <- Matrix(0, nrow = 23, ncol = 23, sparse = TRUE)
    Atm1[4, 1] = psi * sigma^-1 * y__ss^-1 * P__ss * D__ss^(sigma^-1) * (psi * e__ss * y__ss^-1)^(-1 + sigma^-1)
    Atm1[14, 1] = 1 - eta
    Atm1[18, 9] = zetaA * A__ss^-1
    Atm1[19, 13] = zetaG * G__ss^-1
    Atm1[20, 22] = zetaX
    Atm1[22, 3] = zetai
    Atm1[23, 3] = B__ss
    Atm1[23, 10] = 1 + i__ss

    At <- Matrix(0, nrow = 23, ncol = 23, sparse = TRUE)
    At[1, 21] = -1
    At[2, 3] = lambda__ss * (1 + rho)^-1
    At[2, 4] = -1
    At[3, 5] = -1
    At[3, 6] = MC__ss^-1
    At[3, 16] = -p__ss * MC__ss^-2
    At[4, 6] = -1
    At[4, 8] = -psi * sigma^-1 * e__ss * y__ss^-2 * P__ss * D__ss^(sigma^-1) * (psi * e__ss * y__ss^-1)^(-1 + sigma^-1)
    At[4, 12] = sigma^-1 * P__ss * D__ss^(-1 + sigma^-1) * (psi * e__ss * y__ss^-1)^(sigma^-1)
    At[4, 17] = D__ss^(sigma^-1) * (psi * e__ss * y__ss^-1)^(sigma^-1)
    At[5, 6] = 1
    At[5, 7] = phi
    At[6, 7] = -1
    At[7, 8] = -1
    At[7, 9] = H_d__ss^(1 - alpha)
    At[7, 14] = A__ss * (1 - alpha) * H_d__ss^(-alpha)
    At[8, 12] = 1
    At[8, 23] = -1
    At[9, 14] = 1
    At[9, 15] = -1
    At[10, 8] = alpha * W__ss * (1 - alpha)^-2 * y__ss^(-1 + alpha * (1 - alpha)^-1) * A__ss^(-(1 - alpha)^-1)
    At[10, 9] = -W__ss * (1 - alpha)^-2 * y__ss^(alpha * (1 - alpha)^-1) * A__ss^(-1 - (1 - alpha)^-1)
    At[10, 16] = -1
    At[10, 21] = (1 - alpha)^-1 * y__ss^(alpha * (1 - alpha)^-1) * A__ss^(-(1 - alpha)^-1)
    At[11, 13] = -P__ss
    At[11, 17] = -G__ss
    At[11, 19] = 1
    At[12, 4] = -P__ss
    At[12, 11] = -gamma * (C__ss - omega^-1 * H_s__ss^omega)^(-1 - gamma)
    At[12, 15] = gamma * H_s__ss^(-1 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-1 - gamma)
    At[12, 17] = -lambda__ss
    At[13, 4] = W__ss
    At[13, 11] = gamma * H_s__ss^(-1 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-1 - gamma)
    At[13, 15] = -gamma * H_s__ss^(-2 + 2 * omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-1 - gamma) - (-1 + omega) * H_s__ss^(-2 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-gamma)
    At[13, 21] = lambda__ss
    At[14, 1] = -1
    At[14, 8] = phi
    At[15, 15] = -W__ss
    At[15, 17] = Y__ss
    At[15, 18] = -1
    At[15, 21] = -H_s__ss
    At[15, 23] = P__ss
    At[16, 11] = -(C__ss - omega^-1 * H_s__ss^omega)^(-gamma)
    At[16, 15] = H_s__ss^(-1 + omega) * (C__ss - omega^-1 * H_s__ss^omega)^(-gamma)
    At[16, 20] = 1
    At[17, 2] = 1
    At[17, 6] = -y__ss
    At[17, 8] = -p__ss
    At[17, 14] = W__ss
    At[17, 21] = H_d__ss
    At[18, 9] = -A__ss^-1
    At[19, 13] = -G__ss^-1
    At[20, 22] = -1
    At[21, 11] = 1
    At[21, 13] = 1
    At[21, 22] = 1
    At[21, 23] = -1
    At[22, 3] = -1
    At[22, 10] = kappa * P__ss^-1 * Y__ss^-1
    At[22, 17] = -kappa * B__ss * P__ss^-2 * Y__ss^-1
    At[22, 23] = -kappa * B__ss * P__ss^-1 * Y__ss^-2
    At[23, 10] = -1
    At[23, 11] = -P__ss
    At[23, 15] = W__ss
    At[23, 17] = -C__ss
    At[23, 18] = 1
    At[23, 19] = -1
    At[23, 21] = H_s__ss

    Atp1 <- Matrix(0, nrow = 23, ncol = 23, sparse = TRUE)
    Atp1[2, 4] = (1 + rho)^-1 * (1 + i__ss)
    Atp1[6, 7] = (1 - eta) * (1 + rho)^-1
    Atp1[16, 20] = -(1 + rho)^-1
    Atp1[17, 2] = -(1 + rho)^-1

    Aeps <- Matrix(0, nrow = 23, ncol = 4, sparse = TRUE)
    Aeps[18, 2] = 1
    Aeps[19, 3] = 1
    Aeps[20, 4] = 1
    Aeps[22, 1] = 1

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
