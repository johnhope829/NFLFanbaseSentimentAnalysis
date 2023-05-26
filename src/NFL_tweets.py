
# Import Libraries
import tweepy
import pandas as pd
import nltk
import re

from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk.sentiment.vader import SentimentIntensityAnalyzer
nltk.download('vader_lexicon')
import time

# Twitter api keys and tokens
consumerKey = ''
consumerSecret = ''
accessToken = ''
accessTokenSecret = ''

auth = tweepy.OAuthHandler(consumerKey, consumerSecret)
auth.set_access_token(accessToken, accessTokenSecret)
api = tweepy.API(auth)

# Establish hashtags and their teams

hashtags = ['#BirdCityFootball', '#DirtyBirds', '#RavensFlock',
            '#BillsMafia', '#KeepPounding', '#DaBears', '#RuleTheJungle',
            '#Browns', '#DallasCowboys', '#BroncosCountry', '#OnePride',
            '#GoPackGo', 'WeAreTexans', '#ForTheShoe', '#DUUUVAL',
            '#ChiefsKingdom', '#BoltUp', '#RamsHouse', '#FinsUp',
            '#SKOL', '#ForeverNE', '#Saints', '#TogetherBlue', '#TakeFlight',
            '#RaiderNation', '#FlyEaglesFly', '#HereWeGo', '#Seahawks',
            '#FTTB', '#GoBucs', '#Titans', '#HTTC']

teams = ['Arizona Cardinals', 'Atlanta Falcons', 'Baltimore Ravens',
         'Buffalo Bills', 'Carolina Panthers', 'Chicago Bears',
         'Cincinnati Bengals', 'Cleveland Browns', 'Dallas Cowboys',
         'Denver Broncos', 'Detroit Lions', 'Green Bay Packers',
         'Houston Texans', 'Indianapolis Colts', 'Jacksonville Jaguars',
         'Kansas City Chiefs', 'Los Angeles Chargers', 'Los Angeles Rams',
         'Miami Dolphins', 'Minnesota Vikings', 'New England Patriots',
         'New Orleans Saints', 'New York Giants', 'New York Jets', 
         'Las Vegas Raiders', 'Philadelphia Eagles', 'Pittsburgh Steelers',
         'Seattle Seahawks', 'San Francisco 49ers', 'Tampa Bay Buccaneers',
         'Tennessee Titans', 'Washington Commanders']


# Define empty lists
tweet_list = []
team_list = []
neutral_list = []
negative_list = []
positive_list = []
comp_list = []

# Go through each hashtag

for hashtag in hashtags:

    keyword = hashtag
    noOfTweet = 1000

    # Pulling 1000 tweets with the keyword hashtag
    tweets = tweepy.Cursor(api.search_tweets, q=keyword).items(noOfTweet)
    
    # Resetting the sentiment scores
    positive  = 0
    negative = 0
    neutral = 0
    polarity = 0

    for tweet in tweets:
        
        # Accessing the text and adding it to list
        tweet_list.append(tweet.text)
        
        # Append the team name
        team_list.append(teams[hashtags.index(keyword)])
        
        # Creating the sentiment scores
        score = SentimentIntensityAnalyzer().polarity_scores(tweet.text)
        
        # Append the specific scores to their lists
        comp_list.append(score['compound'])
        
        negative_list.append(score['neg'])

        positive_list.append(score['pos'])
        
        neutral_list.append(score['neu'])

    # Wait 10 minutes due to twitter API rate limit
    time.sleep(600) 

# Combine lists into one data frame
tweet_df = pd.DataFrame({'text':tweet_list,
                         'team':team_list,
                         'compound': comp_list,
                         'negative':negative_list,
                         'positive':positive_list,
                         'neutral':neutral_list})


# Removing the tweets that are retweets
tweet_df = tweet_df[tweet_df['text'].str.contains("RT @\w+: ")==False]

