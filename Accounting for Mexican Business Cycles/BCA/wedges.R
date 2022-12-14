######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code prepares the graphs for the accounting section of the paper. 

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("wedges.RData")

#### Packages ####

library(R.matlab)
library(ggplot2)
library(latex2exp)
library(scales)
library(gridExtra)


#### Estimated wedges ####

# load the results from the BCA exercises
results <- readMat( "BCAresults.mat" )

# Wedges
a    <- ts( results[["worktemp"]][[20]][[6]], start = c( 1993 , 1), frequency = 4 )  # efficiency
taul <- ts( results[["worktemp"]][[20]][[8]], start = c( 1993 , 1), frequency = 4 )  # labor 
taux <- ts( results[["worktemp"]][[20]][[10]], start = c( 1993 , 1), frequency = 4 ) # investment
g    <- ts( results[["worktemp"]][[20]][[5]], start = c( 1993 , 1), frequency = 4 )  # government consumption + net exports


#### Graphs - wedges ####

# window: 12 quarters after the start of the recession

#Efficiency

r1 = window( a, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( a, start = c( 2008, 3 ), end = c( 2011, 2 ) ); r2 = r2 / r2[1] * 100
r3 = window( a, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p1 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "dotdash", colour = "darkblue") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "longdash", colour = "darkred") +
  geom_line( aes(x = time, y = r3 ), size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = TeX( "$A_t$" ), y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1)) 


#Labor

r1 = window( taul, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( taul, start = c( 2008, 3 ), end = c( 2011, 2 ) ); r2 = r2 / r2[1] * 100
r3 = window( taul, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p2 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "dotdash", colour = "darkblue") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "longdash", colour = "darkred") +
  geom_line( aes(x = time, y = r3 ), size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = TeX( "$\\tau_{l,  t }$" ), y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1)) 


#Investment

r1 = window( taux, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( taux, start = c( 2008, 2 ), end = c( 2011, 2 ) ); r2 = r2 / r2[1] * 100
r3 = window( taux, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p3 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "dotdash", colour = "darkblue") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "longdash", colour = "darkred") +
  geom_line( aes(x = time, y = r3 ), size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = TeX( "$\\tau_{x, t }$" ), y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1)) 


#Government Consumption + net exports

r1 = window( g, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( g, start = c( 2008, 3 ), end = c( 2011, 2 ) ); r2 = r2 / r2[1] * 100
r3 = window( g, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p4 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "dotdash", colour = "darkblue") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "longdash", colour = "darkred") +
  geom_line( aes(x = time, y = r3 ), size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = TeX( "$g_t$" ), y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1)) 


setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/Accounting for Mexican Business Cycles/Submissions/2021 1 Macroeconomic Dynamics/2. R & R/2nd Round")
jpeg('figure2.jpg', quality = 1200, bg="transparent")
print( grid.arrange( p1, p2, p3, p4 ) )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")


#### Graphs - simulations ####

# One wedge economies
# output
y   <- ts( results[["worktemp"]][[20]][[2]], start = c( 1993 , 1), frequency = 4 )  # output data
mzy <- ts( results[["worktemp"]][[20]][[18]], start = c( 1993 , 1), frequency = 4 ) # efficiency
mly <- ts( results[["worktemp"]][[20]][[21]], start = c( 1993 , 1), frequency = 4 ) # labor 
mxy <- ts( results[["worktemp"]][[20]][[24]], start = c( 1993 , 1), frequency = 4 ) # investment
mgy <- ts( results[["worktemp"]][[20]][[27]], start = c( 1993 , 1), frequency = 4 ) # government consumption + net exports

# One wedge off economies
# output
mnozy <- ts( results[["worktemp"]][[20]][[30]], start = c( 1993 , 1), frequency = 4 ) # efficiency
mnoly <- ts( results[["worktemp"]][[20]][[33]], start = c( 1993 , 1), frequency = 4 ) # labor 
mnoxy <- ts( results[["worktemp"]][[20]][[36]], start = c( 1993 , 1), frequency = 4 ) # investment
mnogy <- ts( results[["worktemp"]][[20]][[39]], start = c( 1993 , 1), frequency = 4 ) # government consumption + net exports

#### 1995 crisis

# window: 12 quarters after the start of the recession

# One wedge economies
yt   = window( y, start = c( 1994, 4 ), end = c( 1997, 3 ) ); yt = yt / yt[1] * 100 
mzyt = window( mzy, start = c( 1994, 4 ), end = c( 1997, 3 ) ); mzyt = mzyt / mzyt[1] * 100
mlyt = window( mly, start = c( 1994, 4 ), end = c( 1997, 3 ) ); mlyt = mlyt / mlyt[1] * 100
mxyt = window( mxy, start = c( 1994, 4 ), end = c( 1997, 3 ) ); mxyt = mxyt / mxyt[1] * 100
mgyt = window( mgy, start = c( 1994, 4 ), end = c( 1997, 3 ) ); mgyt = mgyt / mgyt[1] * 100

# One wedge off economies
mnozyt = window( mnozy, start = c( 1994, 4 ), end = c( 1997, 3 ) ); mnozyt = mnozyt / mnozyt[1] * 100
mnolyt = window( mnoly, start = c( 1994, 4 ), end = c( 1997, 3 ) ); mnolyt = mnolyt / mnolyt[1] * 100
mnoxyt = window( mnoxy, start = c( 1994, 4 ), end = c( 1997, 3 ) ); mnoxyt = mnoxyt / mnoxyt[1] * 100
mnogyt = window( mnogy, start = c( 1994, 4 ), end = c( 1997, 3 ) ); mnogyt = mnogyt / mnogyt[1] * 100

data <- data.frame( yt,
                    mzyt,
                    mlyt,
                    mxyt,
                    mgyt,
                    mnozyt,
                    mnolyt,
                    mnoxyt,
                    mnogyt,
                    time = time( yt ),
                    base = rep( 100, length( yt ) ) )
colnames( data ) <- c( "yt", "mzyt", "mlyt", "mxyt", "mgyt",
                       "mnozyt", "mnolyt", "mnoxyt", "mnogyt",
                       "time", "base")

p1 <- ggplot(data) + 
  geom_line( aes(x = time, y = mzyt), color = "darkred", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mlyt), color = "darkgreen", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p2 <- ggplot(data) + 
  geom_line( aes(x = time, y = mxyt), color = "darkblue", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mgyt), color = "darkorange", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p3 <- ggplot(data) + 
  geom_line( aes(x = time, y = mnozyt), color = "darkred", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mnolyt), color = "darkgreen", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge off economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p4 <- ggplot(data) + 
  geom_line( aes(x = time, y = mnoxyt), color = "darkblue", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mnogyt), color = "darkorange", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge off economies", y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_y_continuous( labels = label_number(accuracy = 1))

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/Accounting for Mexican Business Cycles/Submissions/2021 1 Macroeconomic Dynamics/2. R & R/2nd Round")
jpeg('figure3.jpg', quality = 1200, bg="transparent")
print( grid.arrange( p1, p2, p3, p4 ) )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")

#### 2008 crisis

# window: 12 quarters after the start of the recession

# One wedge economies
yt   = window( y, start = c( 2008, 4 ), end = c( 2011, 3 ) ); yt = yt / yt[1] * 100 
mzyt = window( mzy, start = c( 2008, 4 ), end = c( 2011, 3 ) ); mzyt = mzyt / mzyt[1] * 100
mlyt = window( mly, start = c( 2008, 4 ), end = c( 2011, 3 ) ); mlyt = mlyt / mlyt[1] * 100
mxyt = window( mxy, start = c( 2008, 4 ), end = c( 2011, 3 ) ); mxyt = mxyt / mxyt[1] * 100
mgyt = window( mgy, start = c( 2008, 4 ), end = c( 2011, 3 ) ); mgyt = mgyt / mgyt[1] * 100

# One wedge off economies
mnozyt = window( mnozy, start = c( 2008, 4 ), end = c( 2011, 3 ) ); mnozyt = mnozyt / mnozyt[1] * 100
mnolyt = window( mnoly, start = c( 2008, 4 ), end = c( 2011, 3 ) ); mnolyt = mnolyt / mnolyt[1] * 100
mnoxyt = window( mnoxy, start = c( 2008, 4 ), end = c( 2011, 3 ) ); mnoxyt = mnoxyt / mnoxyt[1] * 100
mnogyt = window( mnogy, start = c( 2008, 4 ), end = c( 2011, 3 ) ); mnogyt = mnogyt / mnogyt[1] * 100

data <- data.frame( yt,
                    mzyt,
                    mlyt,
                    mxyt,
                    mgyt,
                    mnozyt,
                    mnolyt,
                    mnoxyt,
                    mnogyt,
                    time = time( yt ),
                    base = rep( 100, length( yt ) ) )
colnames( data ) <- c( "yt", "mzyt", "mlyt", "mxyt", "mgyt",
                       "mnozyt", "mnolyt", "mnoxyt", "mnogyt",
                       "time", "base")

p1 <- ggplot(data) + 
  geom_line( aes(x = time, y = mzyt), color = "darkred", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mlyt), color = "darkgreen", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p2 <- ggplot(data) + 
  geom_line( aes(x = time, y = mxyt), color = "darkblue", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mgyt), color = "darkorange", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p3 <- ggplot(data) + 
  geom_line( aes(x = time, y = mnozyt), color = "darkred", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mnolyt), color = "darkgreen", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge off economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p4 <- ggplot(data) + 
  geom_line( aes(x = time, y = mnoxyt), color = "darkblue", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mnogyt), color = "darkorange", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge off economies", y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_y_continuous( labels = label_number(accuracy = 1))

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/Accounting for Mexican Business Cycles/Submissions/2021 1 Macroeconomic Dynamics/2. R & R/2nd Round")
jpeg('figure4.jpg', quality = 1200, bg="transparent")
print( grid.arrange( p1, p2, p3, p4 ) )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")

#### Covid crisis

# window: 4 quarters after the start of the recession

# One wedge economies
yt   = window( y, start = c( 2020, 1 ), end = c( 2020, 4 ) ); yt = yt / yt[1] * 100 
mzyt = window( mzy, start = c( 2020, 1 ), end = c( 2020, 4 ) ); mzyt = mzyt / mzyt[1] * 100
mlyt = window( mly, start = c( 2020, 1 ), end = c( 2020, 4 ) ); mlyt = mlyt / mlyt[1] * 100
mxyt = window( mxy, start = c( 2020, 1 ), end = c( 2020, 4 ) ); mxyt = mxyt / mxyt[1] * 100
mgyt = window( mgy, start = c( 2020, 1 ), end = c( 2020, 4 ) ); mgyt = mgyt / mgyt[1] * 100

# One wedge off economies
mnozyt = window( mnozy, start = c( 2020, 1 ), end = c( 2020, 4 ) ); mnozyt = mnozyt / mnozyt[1] * 100
mnolyt = window( mnoly, start = c( 2020, 1 ), end = c( 2020, 4 ) ); mnolyt = mnolyt / mnolyt[1] * 100
mnoxyt = window( mnoxy, start = c( 2020, 1 ), end = c( 2020, 4 ) ); mnoxyt = mnoxyt / mnoxyt[1] * 100
mnogyt = window( mnogy, start = c( 2020, 1 ), end = c( 2020, 4 ) ); mnogyt = mnogyt / mnogyt[1] * 100

data <- data.frame( yt,
                    mzyt,
                    mlyt,
                    mxyt,
                    mgyt,
                    mnozyt,
                    mnolyt,
                    mnoxyt,
                    mnogyt,
                    time = time( yt ),
                    base = rep( 100, length( yt ) ) )
colnames( data ) <- c( "yt", "mzyt", "mlyt", "mxyt", "mgyt",
                       "mnozyt", "mnolyt", "mnoxyt", "mnogyt",
                       "time", "base")

p1 <- ggplot(data) + 
  geom_line( aes(x = time, y = mzyt), color = "darkred", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mlyt), color = "darkgreen", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p2 <- ggplot(data) + 
  geom_line( aes(x = time, y = mxyt), color = "darkblue", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mgyt), color = "darkorange", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p3 <- ggplot(data) + 
  geom_line( aes(x = time, y = mnozyt), color = "darkred", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mnolyt), color = "darkgreen", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge off economies", y= "" ) +
  theme(text = element_text(size=14) ) 

p4 <- ggplot(data) + 
  geom_line( aes(x = time, y = mnoxyt), color = "darkblue", size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = mnogyt), color = "darkorange", size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = yt), color = "black", size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), color = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "One wedge off economies", y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_y_continuous( labels = label_number(accuracy = 1))

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/Accounting for Mexican Business Cycles/Submissions/2021 1 Macroeconomic Dynamics/2. R & R/1st Round")
jpeg('figure5.jpg', quality = 1200, bg="transparent")
print( grid.arrange( p1, p2, p3, p4 ) )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")




