

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

library(BHSBVAR)
library(nicethings)

# Set function arguments
nlags <- 4
itr <- 10000
burn <- 2000
thin <- 2
cri <- 0.95
h <- 20
acc <- TRUE


#### Data ####

nice_load(file = "markupsdata.RData", object = c("mu"), rename = NULL)

MU <- window( ts( mu, start = c( 1995, 01), frequency = 4 ), 
              start = c( 1999, 1), end = c( 2019, 4) )

nice_load(file = "svardata.RData", object = c("ypc"), rename = NULL)

y <- matrix(data = c( diff( log(mu) ) * 100, diff( log(ypc) ) * 100 ),
            ncol = 2)
colnames(y) <- c("Markup", "Output")

#### Prior for A ####

pA <- array(data = NA, dim = c(2, 2, 8))
pA[, , 1] <- c(0, NA, 0, NA)
pA[, , 2] <- c(1, NA, -1, NA)
pA[, , 3] <- c(2, 1, -2, 1)         # parameters for the prior for beta^d
pA[, , 4] <- c(0.6, NA, 0.6, NA)    # parameters for the prior for alpha^s
pA[, , 5] <- c(3, NA, 3, NA)
pA[, , 6] <- c(NA, NA, NA, NA)
pA[, , 7] <- c(NA, NA, 1, NA)
pA[, , 8] <- c(2, NA, 2, NA)

#### Position priors for Phi ####
pP <- matrix(data = 0, nrow = ((nlags * ncol(pA)) + 1), ncol = ncol(pA))
pP[1:nrow(pA), 1:ncol(pA)] <-
  diag(x = 1, nrow = nrow(pA), ncol = ncol(pA))

# Confidence in the priors for Phi
x1 <- 
  matrix(data = NA, nrow = (nrow(y) - nlags), 
         ncol = (ncol(y) * nlags))
for (k in 1:nlags) {
  x1[, (ncol(y) * (k - 1) + 1):(ncol(y) * k)] <-
    y[(nlags - k + 1):(nrow(y) - k),]
}
x1 <- cbind(x1, 1)
colnames(x1) <- 
  c(paste(rep(colnames(y), nlags),
          "_L",
          sort(rep(seq(from = 1, to = nlags, by = 1), times = ncol(y)),
               decreasing = FALSE),
          sep = ""),
    "cons")
y1 <- y[(nlags + 1):nrow(y),]
ee <- matrix(data = NA, nrow = nrow(y1), ncol = ncol(y1))
for (i in 1:ncol(y1)) {
  xx <- cbind(x1[, seq(from = i, to = (ncol(x1) - 1), by = ncol(y1))], 1)
  yy <- matrix(data = y1[, i], ncol = 1)
  phi <- solve(t(xx) %*% xx, t(xx) %*% yy)
  ee[, i] <- yy - (xx %*% phi)
}
somega <- (t(ee) %*% ee) / nrow(ee)

#### Prior for B0 ####

lambda0 <- 0.2
lambda1 <- 1
lambda3 <- 100
v1 <- matrix(data = (1:nlags), nrow = nlags, ncol = 1)
v1 <- v1^((-2) * lambda1)
v2 <- matrix(data = diag(solve(diag(diag(somega)))), ncol = 1)
v3 <- kronecker(v1, v2)
v3 <- (lambda0^2) * rbind(v3, (lambda3^2))
v3 <- 1 / v3
pP_sig <- diag(x = 1, nrow = nrow(v3), ncol = nrow(v3))
diag(pP_sig) <- v3

# Confidence in long-run restriction priors
pR_sig <-
  array(data = 0,
        dim = c(((nlags * ncol(y)) + 1),
                ((nlags * ncol(y)) + 1),
                ncol(y)))
Ri <-
  cbind(kronecker(matrix(data = 1, nrow = 1, ncol = nlags),
                  matrix(data = c(1, 0), nrow = 1)),
        0)
pR_sig[, , 2] <- (t(Ri) %*% Ri) / 0.1

# Confidence in priors for D
kappa1 <- matrix(data = 2, nrow = 1, ncol = ncol(y))

# Set graphical parameters
par(cex.axis = 0.8, cex.main = 1, font.main = 1, family = "serif",
    mfrow = c(2, 2), mar = c(2, 2.2, 2, 1), las = 1)


#### Estimate the SBVAR model ####

results1 <- BH_SBVAR(y = y,            #(T x n) matrix of the endogenous variables
                     nlags = nlags,    #lag order
                     pA = pA,          #prior for matrix A
                     pP = pP,          #
                     pP_sig = pP_sig,  #
                     pR_sig = pR_sig,  #
                     kappa1 = NULL,    #
                     itr = itr,        # number of iterations
                     burn = burn,      #
                     thin = thin,      #
                     cri = cri)        # confidence interval

#### Historical decompositions ####

hd <- HD(results = results1, cri = cri)

hd_results <- HD_Plots(results  = hd, 
                       varnames = colnames(y),
                       shocknames = c("Aggregate Demand","Aggregate Supply"),
                       freq = 4, 
                       start_date = c( 1995, 2) )

#### IRFs ####

irf <- IRF(results = results1, h = h, acc = acc, cri = cri)

# Plot impulse responses
varnames <- colnames(y)
shocknames <- c("Aggregate Demand","Aggregate Supply")
irf_results <- 
  IRF_Plots(results = irf, varnames = varnames,
            shocknames = shocknames)


fevd <- FEVD(results = results1, h = h, acc = acc, cri = cri)

# Plot impulse responses
varnames <- colnames(y)
shocknames <- c("Aggregate Demand","Aggregate Supply")
fevd_results <- 
  FEVD_Plots(results = fevd, varnames = varnames,
             shocknames = shocknames)

# Plot Posterior and Prior Densities
A_titles <- 
  matrix(data = NA_character_, nrow = dim(pA)[1], ncol = dim(pA)[2])
A_titles[1, 1] <- "Markup Elasticity of Aggregate Demand"
A_titles[1, 2] <- "Markup Elasticity of Aggregate Supply"
par(mfcol = c(1, 2))
dist_results <- 
  Dist_Plots(results = results1, A_titles = A_titles)

