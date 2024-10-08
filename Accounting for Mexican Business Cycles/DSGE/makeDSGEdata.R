######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code prepares the data for the DSGE modeling 
# and creates the data_annual.xlsx and data.xlsx files

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/AcadÍmicos/Research/Accounting for Mexican Business Cycles/DSGE")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("DSGEData.RData")

#### Packages ####

library(readxl)
library(xts)
library(WDI)
library(R.matlab)
library(mFilter)
library(nicethings)
library(xlsx)
library(ggplot2)
library(scales)


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

GDP <- WDI(country = "all", indicator = "NYGDPMKTPSACD", 
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

#### Log-detrended output ####

BCAresults <- readMat("G:/Meu Drive/Documents/Papers/AcadÍmicos/Research/Accounting for Mexican Business Cycles/BCA/BCAresults.mat")

ypc <- ts( BCAresults[["worktemp"]][[5]][,2], start = c( 1993, 1), frequency = 4 )

time   <- c( 1:length( ypc ) )
reg    <- lm( log( ypc ) ~ time )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
trend  <- ts( beta0 + beta1 * time, start = c( 1993, 1 ),
             frequency = 4 )
#dy     <- window(  ( log( ypc) - trend ) * 100,
#                   start = c( 1994, 1) )
dy     <- window(  ( log( ypc) - trend ) * 100,
                   start = c( 1993, 1) )


### Relative prices ####

setwd("G:/Meu Drive/Documents/Papers/AcadÍmicos/Research/Accounting for Mexican Business Cycles/BCA")

nice_load(file = "BCAdata.RData", object = c("dat1"), rename = NULL)

setwd("G:/Meu Drive/Documents/Papers/AcadÍmicos/Research/Accounting for Mexican Business Cycles/DSGE")


base <- subset( dat1,  FREQUENCY == "Q" &      # Quarterly
                  MEASURE   == "CQRSA")   # Millions of national currency, current prices, quarterly levels, s.a.

rm( dat1 )

PY  <- subset( base,  SUBJECT == "B1_GE" )       # Gross domestic product - expenditure approach
PM  <- subset( base,  SUBJECT == "P7" )          # Imports of goods and services

p = window( ts( as.numeric( PY$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
            start = c( 1993, 1), end = c( 2020, 4 ) ); p = p / p[ 1 ] * 100
pm = window( ts( as.numeric( PM$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
             start = c( 1993, 1), end = c( 2020, 4 ) ); pm = pm / pm[ 1 ] * 100

tot = pm / p

time   <- c( 1:length( tot ) )
reg    <- lm( log( tot ) ~ time )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
trend  <- ts( beta0 + beta1 * time, start = c( 1993, 1 ),
              frequency = 4 )
de     <- ( log( tot ) - trend ) * 100

de = rollmean(de, align = "right", k = 4)


#### AR estimation ####

library(forecast)

ar <- Arima( window( de, start = c( 1994, 1), end = c( 2020, 4) ),
             order=c(1,0,0), seasonal=c(0,0,0) )

ar <- Arima( log( tot ), order=c(1,0,0), seasonal=c(0,0,0) )

rhoe = round( ar[["coef"]][["ar1"]], 4 )

resid = ar$residuals * 100


#### Save files that will be used in the quantitative exercises ####

# quarterly data

data  <- data.frame( time = seq(as.Date('1994-01-01'), as.Date('2020-12-01'), by='quarter'),
                     dy=window( dy, start = c( 1994, 1 ), end = c( 2020, 4 ) ),
                     de=window( resid, start = c( 1994, 1 ), end = c( 2020, 4 ) ) )
colnames( data ) <- c( "quarter", "dy", "de" )
write.xlsx( data, file="data.xlsx")


#### Graphs ####

# imported intermediates goods share of GDP

base <- data.frame( share_mex,
                    share_usa,
                    time = time( share_mex ) )
colnames( base ) <- c( "sMEX", "sUSA", "time" )

p <- ggplot(base) + 
  geom_line( aes(x = time, y = sMEX, color = "Mexico" ), size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = sUSA, color = "USA" ), color = "darkblue", size = 1.5, linetype = "longdash") +
  theme_classic() + labs(x = "", y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_y_continuous( labels = label_number(accuracy = 1)) +
  scale_color_manual(name = "", values = c( "Mexico" = "darkred",
                                            "USA" = "darkblue") ) + 
  theme(legend.text=element_text(size=12), legend.position = c(0.2, 0.9) )


setwd("G:/Meu Drive/Documents/Papers/AcadÍmicos/Working Papers/Accounting for Mexican Business Cycles/Submissions/2021 1 Macroeconomic Dynamics/2. R & R/2nd Round")
jpeg('figure6.jpg', quality = 1200, bg="transparent")
print( p )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/AcadÍmicos/Research/Accounting for Mexican Business Cycles/DSGE")

# Real exchange rate and detrended output

base <- data.frame( ee * 100,
                    dy,
                    time = time( ee ) )
colnames( base ) <- c( "ee", "dy", "time" )

p <- ggplot(base) + 
  geom_line( aes(x = time, y = ee, color = "Real Exchange Rate" ), size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = dy, color = "Output" ), color = "darkblue", size = 1.5, linetype = "longdash") +
  theme_classic() + labs(x = "", y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_y_continuous( labels = label_number(accuracy = 1)) +
  scale_color_manual(name = "", values = c( "Real Exchange Rate" = "darkred",
                                            "Output" = "darkblue") ) + 
  theme(legend.text=element_text(size=12), legend.position = c(0.45, 0.95) )


setwd("G:/Meu Drive/Documents/Papers/AcadÍmicos/Working Papers/Accounting for Mexican Business Cycles/Submissions/2021 1 Macroeconomic Dynamics/2. R & R/2nd Round")
jpeg('figure7.jpg', quality = 1200, bg="transparent")
print( p )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/AcadÍmicos/Research/Accounting for Mexican Business Cycles/DSGE")




