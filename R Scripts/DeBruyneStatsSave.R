require(rvest)
library(lubridate)
library(tidyverse)
# Web Scraping tutorial
# https://fcrstats.wordpress.com/2018/02/08/introduction-to-scraping-data-from-transfermarkt/

#taking the html page
page <- "https://www.transfermarkt.com/kevin-de-bruyne/leistungsdatendetails/spieler/88755/saison//verein/0/liga/0/wettbewerb//pos/0/trainer_id/0/plus/1"

#assinging the page
scraped_page <- read_html(page)

#Start date of players loan
Seasons <- scraped_page %>%html_nodes("tbody .zentriert:nth-child(1)") %>% html_text() #%>% as.character()

#Appearences 
Apps <- scraped_page %>%html_nodes(".zentriert+ td a") %>% html_text() #%>% as.character()

#Convert loan dates to date format
#https://stackoverflow.com/questions/53782218/convert-string-dates-to-date-in-r
#Seasons <- format(mdy(Seasons),"%d/%m/%Y")


#assiging dataframe
DeBruyne <- data.frame(Seasons, Apps, stringsAsFactors=FALSE)

DeBruyne$Apps[DeBruyne$Apps == "-"] <- "0"
DeBruyne$Apps <- as.numeric(DeBruyne$Apps)



  Seasons <- format(mdy(Seasons),"%d/%m/%Y")


write.csv(Statistics, "C:/Users/peter/Desktop/DeBruyne.csv")

