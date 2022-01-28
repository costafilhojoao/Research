######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code prepares the data for the Business Cycle Accounting 
# and creates the data.mat file

#### Housekeeping ####

setwd("C:/Users/jcfil/Desktop/Infra")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

#### Packages ####

library(OECD)
#library(readxl)
#library(fpp3)
#library(gridExtra)
#population data measured at the end of each year
##treat population data first


#### National Accounts Data ####

search <- search_dataset( "Economic Outlook", 
                          data = get_datasets(), 
                          ignore.case = TRUE)

# OECD Economic Outlook No 110 (Edition 2021/2) - December 2021
# https://www.oecd-ilibrary.org/economics/data/oecd-economic-outlook-statistics-and-projections/oecd-economic-outlook-no-110-edition-2021-2_39740bed-en?parentId=http%3A%2F%2Finstance.metastore.ingenta.com%2Fcontent%2Fcollection%2Feo-data-en

dat1 <- get_dataset("EO110_INTERNET")

dat1 <- get_dataset("EO108_INTERNET")

base <- subset( dat1,  LOCATION  == "MEX" &
                       FREQUENCY == "Q" )
base   <- base[ order( base$time ), ]

browse_metadata("EO110_INTERNET")

# Expenditure data

Y  <- subset( base,  VARIABLE == "GDP" )  # Gross domestic product, nominal value, market prices
C  <- subset( base,  VARIABLE == "CP" )   # Private final consumption expenditure, nominal value, GDP expenditure approach
G  <- subset( base,  VARIABLE == "CG" )   # Government final consumption expenditure, nominal value, GDP expenditure approach
I  <- subset( base,  VARIABLE == "IT" )   # Gross fixed capital formation, total, nominal value
X  <- subset( base,  VARIABLE == "XGS" )  # Exports of goods and services, nominal value (national accounts basis)
M  <- subset( base,  VARIABLE == "MXGS" )  # Imports of goods and services, nominal value (national accounts basis)

# Deflators

PY  <- subset( base,  VARIABLE == "PGDP" )  # Gross domestic product, nominal value, market prices
PC  <- subset( base,  VARIABLE == "PCP" )   # Private final consumption expenditure, nominal value, GDP expenditure approach
PG  <- subset( base,  VARIABLE == "PCG" )   # Government final consumption expenditure, nominal value, GDP expenditure approach
PI  <- subset( base,  VARIABLE == "PIT" )   # Gross fixed capital formation, total, nominal value
PX  <- subset( base,  VARIABLE == "PXGS" )  # Exports of goods and services, nominal value (national accounts basis)
PM  <- subset( base,  VARIABLE == "PMXGS" )  # Imports of goods and services, nominal value (national accounts basis)


# Deflated variables

Y_real = Y$ObsValue / PY$ObsValue
C_real = C$ObsValue / PC$ObsValue
G_real = G$ObsValue / PG$ObsValue
I_real = I$ObsValue / PI$ObsValue
X_real = X$ObsValue / PX$ObsValue
M_real = M$ObsValue / PM$ObsValue
  

#### Labor Market ####

E  <- subset( base,  VARIABLE == "PGDP" )  # Total employment
H  <- subset( base,  VARIABLE == "PCP" )   # Hours worked per employee, total economy

h <- ( H$ObsValue / 4 ) * E$ObsValue


#### Population Data ####


Pop <- read_excel("Data_Merged.xlsx", 
                  sheet = "Dataset", range = "R7:S37")


Pop$Year <- Pop$Year + 1 #because data of population in e.g. 2001 refers to the data at the end of 2001, so Q4 2001, which is 2002 by the timing definition used

Pop <- Pop %>%
  as_tsibble(index = Year)

autoplot(Pop)

Pop <- approx(Pop$Year, Pop$Pop, seq(from = 1992, to = 2021, by = 0.25), method = "linear", rule = 2)


Pop <- tsibble(date = Pop$x, Pop= Pop$y, index = date)

autoplot(Pop)



##now read in data on variables
## only use data from Q4-1991 = 1992

##calculate hours

autoplot(Data, H)

autoplot(Data, ET)


h <- (Data$H/4)*Data$ET

Vars_real$total_hours <- h

autoplot(Vars_real, total_hours)


####calculate per capita variables


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

write.table(pc_data_2, file = "Data_Final.csv", row.names = F, sep = "  ")
