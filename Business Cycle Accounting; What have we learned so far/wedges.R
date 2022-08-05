######  Accounting for Mexican Business Cycles
######  Business Cycle Accounting: what have we learned so far?
######  Brinca, Pedro, Costa-Filho, João and Loria, Francesca

# This code prepares the graphs for the dynamics of the wedges. 

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Business Cycle Accounting; What have we learned so far/BCA")

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

start = c( 1965, 1); end = c( 2020, 4 )

# Wedges
a    <- ts( results[["worktemp"]][[20]][[6]], start = start, frequency = 4 )  # efficiency
taul <- ts( results[["worktemp"]][[20]][[8]], start = start, frequency = 4 )  # labor 
taux <- ts( results[["worktemp"]][[20]][[10]], start = start, frequency = 4 ) # investment
g    <- ts( results[["worktemp"]][[20]][[5]], start = start, frequency = 4 )  # government consumption + net exports


#### Graphs - wedges ####

# window: 12 quarters after the start of the recession

start  = c( 1972, 4 ); end = c( 1976, 1 )
start2 = c( 1989, 4 ); end2 = c( 1993, 1 )

#Efficiency

r1 = window( a, start = start, end = end ); r1 = r1 / r1[1] * 100 
r2 = window( a, start = start2, end = end2 ); r2 = r2 / r2[1] * 100

max.len = max( length(r1), length(r2) )

r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )


data <- data.frame( r1, r2, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p1 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "solid", colour = "darkblue") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "solid", colour = "darkred") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = TeX( "$A_t$" ), y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1)) 


#Labor

r1 = window( taul, start = start, end = end ); r1 = r1 / r1[1] * 100 
r2 = window( taul, start = start2, end = end2 ); r2 = r2 / r2[1] * 100

max.len = max( length(r1), length(r2) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )

data <- data.frame( r1, r2, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p2 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "solid", colour = "darkblue") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "solid", colour = "darkred") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = TeX( "$\\tau_{l,t}$" ), y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1))  


#Investment

r1 = window( taux, start = start, end = end ); r1 = r1 / r1[1] * 100 
r2 = window( taux, start = start2, end = end2 ); r2 = r2 / r2[1] * 100

max.len = max( length(r1), length(r2) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )

data <- data.frame( r1, r2, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p3 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "solid", colour = "darkblue") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "solid", colour = "darkred") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = TeX( "$\\tau_{x,t}$" ), y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1)) 


#Government Consumption + net exports

r1 = window( g, start = start, end = end ); r1 = r1 / r1[1] * 100 
r2 = window( g, start = start2, end = end2 ); r2 = r2 / r2[1] * 100

max.len = max( length(r1), length(r2) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )

data <- data.frame( r1, r2, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p4 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "solid", colour = "darkblue") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "solid", colour = "darkred") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = TeX( "$g_t$" ), y= "" ) +
  theme(text = element_text(size=14) ) + 
  scale_x_continuous(breaks = seq(-1, 12, by = 1), labels = label_number(accuracy = 1))  


setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/Business Cycle Accounting; What have we learned so far/Submission/2. JES/2. R & R/1st Round")
jpeg('figure1.jpg', quality = 1200, bg="transparent")
print( grid.arrange( p1, p2, p3, p4 ) )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Business Cycle Accounting; What have we learned so far/BCA")


#### Graphs - simulations ####

start = c( 1965, 1)

# One wedge economies
# output
y   <- ts( results[["worktemp"]][[20]][[2]], start = start, frequency = 4 )  # output data
mzy <- ts( results[["worktemp"]][[20]][[18]], start = start, frequency = 4 ) # efficiency only
mly <- ts( results[["worktemp"]][[20]][[21]], start = start, frequency = 4 ) # labor only
mxy <- ts( results[["worktemp"]][[20]][[24]], start = start, frequency = 4 ) # investment only
mgy <- ts( results[["worktemp"]][[20]][[27]], start = start, frequency = 4 ) # government consumption + net exports only

# One wedge off economies
# output
mnozy <- ts( results[["worktemp"]][[20]][[30]], start = start, frequency = 4 ) # no efficiency
mnoly <- ts( results[["worktemp"]][[20]][[33]], start = start, frequency = 4 ) # no labor 
mnoxy <- ts( results[["worktemp"]][[20]][[36]], start = start, frequency = 4 ) # no investment
mnogy <- ts( results[["worktemp"]][[20]][[39]], start = start, frequency = 4 ) # no government consumption + net exports

#### 1973 recession

# window: 12 quarters after the start of the recession

start  = c( 1972, 4 ); end = c( 1976, 1 )

# One wedge economies
yt   = window( y, start = start, end = end ); yt = yt / yt[1] * 100 
mzyt = window( mzy, start = start, end = end ); mzyt = mzyt / mzyt[1] * 100
mlyt = window( mly, start = start, end = end ); mlyt = mlyt / mlyt[1] * 100
mxyt = window( mxy, start = start, end = end ); mxyt = mxyt / mxyt[1] * 100
mgyt = window( mgy, start = start, end = end ); mgyt = mgyt / mgyt[1] * 100

# One wedge off economies
mnozyt = window( mnozy, start = start, end = end ); mnozyt = mnozyt / mnozyt[1] * 100
mnolyt = window( mnoly, start = start, end = end ); mnolyt = mnolyt / mnolyt[1] * 100
mnoxyt = window( mnoxy, start = start, end = end ); mnoxyt = mnoxyt / mnoxyt[1] * 100
mnogyt = window( mnogy, start = start, end = end ); mnogyt = mnogyt / mnogyt[1] * 100

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

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/Business Cycle Accounting; What have we learned so far/Submission/2. JES/2. R & R/1st round")
jpeg('figure2.jpg', quality = 1200, bg="transparent")
print( grid.arrange( p1, p2, p3, p4 ) )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Business Cycle Accounting; What have we learned so far/BCA")

#### 1990 recession

# window: 12 quarters after the start of the recession

start = c( 1989, 4 ); end = c( 1993, 1 )

# One wedge economies
yt   = window( y, start = start, end = end ); yt = yt / yt[1] * 100 
mzyt = window( mzy, start = start, end = end ); mzyt = mzyt / mzyt[1] * 100
mlyt = window( mly, start = start, end = end ); mlyt = mlyt / mlyt[1] * 100
mxyt = window( mxy, start = start, end = end ); mxyt = mxyt / mxyt[1] * 100
mgyt = window( mgy, start = start, end = end ); mgyt = mgyt / mgyt[1] * 100

# One wedge off economies
mnozyt = window( mnozy, start = start, end = end ); mnozyt = mnozyt / mnozyt[1] * 100
mnolyt = window( mnoly, start = start, end = end ); mnolyt = mnolyt / mnolyt[1] * 100
mnoxyt = window( mnoxy, start = start, end = end ); mnoxyt = mnoxyt / mnoxyt[1] * 100
mnogyt = window( mnogy, start = start, end = end ); mnogyt = mnogyt / mnogyt[1] * 100

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

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Working Papers/Business Cycle Accounting; What have we learned so far/Submission/2. JES/2. R & R/1st round")
jpeg('figure3.jpg', quality = 1200, bg="transparent")
print( grid.arrange( p1, p2, p3, p4 ) )
dev.off()
setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Business Cycle Accounting; What have we learned so far/BCA")




