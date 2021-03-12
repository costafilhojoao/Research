
#### Packages ####

library(ggplot2)
library(latex2exp)
library(nicethings)

#### Parameters ####

omega      = 1
theta      = 1
beta       = 0.95
delta      = 0.5 
phi        = 0
psi        = 1
sigma      = 2.9
alpha      = 2/3 
gamma      = 1.35
rbar       = 0.03
Omega      = alpha * ( sigma * (1 - gamma) - 1 ) / sigma

#### Benchmark Model ####

benchmark <- function( varepsilon  ){
  
  r      = rbar
  
  hprime = ( ( psi * varepsilon ) ^ ( 1 / sigma  ) * ( sigma - 1 ) / sigma   ) ^ ( 1 / ( alpha * theta - Omega ) )
  
  yprime = hprime ^ alpha
  
  cprime = yprime
  
  wprime = hprime ^ omega * cprime ^ theta 
  
  c      = ( beta * ( cprime ^ theta ) * ( 1 + r ) ) ^ ( 1 / theta ) 
  
  h      = ( cprime ^ theta * beta * ( 1 + r ) * ( psi * varepsilon ) ^ ( -1 / sigma ) * sigma / (sigma - 1 ) )  
  
  w      = h ^ omega * c ^theta
  
  y      = h ^ alpha
  
  nx     = y - c
  
  b      = nx
  
  p      = ( psi * varepsilon / y  ) ^ ( 1 / sigma )
  
  varepsilonprime = varepsilon * ( 1 - delta ) + phi * y 
  
  pprime = ( psi * varepsilonprime / yprime  ) ^ ( 1 / sigma )
  
  MgC      = gamma * w * y ^ ( gamma - 1 )
  
  MgCprime = gamma * wprime * yprime ^ ( gamma - 1 )
  
  mu       = p / MgC
  
  muprime  = pprime / MgCprime
  
  x = data.frame(c, cprime, h, hprime, b, w, wprime, r, y, yprime, nx, mu, muprime)
  
  return( x )
  
    
  
  
}

model0 = benchmark( 1 )

model1 = benchmark( 0.9 )

output = c( rep(0, 5), 
           log( model1$y / model0$y ), 
           rep( log( model1$yprime / model0$yprime ), 5 ) )

consumption = c( rep(0, 5), 
            log( model1$c / model0$c ), 
            rep( log( model1$cprime / model0$cprime ), 5 ) )

hours = c( rep(0, 5), 
            log( model1$h / model0$h ), 
            rep( log( model1$hprime / model0$hprime ), 5 ) )

markups = c( rep(0, 5), 
           log( model1$mu / model0$mu ), 
           rep( log( model1$muprime / model0$muprime ), 5 ) )


data = data.frame( var = output, x = seq( 1, length( output ) ) )


figure <- seq( 1, 10000 )



ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()


data = data.frame( var = consumption, x = seq(1, length( output ) ) )

ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()

data = data.frame( var = hours, x = seq(1, length( output ) ) )

ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()

data = data.frame( var = markups*100, x = seq(1, length( output ) ) )

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures/Two periods economy")

figurename <-paste0('figure',figure[ 1 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1.5) +
  theme_classic() + labs(x = "Time") + ylab( TeX( "$\\hat{\\mu}$" ) ) + 
  theme( axis.text.x = element_blank(), axis.ticks.x=element_blank())
dev.off()

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")
nice_load(file = "markupsdata.RData", object = "markups_growth", rename = NULL)

dates  <- seq(as.Date('1995-03-01'), as.Date('2019-12-01'), by='quarter') 

observed <- markups_growth[63:80, 15]

data = data.frame(observed, dates=dates[63:80])

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures/Two periods economy")

figurename <-paste0('figure',figure[ 2 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y =  observed ), size = 1.5) + 
  theme_classic() + 
  labs(x = "") + ylab( TeX( "$\\hat{\\mu}$" ) ) + theme(aspect.ratio=1) + 
  #ggtitle( countries_names[ i ] ) +
  theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text(size=24) ) 
dev.off()

#### Debt-elastic Model ####

eta = 0.000742

debt <- function( varepsilon  ){
  
  hprime = ( ( psi * varepsilon ) ^ ( 1 / sigma  ) * ( sigma - 1 ) / sigma   ) ^ ( 1 / ( alpha * theta - Omega ) )
  
  yprime = hprime ^ alpha
  
  cprime = yprime
  
  wprime = hprime ^ omega * cprime ^ theta 
  
  c      = ( beta * ( cprime ^ theta ) * ( 1 + r ) ) ^ ( 1 / theta ) 
  
  h      = ( cprime ^ theta * beta * ( 1 + r ) * ( psi * varepsilon ) ^ ( -1 / sigma ) * sigma / (sigma - 1 ) )  
  
  w      = h ^ omega * c ^theta
  
  y      = h ^ alpha
  
  nx     = y - c
  
  b      = nx
  
  p      = ( psi * varepsilon / y  ) ^ ( 1 / sigma )
  
  varepsilonprime = varepsilon * ( 1 - delta ) + phi * y 
  
  pprime = ( psi * varepsilonprime / yprime  ) ^ ( 1 / sigma )
  
  MgC      = gamma * w * y ^ ( gamma - 1 )
  
  MgCprime = gamma * wprime * yprime ^ ( gamma - 1 )
  
  mu       = p / MgC
  
  muprime  = pprime / MgCprime
  
  x = data.frame(c, cprime, h, hprime, b, w, wprime, r, y, yprime, nx, mu, muprime)
  
  return( x )
  
  
  
  
}

model2 = debt( 0.8 )

output = c( rep(0, 5), 
            log( model2$y / model0$y ), 
            rep( log( model2$yprime / model0$yprime ), 5 ) )

consumption = c( rep(0, 5), 
                 log( model2$c / model0$c ), 
                 rep( log( model2$cprime / model0$cprime ), 5 ) )

hours = c( rep(0, 5), 
           log( model2$h / model0$h ), 
           rep( log( model1$hprime / model0$hprime ), 5 ) )

markups = c( rep(0, 5), 
             log( model2$mu / model0$mu ), 
             rep( log( model1$muprime / model0$muprime ), 5 ) )


library(ggplot2)

data = data.frame( var = output, x = seq( 1, length( output ) ) )

ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()


data = data.frame( var = consumption, x = seq(1, length( output ) ) )

ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()

data = data.frame( var = hours, x = seq(1, length( output ) ) )

ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()

data = data.frame( var = markups, x = seq(1, length( output ) ) )

ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()



