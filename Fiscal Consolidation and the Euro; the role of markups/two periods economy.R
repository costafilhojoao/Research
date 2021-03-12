
#### Packages ####

library(ggplot2)
library(latex2exp)
library(nicethings)
library(pracma)

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
rbar       = 0.02
Omega      = alpha * ( sigma * (1 - gamma) - 1 ) / sigma - omega
a
#### Benchmark Model ####

benchmark <- function( varepsilon  ){
  
  r               = rbar
  
  steady <- function( x ) {
    
    h      <- x[1] 
    hprime <- x[2]
    bprime <- x[3]
    
    #E
    res1 = h - ( 1 - delta ) ^ ( 1 / ( sigma * Omega ) ) * hprime
    
    #F
    res2 = h ^ alpha - ( ( psi * varepsilon ) ^ ( 1 / sigma ) * ( sigma - 1 ) / sigma * 
      h ^ Omega * ( 1 / gamma )  ) ^ ( 1 / theta ) - bprime
    
    #G
    res3 = hprime ^ alpha - ( psi * varepsilon * ( 1 - delta ) ) ^ ( 1 / sigma ) * ( sigma - 1 ) / sigma * 
      hprime ^ Omega * 1 / gamma + bprime * ( 1 + r )
    
    results = c( res1, res2, res3)
    
    return(results)
    
  }
  
  x0 <- c(0.92, 0.52, 0.48)
  #x0 <- c(0.7, 0.3, 0.3)
  result <- fsolve( steady, x0 )
  
  h       = result$x[1]
  hprime  = result$x[2]
  bprime  = result$x[3]

  nxprime = -bprime * ( 1 + r )
  
  yprime  = hprime ^ alpha
  
  cprime = yprime - nxprime
  
  wprime = hprime ^ omega * cprime ^ theta
  
  y      = h ^ alpha
  
  nx      = bprime
  
  c      = y - nx
  
  w      = h ^ omega * c ^ theta
  
  varepsilonprime = varepsilon * ( 1 - delta)
  
  p      = ( psi * varepsilon / y  ) ^ ( 1 / sigma )
  
  pprime = ( psi * varepsilonprime / yprime  ) ^ ( 1 / sigma )
  
  MgC      = gamma * w * y ^ ( gamma - 1 )
  
  MgCprime = gamma * wprime * yprime ^ ( gamma - 1 )
  
  mu       = p / MgC
  
  muprime  = pprime / MgCprime
  
  x = data.frame(c, cprime, h, hprime, bprime, w, wprime, r, y, yprime, mu, muprime, nx, nxprime, p, pprime, MgC, MgCprime, varepsilonprime)
  
  return( x )
  
} ; model0 = benchmark( 1 ); model1 = benchmark( 0.8 )

##

markups = c( 0, 
             log( model1$mu / model0$mu ), 
             log( model1$muprime / model0$muprime ) )

data = data.frame( var = markups*100, x = c(0, 1, 2) )

ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1.5) +
  theme_classic() + labs(x = "Time") + ylab( TeX( "$\\hat{\\mu}$" ) ) + theme(text = element_text(size=24) ) +
  theme( axis.text.x = element_blank(), axis.ticks.x=element_blank())+ 
  theme(aspect.ratio=1)+ scale_x_continuous(breaks = seq(0, 2, 1))

##

output = c( 0, 
           log( model1$y / model0$y ), 
           log( model1$yprime / model0$yprime ) )

consumption = c( 0, 
            log( model1$c / model0$c ), 
            log( model1$cprime / model0$cprime ) )

hours = c( 0, 
            log( model1$h / model0$h ), 
            log( model1$hprime / model0$hprime ) )

markups = c( 0, 
           log( model1$mu / model0$mu ), 
           log( model1$muprime / model0$muprime ) )

prices = c( 0, 
             log( model1$p / model0$p ), 
             log( model1$pprime / model0$pprime ) )

costs = c( 0, 
             log( model1$MgC / model0$MgC ), 
             log( model1$MgCprime / model0$MgCprime ) )

shock = c( 0, 
             log( 0.8 / 1 ), 
             log( model1$varepsilonprime / model0$varepsilonprime ) )

figure <- seq( 1, 10000 )

#### Model vs data ####

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")
nice_load(file = "markupsdata.RData", object = "markups_growth", rename = NULL)

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures/Two-periods-economy")

data = data.frame( var = output*100, x = c(0, 1, 2) )

figurename <-paste0('figure',figure[ 1 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic() + labs(x = "Time") + ylab( TeX( "$\\hat{y}$" ) ) + theme(text = element_text(size=24) ) +
  #theme( axis.text.x = element_blank(), axis.ticks.x=element_blank()) + 
  theme(aspect.ratio=1) + scale_x_continuous(breaks = seq(0, 2, 1))
dev.off()

data = data.frame( var = consumption*100, x = c(0, 1, 2) )

figurename <-paste0('figure',figure[ 2 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()+ labs(x = "Time") + ylab( TeX( "$\\hat{c}$" ) ) + theme(text = element_text(size=24) ) +
  #theme( axis.text.x = element_blank(), axis.ticks.x=element_blank()) + 
  theme(aspect.ratio=1) + scale_x_continuous(breaks = seq(0, 2, 1))
dev.off()

data = data.frame( var = hours*100, x = c(0, 1, 2) )

figurename <-paste0('figure',figure[ 3 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()+ labs(x = "Time") + ylab( TeX( "$\\hat{h}$" ) ) + theme(text = element_text(size=24) ) +
  #theme( axis.text.x = element_blank(), axis.ticks.x=element_blank())+ 
  theme(aspect.ratio=1) + scale_x_continuous(breaks = seq(0, 2, 1))
dev.off()


data = data.frame( var = shock*100, x = c(0, 1, 2) )

figurename <-paste0('figure',figure[ 4 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1) +
  theme_classic()+ labs(x = "Time") + ylab( TeX( "$\\varepsilon$" ) ) + theme(text = element_text(size=24) ) +
  #theme( axis.text.x = element_blank(), axis.ticks.x=element_blank())+ 
  theme(aspect.ratio=1) + scale_x_continuous(breaks = seq(0, 2, 1))
dev.off()


data = data.frame( var = markups*100, x = c(0, 1, 2) )

figurename <-paste0('figure',figure[ 5 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1.5) +
  theme_classic() + labs(x = "Time") + ylab( TeX( "$\\hat{\\mu}$" ) ) + theme(text = element_text(size=24) ) +
  theme( axis.text.x = element_blank(), axis.ticks.x=element_blank())+ 
  theme(aspect.ratio=1)+ scale_x_continuous(breaks = seq(0, 2, 1))
dev.off()


dates  <- seq(as.Date('1995-03-01'), as.Date('2019-12-01'), by='quarter') 

# GFC
observed <- markups_growth[50:60, 15]

data = data.frame(observed, dates=dates[50:60])

figurename <-paste0('figure',figure[ 6 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y =  observed ), size = 1.5) + 
  theme_classic() + 
  labs(x = "") + ylab( TeX( "$\\hat{\\mu}$" ) ) + theme(aspect.ratio=1) + 
  #ggtitle( countries_names[ i ] ) +
  theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text(size=24) ) + theme(aspect.ratio=1)
dev.off()

#Euro crisis
observed <- markups_growth[63:80, 15]

data = data.frame(observed, dates=dates[63:80])

figurename <-paste0('figure',figure[ 7 ],'.jpg', sep = '')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y =  observed ), size = 1.5) + 
  theme_classic() + 
  labs(x = "") + ylab( TeX( "$\\hat{\\mu}$" ) ) + theme(aspect.ratio=1) + 
  #ggtitle( countries_names[ i ] ) +
  theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text(size=24) ) + theme(aspect.ratio=1)
dev.off()


#See https://rpubs.com/aaronsc32/bisection-method-r for the supply-and-demand plots, maybe


#### Tests ####

benchmark <- function( varepsilon  ){
  
  r               = rbar
  
  hprime       = ( gamma * (psi * varepsilon * ( 1 - delta ) * ( sigma - 1) / sigma )^ - 1 ) ^( 1 / Omega )
  
  yprime      = hprime ^ alpha
  
  h       = ( gamma * (psi * varepsilon ) ) ^( 1 / Omega )
  
  y      = h ^ alpha
  
  cprime = ( y + yprime / (1 + r ) ) * ( ( beta * ( 1 + r ) + 1 / ( 1 + r ) )^( 1 / theta )  )^( - 1 )
  
  nxprime = yprime - cprime
  
  bprime  = -nxprime / (1 + r )
  
  nx      = bprime
  
  c       = y - nx
  
  w      = h ^ omega * c ^ theta
  
  wprime      = hprime ^ omega * cprime ^ theta
  
  varepsilonprime = varepsilon * ( 1 - delta)
  
  p      = ( psi * varepsilon / y  ) ^ ( 1 / sigma )
  
  pprime = ( psi * varepsilonprime / yprime  ) ^ ( 1 / sigma )
  
  MgC      = gamma * w * y ^ ( gamma - 1 )
  
  MgCprime = gamma * wprime * yprime ^ ( gamma - 1 )
  
  mu       = p / MgC
  
  muprime  = pprime / MgCprime
  
  x = data.frame(c, cprime, h, hprime, bprime, w, wprime, r, y, yprime, mu, muprime, nx, nxprime, p, pprime, MgC, MgCprime, varepsilonprime)
  
  return( x )
  
}; model0 = benchmark( 1 ); model1 = benchmark( 0.97 )

##

markups = c( 0, 
             log( model1$mu / model0$mu ), 
             log( model1$muprime / model0$muprime ) )

data = data.frame( var = markups*100, x = c(0, 1, 2) )

ggplot(data, aes(x = x, y = var)) +
  geom_path(color = "#0073D9", size = 1.5) +
  theme_classic() + labs(x = "Time") + ylab( TeX( "$\\hat{\\mu}$" ) ) + theme(text = element_text(size=24) ) +
  theme( axis.text.x = element_blank(), axis.ticks.x=element_blank())+ 
  theme(aspect.ratio=1)+ scale_x_continuous(breaks = seq(0, 2, 1))

##

