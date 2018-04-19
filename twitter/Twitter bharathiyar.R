# OWN TWITTER PROGRAM(1ST PRGRAM)
DO IT UR SELF IN HOME


```{r}
library(twitteR) #pulling and saving tweets
library(base64enc)
library(httr)
library(rjson)
library(bit64)
library(devtools)
library(tm) #text mining
library(ROAuth)
library(RCurl)
library(stringr)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)
library(plyr)
library(wordcloud) #wordcloud
library(syuzhet) #sentiment analysis
```
##set working directory
```{r}
knitr::opts_knit$set(root.dir ="D:/Data-Science/R/sentiment_analysis")
```

##TWEET COLLECTION AND SAVING
Downloading the tweets using specific keywords using twitteR package.
Enter the customer key and access token and the secret keys in oauth setup.
*keys are altered for security reasons*
  
  ```{r}
options(httr_oauth_cache=T)
setup_twitter_oauth(consumer_key="5k0VX79Rq7RuWulpsUxmKezli",
                    consumer_secret="aKR2iT25yGNlbWlQ5uyjfbwQgRoOMGiG27udBsfYX7aRevp48Z",
                    access_token="888461342004215808-WouB1iWgwonRur7le0jPWImnwYPmcIh", access_secret="UxTZfnEPslL1Ctor5eoHwfRIFLiiayuXazUJvedcxbKvy")
```



```{r}
#Taking Keywords of tweets we need and split to make it as list
query <- "#Bharathiyar"
query <- unlist(strsplit(query,","))
tweets = list()

#taking the tweets 
for(i in 1:length(query)){
  result<-searchTwitter(query[i],n=5000)
  tweets <- c(tweets,result)
  tweets <- unique(tweets)
}

# Create a placeholder for the file
file<-NULL

# Check if tweets.csv exists
if (file.exists("tweets.csv")){file<- read.csv("tweets.csv")}

# Merge the data in the file with our new tweets
df <- do.call("rbind", lapply(tweets, as.data.frame))
df<-rbind(df,file)
str(df)

# Remove duplicates
tw <- df[!duplicated(df[c("id")]),]
str(tw)
```


```{r}
# Save
write.csv(tw,file="tweets.csv",row.names=FALSE)
```

##READING THE FILE

```{r}
tw<-read.csv("D:/Data-science/R/sentiment_analysis/tweets.csv")

txt<-tw$text
class(txt)
txt<-as.character(txt)
View(txt)
```