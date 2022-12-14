#### The square root of all evil: the role of market power in fiscal consolidations
####  Brito, P., Costa, L., Costa Filho, J., and Santos, C.
####  Correspondence: João Ricardo Costa Filho (joaocostafilho.com)


#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations/SVAR")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("lpdata.RData")

#### Packages ####

library(nicethings)
library(vars)
library(lpirfs)
library(ggplot2)
library(gridExtra)


#### Data from SVAR ####

nice_load(file = "svardata.RData", object = "g", rename = NULL)
nice_load(file = "svardata.RData", object = "t", rename = NULL)
nice_load(file = "svardata.RData", object = "y", rename = NULL)
nice_load(file = "svardata.RData", object = "mu", rename = NULL)

data <-  data.frame( cbind( g, t, y, mu ) )

#### State ####

down    <-  rep( x=c(0), times= length( mu ) )
up      <-  down
state   <-  data.frame( down=down, up=up )


for ( i in 1:length( mu ) ){
  
  if ( mu[i] < 0){
    state$down[i] <- 1
  }else{
    state$up[i] <- 1
  }
}

# variavel para capturar os regimes
switching_data <-  state$down


## Determinando a ordem do VAR
infocrit = VARselect(data, lag.max = 12, type = "const" )


#### Estimate LP nonlinear model ####

lp <- lp_nl(data, 
            lags_endog_lin = infocrit$selection["HQ(n)"],
            lags_endog_nl  = infocrit$selection["HQ(n)"],
                     trend = 0,
                 switching = switching_data,
                shock_type = 0,
                   confint = 1.96,
                       hor = 12,
              use_logistic = FALSE)


#### Graphs ####

# s1: up state 
# s2: down state (the switching variable)

# Up state (1: g is the first variable; 3: y is the third variable)

data_graphs <- data.frame( lp[["irf_s1_mean"]][ , , 1][ 3, ] * 100, 
                           lp[["irf_s1_low"]][ , , 1][ 3, ] * 100, 
                           lp[["irf_s1_up"]][ , , 1][ 3, ] * 100, 
                           zeros = rep( 0, length( lp[["irf_s1_mean"]][ , , 1][ 3, ] ) ),
                           periods = seq( 1:length( lp[["irf_s1_mean"]][ , , 1][ 3, ] ) ) )
colnames(data_graphs) <- c("response", "lower", "upper", "zeros", "periods")

p1 <- ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "darkorange", size = 1.5) +
  geom_line( aes(x = periods, y = zeros), colour = "black", linetype = "dashed", size = 0.75) +
  theme_classic() + labs(x = "", y = "", title = "UP State") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 ) + theme(text = element_text(size=16) )


# Down state (2: g is the first variable; 3: y is the third variable)

data_graphs <- data.frame( lp[["irf_s2_mean"]][ , , 1][ 3, ] * 100, 
                           lp[["irf_s2_low"]][ , , 1][ 3, ] * 100, 
                           lp[["irf_s2_up"]][ , , 1][ 3, ] * 100, 
                           zeros = rep( 0, length( lp[["irf_s2_mean"]][ , , 1][ 3, ] ) ),
                           periods = seq( 1:length( lp[["irf_s2_mean"]][ , , 1][ 3, ] ) ) )
colnames(data_graphs) <- c("response", "lower", "upper", "zeros", "periods")

p2 <- ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) +
  geom_line( aes(x = periods, y = zeros), colour = "black", linetype = "dashed", size = 0.75) +
  theme_classic() + labs(x = "", y = "", title = "Down State") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 ) + theme(text = element_text(size=16) )

grid.arrange( p1, p2 )

#### Multiplier ####

m1 = round( cumsum( lp[["irf_s1_mean"]][ , , 1][ 3, ] ) / lp[["irf_s1_mean"]][ , , 1][ 3, 1], 2 )
m2 = round( cumsum( lp[["irf_s2_mean"]][ , , 1][ 3, ] ) / lp[["irf_s2_mean"]][ , , 1][ 3, 1], 2 )


data_graphs <- data.frame( m1[1:4], 
                           m2[1:4], 
                           ones = rep( 1, length( m1[1:4] ) ),
                           periods = seq( 1:length( m1[1:4] ) ) )
colnames(data_graphs) <- c("m1", "m2", "ones", "periods")

ggplot(data_graphs) + geom_line( aes(x = periods, y = m1), color = "darkorange", size = 1.5) +
  geom_line( aes(x = periods, y = m2), color = "#0073D9", size = 1.5) +
  geom_line( aes(x = periods, y = ones), colour = "black", linetype = "dashed", size = 0.75) +
  theme_classic() + labs(x = "Quarters after the shock", y = "", title = "Government spending multipliers")

