
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

y  <- diff( y ) * 100
g  <- diff( g ) * 100
t  <- diff( t ) * 100
mu <- diff( mu ) * 100
d  <- diff( d ) / 100
pf <- diff( pf ) * 100

data <- data.frame( cbind(g, t, y, mu ) ) 

data <- data.frame( cbind(g, t, y ) )

d2008 = ts( as.numeric( ifelse( time(y) > 2008 & time(y) < 2009.25, 1, 0 ) ), start = c( 1999, 2), frequency = 4 )
deuro = ts( as.numeric( ifelse( time(y) > 1998.99, 1, 0 ) ), start = c( 1999, 2), frequency = 4 )

dummies = data.frame( cbind( d2008, deuro ) )

exogenous = data.frame( as.vector(  pf ) ) 

# VAR - lag selection

lagselect <- VARselect(data, lag.max = 12, type = 'const')
lagselect$selection

#### Linear Model ####

linear <- lp_lin(    endog_data = data,
                 lags_endog_lin = 2,
                          trend = 0,
                     shock_type = 1,     #unity shock 
                        confint = 1.64,
                            hor = 2)
plot(linear)


#### Graphs ####

## Government shock

# Response of per capita output
data_graphs <- data.frame(linear$irf_lin_low[ , , 1][ 3, ]*-20, 
                          linear$irf_lin_up[ , , 1][ 3, ]*-20, 
                          linear$irf_lin_mean[ , , 1][ 3, ]*-20,
                           periods = seq( 1:length( linear$irf_lin_low[ , , 1][ 3, ] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")

ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )

# Response of markups
data_graphs <- data.frame(linear$irf_lin_low[ , , 1][ 4, ]*-20, 
                          linear$irf_lin_up[ , , 1][ 4, ]*-20, 
                          linear$irf_lin_mean[ , , 1][ 4, ]*-20,
                          periods = seq( 1:length( linear$irf_lin_low[ , , 1][ 4, ] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")


ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )

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

