##### Code for Project 1 DS 4002
##### The Data Cavaliers

## loading in package to use dplyr and ggplot2
library(tidyverse)

# load in data
data <- read.csv("nfl_tweets.csv")

# look at data to ensure that team is classified as a factor to use in analysis
str(data)
# classify team as a factor variable
data$team<- as.factor(data$team)

# ensure levels for team are correct
str(data)
table(data$team)

################################################################
##                      EDA                                   ##
################################################################
# boxplots

# distribution of team by compound measure
ggplot(data, aes(x=team, y=compound)) + geom_boxplot() +  theme(axis.text.x = element_text(angle = 90))
# seems to be variaty of distributions that center around 0 with some teams having higher and lower distributions than others

# distribution of team by negative measure
ggplot(data, aes(x=team, y=negative)) + geom_boxplot() +  theme(axis.text.x = element_text(angle = 90))
# distributions are lower and it is somewhat difficult to tell differences, but some have higher than others

### goal is comparing 4 distributions, so it best to collapse the factor variable

# collapsing factor variable into West, South, Northeast, Midwest based on census bureau definitions of regions.
# using city as region and not necessarily fanbase
data$region<-fct_collapse(data$team, West = c("Arizona Cardinals", "Denver Broncos", "Las Vegas Raiders", "Los Angeles Chargers", "Los Angeles Rams", "San Francisco 49ers", "Seattle Seahawks"), # 7
                          South = c("Atlanta Falcons", "Baltimore Ravens", "Carolina Panthers", "Dallas Cowboys", "Houston Texans", "Jacksonville Jaguars", "Miami Dolphins", "New Orleans Saints", "Tampa Bay Buccaneers", "Tennessee Titans", "Washington Commanders"), #11
                          Northeast = c("Buffalo Bills", "New England Patriots", "New York Giants", "New York Jets", "Philadelphia Eagles", "Pittsburgh Steelers"), #6 
                          Midwest = c("Chicago Bears", "Cincinnati Bengals", "Cleveland Browns", "Detroit Lions", "Green Bay Packers", "Indianapolis Colts", "Kansas City Chiefs", "Minnesota Vikings")) #8
table(data$region)

## looking at distribution of regions in a boxplot by compound
ggplot(data, aes(x=region, y=compound)) + geom_boxplot()
# does not appear to be too much variation is distribution among regions

################################################################
##                      Checking Assumptions                  ##
################################################################
##### Independence
## the regions are independent of each other and each team is does not affect the negativity of another

#### Equal Variance
## the variance appear to be equal
# looking at distribution of regions for compound and standard deviation
tapply(data$compound, data$region, summary)   
tapply(data$compound, data$region, sd)   
# there does not appear to be much variation

#### Normality
# this assumption is met based on the roughly normal distribution as seen in density plot
# identifying histogram for density of each region based on compound
ggplot(data, aes(compound)) + geom_histogram(bins=10, aes(y=..density..), fill="light blue") + geom_density(adjust=4,(aes(group=region, color = region)))
# it appears the West has the largest density around 1


################################################################
##                      Hypothesis Testing                    ##
################################################################

# creating subsets to compare regions to northeast
data_region_N_W <- data %>% filter(region == "Northeast" | region == "West")
data_region_N_S <- data %>% filter(region == "Northeast" | region == "South")
data_region_N_M <- data %>% filter(region == "Northeast" | region == "Midwest")

### running a one-factor ANOVA to determine if there is a difference in means
summary(aov(data$compound ~ data$region))
### determined there is a difference in means

### running individual t tests to compare the NE to other regions

## northeast and west
t.test(data_region_N_W$compound ~ data_region_N_W$region)
# fail to reject null

## northeast and south
t.test(data_region_N_S$compound ~ data_region_N_S$region)
# fail to reject null

## northeast and midwest
t.test(data_region_N_M$compound ~ data_region_N_M$region)
# reject null


