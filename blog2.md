Back to cameronw-16 [main page](index.md)

## Twitter data 'use case'

#### From [PLOS](https://journals.plos.org/plosone/): ["Who Tweets with Their Location? Understanding the Relationship between Demographic Characteristics and the Use of Geoservices and Geotagging on Twitter"](10.1371/journal.pone.0142209)
Authors: Luke Sloan and Jeffery Morgan

This research adresses two principle questions:

•	"RQ1: Are there any demographic differences between users who do or do not enable local services on Twitter?" 
•	"RQ2: Are there any demographic differences between users who do or do not geotag their tweets?"

In order to answer these questions, the authors collect the free 1% feed of the Twitter API in April of 2015. For each tweet that they downloaded, the profile data of the tweet's author (aka the user data) was retrieved from the time of the April tweet and subsequently stored. The other tweets of each user were also examined to see if any happened to be geotagged during April. This created a data table of user information along with a binary flag colmun indicating whether a user used geotagging on tweets. Retweets cannot be geotagged, so data from retweets could only be used to answer question RQ1.

Based off of the information provided in this article, the research is reproducable and replicable with an in-depth knowledge of computer driven statistacal analysis. The author includes a section on data availability including replication instructions and links. To use the exact same data used in this study, a reproducer would have to use the twitter user ID numbers in the authors' releasable data and re-derive the metadata from the individual users. In [this 2013 article](https://doi.org/10.5153/sro.3001) and this [other 2015 article](10.1371/journal.pone.0115545) solely focusing on methods/techniques previously created by Luke Sloan et al. and then referenced used in his primary article linked at the top of the page. The programs used, the uncertainties that come with those programs, the changes made to the data prior to entering it into the program. The demographic data extracted by these tweets could be added into a table to be analyzed in R. An interesting and helpful aspect of Luke Sloan (and others) articles is that he talks thorugh the failures with the data analysis and then explains the steps taken to resolve those failures. 

Programs Used:
Gender ID: 40,000 Namen (40N) database - method taken from Michael 2007 + text cleaning methods
preferred language ID: Language Detection Library for Java (LDLJ 2012)
Location ID:  YAHOO!\ PlaceFinder(2012) geographic database + smaller data sample size extraction
Class/Occupation ID: COSMOS class engine - Luke Sloan et al. 2015

Conclusions
- women are more likely to enable location services (+0.8% as compared to males)
- men are more likely to geotag tweets (+0.1% as compared to women)
- generally a slightly older population that enables geotagging (+0.82 years) and location services (+0.55 years)
- users with Russian interface and/or tweeted in Russian were least likely to enable location services
- Turkis Portuguese and Indonesian user interfaces were the most likely to enable location services and geotag tweets
- Lower managerial, administrative and professional occupations are most likely to geottag
