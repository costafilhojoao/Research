######  Business Cycle Accounting: what have we learned so far?
######  Brinca, Pedro, Costa-Filho, João and Loria, Francesca

# This code prepares the data for the Business Cycle Accounting 
# and creates the data.mat file

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Business Cycle Accounting; What have we learned so far/BCA")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("BCAData.RData")

#### Packages ####

library(OECD)       # OECD database
library(tempdisagg) # Quarterly interpolation - Denton-Cholette Method
library(readxl)
library(R.matlab)
library(ggplot2)
library(scales)
library(gridExtra)


#### Quarterly National Accounts - OECD ####

# https://www.oecd-ilibrary.org/economics/data/aggregate-national-accounts/gross-domestic-product-sna-1993_data-00795-en

dat1 <- get_dataset( "QNA", filter = "USA")

base <- subset( dat1,  FREQUENCY == "Q" &      # Quarterly
                       MEASURE   == "CQRSA")   # Millions of national currency, current prices, quarterly levels, s.a.

browse_metadata("QNA")

# Expenditure data

Y  <- subset( base,  SUBJECT == "B1_GE" )       # Gross domestic product - expenditure approach
C  <- subset( base,  SUBJECT == "P31S14_S15" )  # Private final consumption expenditure
G  <- subset( base,  SUBJECT == "P3S13" )       # Final consumption expenditure of general government
#I  <- subset( base,  SUBJECT == "P5" )          # Gross capital formation
X  <- subset( base,  SUBJECT == "P6" )          # Exports of goods and services
M  <- subset( base,  SUBJECT == "P7" )          # Imports of goods and services

# Quarterly OECD flows are originally multiplied by 4

start = c( 1965, 1); end = c( 2020, 4 )

Y = window( ts( as.numeric( Y$ObsValue ), start = c( 1947 , 1), frequency = 4 ),
            start = start, end = end )
C = window( ts( as.numeric( C$ObsValue ), start = c( 1947 , 1), frequency = 4 ),
            start = start, end = end )
G = window( ts( as.numeric( G$ObsValue ), start = c( 1947 , 1), frequency = 4 ),
            start = start, end = end )
#I = window( ts( as.numeric( I$ObsValue ), start = c( 1970 , 1), frequency = 4 ),
#            start = start, end = end )
X = window( ts( as.numeric( X$ObsValue ), start = c( 1947 , 1), frequency = 4 ),
            start = start, end = end )
M = window( ts( as.numeric( M$ObsValue ), start = c( 1947 , 1), frequency = 4 ),
            start = start, end = end )

I = Y - C - G - ( X - M ) 

# Deflator

base <- subset( dat1,  
                FREQUENCY == "Q" &           # Quarterly
                MEASURE   == "DNBSA")        # Deflator, national base/reference year, s.a.

PY  <- subset( base,  SUBJECT == "B1_GE" )       # Gross domestic product - expenditure approach
#PC  <- subset( base,  SUBJECT == "P31S14_S15" )  # Private final consumption expenditure
#PG  <- subset( base,  SUBJECT == "P3S13" )       # Final consumption expenditure of general government
#PI  <- subset( base,  SUBJECT == "P51" )         # Gross fixed capital formation
#PX  <- subset( base,  SUBJECT == "P6" )          # Exports of goods and services
#PM  <- subset( base,  SUBJECT == "P7" )          # Imports of goods and services

PY = window( ts( as.numeric( PY$ObsValue ), start = c( 1947 , 1), frequency = 4 ),
             start = start, end = end )
PY = PY / PY[ length( PY ) ]

# Deflated variables

Y_real = ( Y * 1000000 / 4 ) / PY
C_real = ( C * 1000000 / 4 ) / PY
G_real = ( G * 1000000 / 4 ) / PY
I_real = ( I * 1000000 / 4 ) / PY
X_real = ( X * 1000000 / 4 ) / PY
M_real = ( M * 1000000 / 4 ) / PY
  

#### Labor Market ####

# Economic Outlook No 110 - December 2021
#https://stats.oecd.org/OECDStat_Metadata/ShowMetadata.ashx?Dataset=EO110_INTERNET&ShowOnWeb=true&Lang=en

search <- search_dataset( "Economic Outlook", 
                          data = get_datasets(), 
                          ignore.case = TRUE)

dat2 <- get_dataset( "EO110_INTERNET", filter = "USA")

base <- subset( dat2,  FREQUENCY == "Q" )      # Quarterly

H  <- subset( base,  VARIABLE == "HRS" )       # Hours worked per worker, total economy
H  <- window( ts( as.numeric( H$ObsValue ), start = c( 1960, 1), frequency = 4 ),
              start = start, end = end )

E  <- subset( base,  VARIABLE == "ET" )       # Total employment (national accounts basis)
E  <- window( ts( as.numeric( E$ObsValue ), start = c( 1960, 1), frequency = 4 ),
              start = start, end = end )

browse_metadata("EO110_INTERNET")


#### Population Data ####

dat3 <- get_dataset( "HISTPOP", filter = "USA", start_time = 1960, end_time = 2020) # Mexico

base <- subset( dat3,  
                SEX == "T" )           # Total

POP <- subset( base, AGE == "15-64" ) # Working age population: 15 to 64 years old

browse_metadata("HISTPOP")

# Quarterly interpolation - Denton-Cholette Method 

iP <- td( ts( as.numeric( POP$ObsValue ), start = 1960, frequency = 1  ) ~ 1, 
          to = "quarterly", method = "denton-cholette", conversion = "mean" )

iP <- window( predict( iP ), start = start, end = end )


#### Tax on goods and services ####

# https://data.oecd.org/tax/tax-on-goods-and-services.htm


TAX <- read_xlsx("tax.xlsx", sheet = "Sheet1",
                #range = "C2:C101",
                col_names = TRUE)

#dat4 <- get_dataset( "REV" )

base <- subset( TAX, LOCATION  == "USA" &   # Mexico
                     INDICATOR == "TAXGOODSERV" & 
                     MEASURE   == "PC_GDP")   


tax <- base$Value

itax <- td( ts( tax, start = 1965, frequency = 1  ) ~ 1, 
          to = "quarterly", method = "denton-cholette", conversion = "mean" )

tax <- window( ts( predict( itax ), start = start, frequency = 4 ),
               start = start, end = end )


#### Consumption of Durables Goods ####

search <- search_dataset( "Final consumption", 
                          data = get_datasets(), 
                          ignore.case = TRUE)

dat5 <- get_dataset( "SNA_TABLE5", filter = "USA" )

base <- subset( dat5, 
                TRANSACT == "P311B" &
                MEASURE == "C")

NDUR  <- ts( ( as.numeric( base$ObsValue ) ), start = 1970, frequency = 1 )  # annual data for household's consumption of durables goods
NDUR  <- NDUR * 1000000

NDUR <- td( NDUR ~ 0 + Y, 
               to = 4, 
               conversion = "mean", 
               method = "denton-cholette" )
NDUR <- predict( NDUR ) / 4


dur = NDUR / PY

deltad = 1 - ( 1 - 0.25 )^( 1 /4 ) # Annualized depreciation rate for durables taken to be 25%

durables_stock = matrix( data = NA, nrow = length(dur), ncol = 1)

durables_stock[ 1 ] = dur[ 1 ] * 16

for ( j in 1:(nrow( durables_stock )-1) ) {
  
  durables_stock[ j + 1 ] = ( 1 - deltad ) * durables_stock[ j ] + dur[ j ]
  
}

dur_serv = 0.01 * durables_stock
deprec   = deltad * durables_stock 

#### Per Capita Values ####

taxes_gdp = Y_real * tax / 100

ypc <- ( Y_real - taxes_gdp + dur_serv + deprec ) / iP
cpc <- ( C_real - dur - taxes_gdp ) / iP
xpc <- I_real / iP
gpc <- ( G_real + X_real - M_real ) / iP
hpc <- ( H / 4 * E ) / iP / 1300
t   <- seq( from = 1965.25, to = 2021, by = 0.25 )

#### Write .mat file for the BCA exercise ####

writeMat("data.mat", t = t, ypc = ypc, xpc = xpc, hpc = hpc, gpc = gpc, iP = iP )

