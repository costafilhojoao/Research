
setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

library(lpirfs)
library(vars)
library(ggplot2)
library(nicethings)

nice_load(file = "markupsdata.RData", object = c("mu"), rename = NULL)

MU <- window( ts( mu, start = c( 1995, 01), frequency = 4 ), 
              start = c( 1999, 1), end = c( 2019, 4) )

nice_load(file = "svardata.RData", object = c("ypc"), rename = NULL)  # per capita GDP
nice_load(file = "svardata.RData", object = c("gspc"), rename = NULL) # per capita gov spending
nice_load(file = "svardata.RData", object = c("tpc"), rename = NULL) # per capita gov revenue


y  <- log( ypc )
g  <- log( gspc )
t  <- log( tpc  )
mu <- log( MU )

y  <- diff( y )
g  <- diff( g )
t  <- diff( t )
mu <- diff( mu )

data <- data.frame( cbind(g, t, y, mu ) ) 

# VAR - lag selection

lagselect <- VARselect(data, lag.max = 12, type = 'const')
lagselect$selection

#### Linear Model ####

linear <- lp_lin(endog_data = data,
                          lags_endog_lin = 2,
                          trend = 0,
                          shock_type = 1,     #unity shock 
                          confint = 1.65,
                          hor = 16)
plot(linear)


#### Non-linear model ####

recession <-  rep( x=c(0), times = length(y) )
boom <-  recession
state <-  data.frame( recession=recession, boom=boom)


for ( i in 1:length( y ) ){
  if (y[i] < 0){
    state$recession[i] <- 1
  }else{
    state$boom[i] <- 1
  }
}

# variavel para capturar os regimes
switching_data <-  state$boom

# estimate nonlinear model
nonlinear <- lp_nl(data,
                   lags_endog_lin = 3, 
                   lags_endog_nl = 2, 
                   trend = 0, 
                   switching = switching_data, 
                   shock_type = 1, 
                   confint = 1.65, 
                   hor = 16, 
                   use_logistic = FALSE)

plot(nonlinear) 

