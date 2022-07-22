#### The square root of all evil: the role of market power in fiscal consolidations
####  Brito, P., Costa, L., Costa Filho, J., and Santos, C.
####  Correspondence: João Ricardo Costa Filho (joaocostafilho.com)


#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations/Markups")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

#### Packages ####

library(ggplot2)
library(latex2exp)
library(nicethings)

#### Markups ####

nice_load(file = "markupsdata.RData", object = c("mu"), rename = NULL)

#### Figure 1 ####

dates  <- seq(as.Date('2010-09-01'), as.Date('2013-12-01'), by='quarter') 
data <- data.frame( mu[63:76] / mu[63] * 100 , dates )
colnames(data) <- c( "mu", "dates")

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/The square root of all evil; The role of market power in fiscal consolidations/Working Paper/Figures")

ggplot(data) + geom_line(aes(x = dates, y =  mu ), color = "#0073D9", size = 2) + 
  theme_classic() + 
  labs(x = "") + ylab( TeX( "$\\mu$" ) ) + theme(aspect.ratio=1) + 
  theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text(size=24) )
ggsave( plot = last_plot(),"figure1.jpg", width = 1536/72, height = 864/72, dpi = 72)

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations/Markups")
