# NFL Fanbase Sentiment Analysis

## Repository Contents

This repository contains code, data and figures for a data science project investigating negativity in NFL fan bases across the country through sentiment analysis of tweets. This project was created as part of the Data Science Project Course (DS 4002)  at the University of Virginia in the Fall of 2022.

## Source Code

Source code for this project can be found in the `src` directory of this repository.

### Installing/Building Code in this Repository

After cloning or forking this repository, its contents can be used to recreate different parts of this project. A Twitter developer account is required to access the Twitter API and recreate the data collection portion of this project. Additionally, the required modules and packages used in Python and R for this project are listed below.

### Modules and Packages Used in this Project

#### Python Modules

This project makes use of the following Python modules:
- `nltk` - to perform sentiment analysis
- `pandas` - to manipulate data
- `re` - to filter out retweets in the dataset
- `tweetpy` - to access the Twitter API

#### R Packages

This project makes use of the following R packages:
- `dplyr` - to manipulate data
- `ggplot2` - to create figures
- `tidyverse` - package containing `dplyr`, `ggplot2` and other data analysis tools

### Usage of Code in this Repository

The code in this repository consists of 2 files: `NFL_tweets.py` ([src](src/NFL_tweets.py)) and `project1code.R` ([src](src/project1Code.R)). The `NFL_tweets.py` file contains code used for data collection. In this file, the Twitter API token is authenticated, then the code loops through each NFL team's hashtag, mines 1000 tweets using the hashtag as the keyword and calculates the sentiment score of each tweet. It then compiles all the information into one dataframe and removes duplicate retweet values. The `project1code.R` file contains the code used for the exploratory data analysis portion of this project, creating relevant figures and hypothesis testing.

## Data

The dataset for this project was compiled using the Twitter API. In conjunction with Python, tweets were mined that contained specific hashtags related to each of the NFL's 32 teams. Each tweet was sorted by which team it related to and a sentiment score was calculated for each one using `VADER` sentiment analysis from the `nltk` Python module. To start, 1000 tweets were collected for hashtags related to each team, totaling in a dataset of 32,000 tweets. However, after removing duplicate retweets, roughly 13,000 original tweets remained. The tweets collected were the most recent found and so reflect recent sentiments expressed by Twitter users. The dataset can be found in CSV format in the `data` directory of this repository in `nfl_tweets.csv` ([src](data/nfl_tweets.csv)).

### Data Dictionary

| Variable | Data Type | Description | Example |
|----------|-----------|-------------|---------|
| text | String | The text of the tweet | 'Let's go Bills! #BillsMafia' |
| team | String | The team whose hashtag is found in the tweet | 'Buffalo Bills' |
| compound | Numeric | The overall sentiment score of the tweet, ranging from -1 to 1 with -1 being most negative and 1 being most positive | 0.5 |
| negative | Numeric | The negative sentiment score of the tweet, ranging from 0 to 1 with 0 being least negative and 1 being most negative | 0.4 |
| positive | Numeric | The positive sentiment score of the tweet, ranging from 0 to 1 with 0 being least positive and 1 being most positive | 0.6 |
| neutral | Numeric | The neutral sentiment score of the tweet, ranging from 0 to 1, 0 being least neutral, 1 being most neutral | 0 |

Note that the data for this project was collected using the Twitter API, which requires a Twitter developer account.

## Figures

Figures for this project can be found in the `figures` directory of this repository.

### Table of Contents

| Figure Name | Variables | Summary |
|-------------|-----------|---------|
| Boxplot Compound by Region | x = Region, y = Compound | There are no clear differences in the distributions between regions for the compound score. The medians for all appear to be the same, with the West being the most condensed. |
| Boxplot Compound by Team | x = Team, y = Compound | There are clear differences in the distributions between teams for the compound score. The New England Patriots have the lowest distribution and the Dallas Cowboys have the most condensed distribution around the median. |
| Boxplot Negative by Team | x = Team, y = Compound | There are clear differences in distributions between teams for negative score. Some teams have little to no negative ratings above 0, while others have a more visble distribution. All distributions have a median around 0. | 
| Histogram Density Compound by Region | x = Compound, y = Density, colored density curves by Region | This density plot shows a roughly normal distribution for each region, with a large density around the median. The West has the highest density around the median and the Midwest has the lowest. | 

## References

[1]	N. Starlight, “What's Toxic Fandom and What Creates It?,”The Arena Media Brands, LLC. April, 1, 2022. [Online], Available: https://reelrundown.com. [Accessed Sept. 7, 2022].

[2]	T. Thompson, “NFL Power Rankings: Counting Down the NFL's Rudest Fanbases,” Bleacher Report Inc. March, 29, 2011. [Online], Available: https://bleacherreport.com. [Accessed Sept. 7, 2022].

[3]	“Geographic Levels,” United States Census Bureau. Oct. 8, 2021. [Online], Available: https://census.gov. [Accessed Sept. 14, 2022].

[4]	“Choosing the Correct Statistical Test In SAS, STATA, SPSS and R,” UCLA Advanced Research Computing. [Online], Available: https://stats.oarc.ucla.edu. [Accessed Sept 14, 2022].

Files documenting the previous 2 milestones of this project can be found in the `milestones` directory of this repository in `M1Hypothesis.pdf` ([src](milestones/MI1Hypothesis.pdf)) and `MI2EstablishDataAndAnalysisPlan.pdf` ([src](milestones/MI2EstablishDataAndAnalysisPlan.pdf)).
