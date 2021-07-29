library(ggplot2)
library(readxl)
library(latex2exp)


setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

data <- read_xlsx("dsge.xlsx")

data_graphs <- data.frame( Y  = c( 0, ( data$Y  / .5234555284 ) * 100 ),
                           mu = c( 0, ( data$mu / 1.4752 ) * 100 ),
                           C  = c( 0, ( data$C  / .3888022471 ) * 100 ),
                           i  = c( 0, data$i * 100 ),
                           e  = c( 0, ( data$e / 3.140733170 ) * 100 ),
                           G  = c( 0, ( data$G / .1765297236 ) * 100 ),
                           periods = 0:20 )

# Response of markups

figurename <- 'figure4.jpg'
jpeg(figurename, quality = 1600, bg="transparent")
ggplot(data_graphs) + geom_line( aes(x = periods, y = Y), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "") + ylab( TeX( "$\\hat{Y}$" ) ) 
dev.off()

figurename <- 'figure5.jpg'
jpeg(figurename, quality = 1600, bg="transparent")
ggplot(data_graphs) + geom_line( aes(x = periods, y = mu), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "") + ylab( TeX( "$\\hat{\\mu}$" ) ) 
dev.off()


figurename <- 'figure6.jpg'
jpeg(figurename, quality = 1600, bg="transparent")
ggplot(data_graphs) + geom_line( aes(x = periods, y = C), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "") + ylab( TeX( "$\\hat{C}$" ) ) 
dev.off()


figurename <- 'figure7.jpg'
jpeg(figurename, quality = 1600, bg="transparent")
ggplot(data_graphs) + geom_line( aes(x = periods, y = i), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "") + ylab( TeX( "$\\hat{i}$" ) ) 
dev.off()

figurename <- 'figure8.jpg'
jpeg(figurename, quality = 1600, bg="transparent")
ggplot(data_graphs) + geom_line( aes(x = periods, y = e), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "") + ylab( TeX( "$\\hat{\\epsilon}$" ) ) 
dev.off()

figurename <- 'figure9.jpg'
jpeg(figurename, quality = 1600, bg="transparent")
ggplot(data_graphs) + geom_line( aes(x = periods, y = G), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "") + ylab( TeX( "$\\hat{G}$" ) ) 
dev.off()

rm(figurename)

data_graphs <- data.frame( irfs$Lower$g[ , 3 ], irfs$Upper$g[ , 3 ], irfs$irf$g[ , 3 ],
                           periods = seq( 1:length( irfs$Lower$g[,3] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")

figurename <- 'figure10.jpg'
jpeg(figurename, quality = 1600, bg="transparent")
ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )
dev.off()

data_graphs <- data.frame( irfs$Lower$t[ , 3 ], irfs$Upper$t[ , 3 ], irfs$irf$t[ , 3 ],
                           periods = seq( 1 : length( irfs$Lower$t[ , 3 ] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")

figurename <- 'figure11.jpg'
jpeg(figurename, quality = 1600, bg="transparent")
ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )
dev.off()

rm(figurename)


#### Model vs data ####

mu_sim = c(
           100.0003, 100.0064, 100.0013, 99.9957, 
           99.9900,  99.9902,  99.9888,  99.9898,  99.9881, 
           99.9892, 99.9955, 100.0030, 100.0090, 100.0157, 100.0219, 100.0308
           )


dates  <- seq(as.Date('2010-03-01'), as.Date('2013-12-01'), by='quarter')

data_graphs <- data.frame( mu=MU[1:16], mu_sim, dates)


ggplot(data_graphs) + geom_line( aes(x = dates, y = mu), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y= "") #+ ylab( TeX( "$\\hat{Y}$" ) )

  scale_y_continuous(
    
    # Features of the first axis
    name = "First Axis",
    
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*coeff, name="Second Axis")
  )



