######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code prepares the data for the DSGE modeling 
# and creates the data_annual.xlsx and data.xlsx files

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/DSGE")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("DSGEData.RData")

#### Packages ####

library(readxl)
library(xts)
library(R.matlab)
library(mFilter)
library(xlsx)


#### Imported intermediate goods share of GDP (%) ####

# Imported intermediate goods

# Source:
# https://wits.worldbank.org/
# https://wits.worldbank.org/CountryProfile/en/Country/MEX/StartYear/1990/EndYear/2019/TradeFlow/Import/Indicator/MPRT-TRD-VL/Partner/WLD/Product/UNCTAD-SoP2
# https://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/1991/EndYear/2019/TradeFlow/Import/Indicator/MPRT-TRD-VL/Partner/WLD/Product/UNCTAD-SoP2


imports_mex <- read_xlsx("WITS-Product-MEX.xlsx",              # Mexico
                sheet = "Product-TimeSeries-Product",
                range = "G2:AI2", col_names = FALSE)

imports_mex <- ts( matrix( t( imports_mex[1,] ),               # transform into a time-series object
                           ncol = 1, 
                           nrow = ncol( imports_mex ) ), 
                   start = 1991, frequency = 1 ) 

imports_usa <- read_xlsx("WITS-Product-USA.xlsx",              # USA
                         sheet = "Product-TimeSeries-Product",
                         range = "F2:AH2", col_names = FALSE)

imports_usa <- ts( matrix( t( imports_usa[1,] ),               # transform into a time-series object
                           ncol = 1, 
                           nrow = ncol( imports_usa ) ), 
                   start = 1991, frequency = 1 )  

# GDP

search <- WDIsearch(string = "gdp", field = "name", short = FALSE,
          cache = NULL)

GDP <- WDI(country = "all", indicator = "	NYGDPMKTPSACD", 
           start = 1991, end = 2019, extra = FALSE, cache = NULL)
MEX <- subset( GDP, iso2c == "MEX"  )
USA <- subset( GDP, iso2c == "USA"  )

mex_gdp <- ts( MEX$`	NYGDPMKTPSACD`, start = 1991, frequency = 1 )
usa_gdp <- ts( USA$`	NYGDPMKTPSACD`, start = 1991, frequency = 1 )

# Shares

share_mex <- imports_mex / ( mex_gdp * 1000 ) * 100 # Mexico

share_usa <- imports_usa / ( usa_gdp * 1000 ) * 100 # USA


#### Real Effective Exchange Rate ####

# https://www.bis.org/statistics/eer.htm?m=6_381_676
# Real (CPI-based), Broad Indices, Monthly averages; 2010=100.

reer <- read_xlsx("reer.xlsx", 
                  sheet = "Real",
                  range = "AM6:AM329", 
                  col_names = FALSE)

reer <- ts( reer$...1 / 100 , start = c(1, 1994), frequency = 12 )

# in the paper, a rise in the exchange rate means a depreciation, whereas in the
# BIS data it is the opposite. Therefore, we use the inverse of the BIS reer index

reer <- 1 / reer

reer_time  <- seq(as.Date('1994-01-01'), as.Date('2020-12-01'), by='month')

reer <- xts( reer, order.by = reer_time )

reer <- apply.quarterly( reer, FUN = mean) # quarterly average

reer <- ts( reer, start = c( 1994, 1), frequency = 4 )

ee <- reer - 1 # deviation from the steady state

#### Filtered output ####

# HP filter; lambda = 1600 for quarterly data

BCAresults <- readMat("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA/BCAresults.mat")

ypc <- ts( BCAresults[["worktemp"]][[5]][,2], start = c( 1993, 1), frequency = 4 )


hp  <- mFilter( log ( ypc ), filter="HP", freq = 1600)

dy = window( hp$cycle, start = c( 1994, 1) )


#### Save files that will be used in the graphs and in the simulations ####

# annual data
data_annual <- data.frame( share_mex, share_usa )
write.xlsx( data_annual, file="data_annual.xlsx")

# quarterly data

data        <- data.frame( ee, dy )
colnames( data ) <- c( "ee", "dy" )
write.xlsx( data, file="data.xlsx")

