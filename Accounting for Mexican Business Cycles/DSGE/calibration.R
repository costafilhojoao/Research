######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code presents the moments matched in the calibration for the quantitative exercise. 

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/DSGE")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("calibration.RData")

#### Packages ####

library(readxl)
library(dplyr)
library( nicethings )
library(forecast)
library(xts)


#### beta ####

# Penn World Table version 10.0
# https://www.rug.nl/ggdc/productivity/pwt/

pwt <- read_excel("pwt100.xlsx", sheet = "Data") %>% filter( country == "Mexico" & year > 1990 & year < 2011 )

beta = round( 1 - mean( pwt$irr )/ 4, 2 )

# alternative

library(WDI)

interest = WDI(country='all',
               indicator = 'FR.INR.RINR',
               start=1993, end=2010) %>% filter( country == "Mexico" )

beta2 = round( 1 - mean( interest$FR.INR.RINR ) / 100, 2 )

#### delta ####


# calibration
delta = round( mean( pwt$delta ), 2 )

#### alpha ####

alpha = round( mean( 1 - pwt$labsh ), 2 ) # labsh: Share of labour compensation in GDP at current national prices

#### mu ####

# from the steady state of the model we know that
# gross output: y = q - e * m <=> q = y ( 1 + s ), where s = m / y, with e = 1

nice_load(file = "DSGEData.RData", object = c("share_mex"), rename = NULL)  # Imported intermediate goods share of GDP (%) 
nice_load(file = "DSGEData.RData", object = c("mex_gdp"), rename = NULL)    # GDP

q = mex_gdp * ( 1 + share_mex / 100 )   # gross output

# from the steady state of the model we know that mu = m / q
mu = ( mex_gdp * share_mex / 100 ) / q  # gross output
mu = window( mu, end = c( 2010 ) )

# calibration
mu = round( mean( mu ), 2 )


#### rhoe ####

nice_load(file = "DSGEData.RData", object = c("reer"), rename = NULL)  # Imported intermediate goods share of GDP (%) 

e = log( window( reer, end = c( 2010, 4 ) ) )

ar <- Arima( e, order=c(1,0,0) )

rhoe <- round( ar$coef[1], 2 )

#### dbar ####

NFA = WDI(country = 'all',
             indicator = 'FM.AST.NFRG.CN',
             start=1993, end=2010) %>% filter( country == "Mexico" )

NFA <- data.frame( year = NFA$year,
                   nfa  = NFA$FM.AST.NFRG.CN )
colnames( NFA ) <- c("year", "value")

NFA   <- NFA[ order( NFA$year ), ]

GDP = WDI(country = 'all',
          indicator = 'NY.GDP.MKTP.CN',
          start=1993, end=2010) %>% filter( country == "Mexico" )

GDP <- data.frame( year = GDP$year,
                   gdp  = GDP$NY.GDP.MKTP.CN )
colnames( GDP ) <- c("year", "value")

GDP   <- GDP[ order( GDP$year ), ]

# calibration
dbar = round( mean( NFA$value / GDP$value ), 2 )


