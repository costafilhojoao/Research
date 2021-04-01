###

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

library(eurostat)

dat <- get_eurostat( "namq_10_gdp", time_format = "num" )

countries <- c("PT")

countries_names <- c( "Portugal" )

base <- subset( dat,  geo == countries[ 1 ] & 
                      s_adj == "SCA" & 
                      na_item == "P3_S13" &
                      unit == "CLV10_MNAC")
base   <- base[ order( base$time ), ]
#Chain linked volumes (2010), million units of national currency

g      <- ts( log( base$values ), start = c( 1995, 1), frequency = 4 ) 

time   <- c( 1:length( g ) )
time2  <- time^2

reg    <- lm( g ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             start=c(1995,1), frequency = 4) 
cycle                <- ( g - trend )

cycle <- window( cycle, start = c( 2010, 1), end = c( 2014, 4) )

write.xlsx( cycle, file="data.xlsx")
