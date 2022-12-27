######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code prepares the graphs for the accounting section of the paper. 

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("investment.RData")

#### Packages ####

library(nicethings)
library(ggplot2)
library(scales)

#### Data ####


nice_load(file = "BCAData.RData", object = c("dat2"), rename = NULL) # Data from the Economic Outlook No 110 - December 2021
nice_load(file = "wedges.RData", object = c("taux"), rename = NULL)  # Estimated tau_x,t from the BCA exercise

base <- subset( dat2,  FREQUENCY == "Q" )      # Quarterly

IRS  <- subset( base,  VARIABLE == "IRS" )       # short-run quarterly annualized interest rate
rate <- ts( as.numeric( IRS$ObsValue ), start = c( 1990, 1), frequency = 4 ) 

#### Graph ####

# window: 12 quarters after the start of the recession

#Efficiency

r1 = window( rate, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( rate, start = c( 2008, 3 ), end = c( 2011, 2 ) ); r2 = r2 / r2[1] * 100
r3 = window( rate, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p <- ggplot(data) + 
geom_line( aes(x = time, y = r1, color = "1995 crisis" ), size = 1.5, linetype = "dotdash") +
geom_line( aes(x = time, y = r2, color = "2008 crisis" ), size = 1.5, linetype = "longdash") +
geom_line( aes(x = time, y = r3, color = "Covid recession" ), size = 1.5, linetype = "solid") +
geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
theme_classic() + labs(x = "", y= "" ) +
theme(text = element_text(size=14) ) + 
scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1)) +
scale_color_manual(name = "", values = c( "1995 crisis" = "darkblue",
                                          "2008 crisis" = "darkred", 
                                          "Covid recession" = "black" ) ) + 
theme(legend.text=element_text(size=14), legend.position = c(0.85, 0.8) )

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/Accounting for Mexican Business Cycles/Submissions/2021 1 Macroeconomic Dynamics/2. R & R/2nd Round")
jpeg('figure9.jpg', quality = 1200, bg="transparent")
print( p )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")


