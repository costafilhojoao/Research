#### The square root of all evil: the role of market power in fiscal consolidations
####  Brito, P., Costa, L., Costa Filho, J., and Santos, C.
####  Correspondence: João Ricardo Costa Filho (joaocostafilho.com)


#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations/SVAR")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("svardata.RData")

#### Packages ####

library(ggplot2)

#### Graphs ####

## Government shock

# Response of per capita output
data_graphs <- data.frame( irfs$Lower$g[ , 3 ], irfs$Upper$g[ , 3 ], irfs$irf$g[ , 3 ],
                           periods = seq( 1:length( irfs$Lower$g[,3] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")

ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )

# Response of markups
data_graphs <- data.frame( irfs$Lower$g[ , 4 ], irfs$Upper$g[ , 4 ], irfs$irf$g[ , 4 ],
                           periods = seq( 1:length( irfs$Lower$g[,4] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")


ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )

