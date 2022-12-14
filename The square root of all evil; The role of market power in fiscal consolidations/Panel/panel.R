#### The square root of all evil: the role of market power in fiscal consolidations
####  Brito, P., Costa, L., Costa Filho, J., and Santos, C.
####  Correspondence: João Ricardo Costa Filho (joaocostafilho.com)


#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations/Panel")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("paneldata.RData")

#### Packages ####

library(haven)
library(plm)
library(nicethings)
library(knitr)
library(kableExtra)
library(stargazer)
library(latex2exp)
library(xts)
library(plyr)

#### Datasets ####

#load annual markups variation for selected European countries in Alesina et al. (2015) dataset
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations/Markups")
nice_load(file = "markupsdata.RData", object = "austerity", rename = NULL)
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations/Panel")

#load Alesina et al. (2015) dataset

alesina         <- read_dta(file = "alesina.dta")
alesina         <- subset(alesina, year > 2007 & country != "GBR" )
countries_names <- c( rep("Austria", 7),
                      rep("Belgium", 7),
                      rep("Germany", 7),
                      rep("Denmark", 7),
                      rep("Spain", 7),
                      rep("Finland", 7),
                      rep("France", 7),
                      rep("Ireland", 7),
                      rep("Italy", 7),
                      rep("Portugal", 7),
                      rep("Sweden", 7))


alesina$country <- countries_names; rm( countries_names )
alesina$country <- factor( alesina$country )

#alphabetic order
alesina   <- alesina[ order( alesina$country ), ]

#regression dataset

data2 <- data %>%
  mutate( country = countryname( country, 
                                 destination = 'eurostat', 
                                 warn = TRUE)) 

data <- merge( alesina, austerity, by = c("country", "year")) %>%
        select( country, year, dlgdp, f_u_t, f_a_t, dmarkup_t1, eb, tb )

data$dlgdp = data$dlgdp * 100
data$dmarkup_t1_2  = ( data$dmarkup_t1 * 100 )^2

rm( alesina, austerity )

# Alesina et al. (2015) variables description:

#t_u_t: unanticipated tax shock at time t, % of GDP
#G_u_t: unanticipated spending shock at time t, % of GDP
#g_u_t: unanticipated transfer shock at time t, % of GDP

#t_a_t: anticipated tax shock at time t, % of GDP
#G_a_t: anticipated spending shock at time t, % of GDP
#g_a_t: anticipated transfers shock at time t, % of GDP

#f_u_t: total unanticipated shocks, % of GDP
#f_a_t: total anticipated shocks, % of GDP

#where

#f_u_t = t_u_t + G_u_t + g_u_t
#f_a_t = t_a_t + G_a_t + g_a_t


#### Imports prices ####

library(eurostat)
library(countrycode)


#### Annual National Accounts - Eurostat ####

# Economy and Finance > National accounts (ESA 2010) > Annual National accounts > Main GDP aggregates
# Database for national accounts

dat <- get_eurostat( "nama_10_gdp", time_format = "num" )

# Price index (implicit deflator), 2010=100, national currency
base <- subset( dat,
                na_item == "P7" &
                unit == "PD10_EUR") %>% mutate( country = geo,
                                                   year = time,
                                                    pm  = values)


# first (log-)difference
base <- base[ order( base$country, base$year ), ]
base <- transform(base, dlnpm = ave( pm, country, FUN = function(x) c(NA, diff( log( x ) ) * 100 ) ) )

# lag of first (log-)difference
base <- transform( base,
                   dlnpm1 = ave( dlnpm, country,
                                   FUN = function(x) c( NA, lag( x, 1 ) ) ) )


data2 <- data %>%
  mutate( country = countryname( country, 
                             destination = 'eurostat', 
                             warn = TRUE)) 

data2 <- merge( data2, base, by = c("country", "year"))


#### FGLS panel estimation ####

panel1 <- pggls( dlgdp ~ f_u_t + f_a_t,
                data  = data2,
                index = c( "country", "year" ), 
                model = "within",
                effect = "individual" )
summary( panel1 )

panel2 <- pggls( dlgdp ~ f_u_t + f_a_t + dmarkup_t1,
                data  = data2,
                index = c( "country", "year" ), 
                model = "within",
                effect = "individual")
summary( panel2 )

panel3 <- pggls( dlgdp ~ f_u_t + f_a_t + dmarkup_t1 + dlnpm1,
                data  = data2,
                index = c( "country", "year" ), 
                model = "within",
                effect = "individual")
summary( panel3 )


panel4 <- plm( dlgdp ~ f_u_t + f_a_t + f_u_t * dmarkup_t1 + f_a_t * dmarkup_t1,
                 data  = data2,
                 index = c( "country", "year" ), 
                 model = "within",
                 effect = "twoways")
summary( panel4 )

