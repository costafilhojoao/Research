######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code prepares the data for the Business Cycle Accounting 
# and creates the data.mat file

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Output falls and the international transmission of crises/BCA")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs


load("BCAData.RData")

#### Packages ####

library(OECD)       # OECD database
#library(Rilostat)   # International Labor Organization database
library(tempdisagg) # Quarterly interpolation - Denton-Cholette Method
#library(readxl)
#library(fpp3)
#library(gridExtra)


#### Quarterly National Accounts - OECD ####

# https://www.oecd-ilibrary.org/economics/data/aggregate-national-accounts/gross-domestic-product-sna-1993_data-00795-en

search <- search_dataset( "Economic Outlook", 
                          data = get_datasets(), 
                          ignore.case = TRUE)


search <- search_dataset( "Population", 
                          data = get_datasets(), 
                          ignore.case = TRUE)

dat1 <- get_dataset( "QNA", filter = "MEX") # Mexico

base <- subset( dat1,  FREQUENCY == "Q" &      # Quarterly
                       MEASURE   == "CQRSA")   # Millions of national currency, current prices, quarterly levels, s.a.

browse_metadata("QNA")

# Expenditure data

Y  <- subset( base,  SUBJECT == "B1_GE" )       # Gross domestic product - expenditure approach
C  <- subset( base,  SUBJECT == "P31S14_S15" )  # Private final consumption expenditure
G  <- subset( base,  SUBJECT == "P3S13" )       # Final consumption expenditure of general government
I  <- subset( base,  SUBJECT == "P51" )         # Gross fixed capital formation
X  <- subset( base,  SUBJECT == "P6" )          # Exports of goods and services
M  <- subset( base,  SUBJECT == "P7" )          # Imports of goods and services

Cd <- subset( base,  SUBJECT == "P311B" )  # Private final consumption expenditure

# Deflators


base <- subset( dat1,  
                FREQUENCY == "Q" &           # Quarterly
                MEASURE   == "DNBSA")        # Deflator, national base/reference year, s.a.

PY  <- subset( base,  SUBJECT == "B1_GE" )       # Gross domestic product - expenditure approach
#PC  <- subset( base,  SUBJECT == "P31S14_S15" )  # Private final consumption expenditure
#PG  <- subset( base,  SUBJECT == "P3S13" )       # Final consumption expenditure of general government
#PI  <- subset( base,  SUBJECT == "P51" )         # Gross fixed capital formation
#PX  <- subset( base,  SUBJECT == "P6" )          # Exports of goods and services
#PM  <- subset( base,  SUBJECT == "P7" )          # Imports of goods and services

# Deflated variables

Y_real = as.numeric( Y$ObsValue ) / as.numeric( PY$ObsValue )
C_real = as.numeric( C$ObsValue ) / as.numeric( PY$ObsValue )
G_real = as.numeric( G$ObsValue ) / as.numeric( PY$ObsValue )
I_real = as.numeric( I$ObsValue ) / as.numeric( PY$ObsValue )
X_real = as.numeric( X$ObsValue ) / as.numeric( PY$ObsValue )
M_real = as.numeric( M$ObsValue ) / as.numeric( PY$ObsValue )
  

#### Economic Outlook No 110 - December 2021 ####

#https://stats.oecd.org/OECDStat_Metadata/ShowMetadata.ashx?Dataset=EO110_INTERNET&ShowOnWeb=true&Lang=en

dat2 <- get_dataset( "EO110_INTERNET", filter = "MEX") # Mexico

base <- subset( dat2,  FREQUENCY == "Q" )      # Quarterly


H  <- subset( base,  VARIABLE == "HRS" )       # Hours worked per worker, total economy

E  <- subset( base,  VARIABLE == "ET" )       # Total employment (national accounts basis)

browse_metadata("EO110_INTERNET")


#### Population Data ####

## preciso pegar outros dados de população que vão até 2020 ou 2021

dat3 <- get_dataset( "POP_FIVE_HIST", filter = "MEX") # Mexico

POP <- subset( dat3,
               SEX == "TT" )


browse_metadata("POP_FIVE_HIST")


# Quarterly interpolation - Denton-Cholette Method 

iP <- td( ts( POP$ObsValue, start = 1950, frequency = 1  ) ~ 1, 
          to = "quarterly", method = "denton-cholette" )

iP <- predict( iP )

iP <- approx( as.numeric( POP$Time ), as.numeric( POP$ObsValue ), seq(from = 1950, to = 2021, by = 0.25), method = "linear", rule = 2)

iP = iP$y



Pop$Year <- Pop$Year + 1 #because data of population in e.g. 2001 refers to the data at the end of 2001, so Q4 2001, which is 2002 by the timing definition used

Pop <- Pop %>%
  as_tsibble(index = Year)

autoplot(Pop)

Pop <- approx(Pop$Year, Pop$Pop, seq(from = 1992, to = 2021, by = 0.25), method = "linear", rule = 2)


Pop <- tsibble(date = Pop$x, Pop= Pop$y, index = date)

autoplot(Pop)



h <- (Data$H/4)*Data$ET

Vars_real$total_hours <- h



#### Per Capita Values ####

pop <- Pop$Pop

ypc <- Vars_real$Y/(4*pop)
hpc <- h/pop
xpc <- Vars_real$X/(4*pop)
gpc <- Vars_real$G/(4*pop)
cpc <- Vars_real$C/(4*pop)
mpc <- Vars_real$M/(4*pop)
ipc <- Vars_real$I/(4*pop)
hpc <- h/pop
gxmpc <- gpc + xpc - mpc

pc_data <- tibble(Year_Qr = Vars_real$date, ypc, ipc, hpc = hpc/1300, gxmpc, pop)

pc_data <- pc_data %>%
  as_tsibble(index = Year_Qr)

grid.arrange(
  pc_data %>% 
    autoplot(ypc) + ggtitle("GDP per Capita"),
  pc_data %>%
    autoplot(ipc) + ggtitle("Investment per Capita"),
  pc_data %>%
    autoplot(hpc) + ggtitle("Normalised Labour per Capita"), 
  pc_data %>%
    autoplot(gxmpc) + ggtitle("Government Consumption and Net Exports per Capita"),
  pc_data %>%
    autoplot(pop) + ggtitle("Population")
)

pc_data_2 <- as.data.frame(pc_data)

#### BCA data ####

write.table(pc_data_2, file = "Data_Final.csv", row.names = F, sep = "  ")
