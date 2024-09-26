######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code estimates the shocks for the quantitative exercises 
# and creates the data.xlsx file

#### Housekeeping ####

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/DSGE")

load("shocksData.RData")

#### Packages ####

library(nicethings)

#### Quarterly National Accounts - OECD ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")

nice_load(file = "BCAdata.RData", object = c("dat1"), rename = NULL)

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/DSGE")


base <- subset( dat1,  FREQUENCY == "Q" &      # Quarterly
                  MEASURE   == "CQRSA")   # Millions of national currency, current prices, quarterly levels, s.a.

rm( dat1 )

PY  <- subset( base,  SUBJECT == "B1_GE" )       # Gross domestic product - expenditure approach
PM  <- subset( base,  SUBJECT == "P7" )          # Imports of goods and services

p = window( ts( as.numeric( PY$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
            start = c( 1993, 1), end = c( 2020, 4 ) ); p = p / p[ 1 ] * 100
pm = window( ts( as.numeric( PM$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
             start = c( 1993, 1), end = c( 2020, 4 ) ); pm = pm / pm[ 1 ] * 100

e = pm / p

time   <- c( 1:length( e ) )
reg    <- lm( log( e ) ~ time )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
trend  <- ts( beta0 + beta1 * time, start = c( 1993, 1 ),
              frequency = 4 )
de     <- ( log( e ) - trend ) * 100

library(zoo)

de = rollmean(de, align = "right", k = 4)


#### AR estimation ####

library(forecast)

ar <- Arima( window( de, start = c( 1994, 1), end = c( 2020, 4) ),
             order=c(1,0,0), seasonal=c(0,0,0) )

rhoe = round( ar[["coef"]][["ar1"]], 4 )

resid = ar$residuals * 100


#### Create the data.xlsx file for the simulations ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/DSGE")

library(xlsx)

nice_load(file = "DSGEData.RData", object = c("dy"), rename = NULL)

data  <- data.frame( time = seq(as.Date('1994-01-01'), as.Date('2020-12-01'), by='quarter'),
                     dy   = window( dy, start = c( 1994, 1 ), end = c( 2020, 4 ) ),
                     de   = window( de, start = c( 1994, 1 ), end = c( 2020, 4 ) ) )
colnames( data ) <- c( "quarter", "q", "dy" )
write.xlsx( data, file="data.xlsx")

