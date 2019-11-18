Back to cameronw-16 [main page](index.md)

## Twitter data 'use case'

#### From [PLOS](https://journals.plos.org/plosone/): ["Who Tweets with Their Location? Understanding the Relationship between Demographic Characteristics and the Use of Geoservices and Geotagging on Twitter"](10.1371/journal.pone.0142209)
Authors: Luke Sloan and Jeffery Morgan

This research adresses two principle questions:

•	"RQ1: Are there any demographic differences between users who do or do not enable local services on Twitter?" 
•	"RQ2: Are there any demographic differences between users who do or do not geotag their tweets?"

In order to answer these questions, the authors collect the free 1% feed of the Twitter API in April of 2015. For each tweet that they downloaded, the profile data of the tweet's author (aka the user data) was retrieved from the time of the April tweet and subsequently stored. The other tweets of each user were also examined to see if any happened to be geotagged during April. This created a data table of user information along with a binary flag colmun indicating whether a user used geotagging on tweets. Retweets cannot be geotagged, so data from retweets could only be used to answer question RQ1.

Based off of the information provided in this article, the research would be reproducable but possibly not replicable with an in-depth knowledge of computer science. In [this longer article](https://doi.org/10.5153/sro.3001) solely focusing on methods/techniques previously created by the author and then referenced used in his primary article linked at the top of the page. The programs used, the uncertainties that come with those programs, the changes made to the data prior to entering it into the program. The demographic data extracted by these tweets could be added into a table to be analyzed in R. 



List of programs used:
Gender ID: 40,000 Namen (40N) database - method taken from Michael 2007 + text cleaning methods
preferred language ID: Language Detection Library for Java (LDLJ 2012)
Country ID:  YAHOO!\ PlaceFinder(2012) geographic database + smaller data sample size extraction
