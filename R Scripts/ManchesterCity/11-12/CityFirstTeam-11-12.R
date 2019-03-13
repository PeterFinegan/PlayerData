require(rvest)
library(lubridate)

# Web Scraping tutorial
# https://fcrstats.wordpress.com/2018/02/08/introduction-to-scraping-data-from-transfermarkt/

#taking the html page
page <- "https://www.transfermarkt.com/manchester-city/leihspielerhistorie/verein/281/plus/1?saison_id=2011&leihe=ist"

#assinging the page
scraped_page <- read_html(page)

#Start date of players loan
LoanStart <- scraped_page %>%html_nodes("td:nth-child(5)") %>% html_text() #%>% as.character()

#End date of players loan
LoanEnd <- scraped_page %>%html_nodes("td:nth-child(6)") %>% html_text() #%>% as.character()

#Name of players
PlayerNames <- scraped_page %>%html_nodes(".spielprofil_tooltip") %>% html_text() #%>% as.character()

#Age
Age <- scraped_page %>%html_nodes("td.zentriert:nth-child(2)") %>% html_text() #%>% as.character()

#Name of club
PlayerLoanClub <- scraped_page %>%html_nodes(".hauptlink .vereinprofil_tooltip") %>% html_text() #%>% as.character()

#image that shows the country that the club is from
LoanClubCountry <- scraped_page %>%html_nodes(".inline-table img.flaggenrahmen")

#Number of appearences made by player
PlayerAppearences <- scraped_page %>%html_nodes("td:nth-child(8)") %>% html_text() #%>% as.character()

#Market Value at the end of loan
MarketValue <- scraped_page %>% html_nodes(".rechts.hauptlink") %>% html_text() #%>% as.character()

#Market value increase/decrease
MarketFluctuation <- scraped_page %>% html_nodes(".hauptlink .icons_sprite") %>% html_text() 

#Club
club <- "Manchester City"

#taking the alt text of the Country image html attr.
#https://stackoverflow.com/questions/30693476/web-scraping-of-image
clubCountry <- html_attr(LoanClubCountry, "alt")


#Convert loan dates to date format
#https://stackoverflow.com/questions/53782218/convert-string-dates-to-date-in-r
LoanStart <- format(mdy(LoanStart),"%d/%m/%Y")

LoanEnd <- format(mdy(LoanEnd),"%d/%m/%Y")

#assiging dataframe
ManCityFirstTeam_12 <- data.frame(LoanStart, LoanEnd, PlayerNames, Age, PlayerLoanClub, clubCountry, PlayerAppearences, MarketValue, MarketFluctuation, club, stringsAsFactors=FALSE)

#converts the "-" sign to a 0
#https://stackoverflow.com/questions/53787049/converting-to-a-0-in-r
ManCityFirstTeam_12$PlayerAppearences[ManCityFirstTeam_12$PlayerAppearences == "-"] <- "0"
ManCityFirstTeam_12$PlayerAppearences <- as.numeric(ManCityFirstTeam_12$PlayerAppearences)
#ChelseaFirstTeam_10$MarketValue[ChelseaFirstTeam_10$MarketValue == "-"] <- "NA"
#ChelseaFirstTeam_10$MarketValue <- as.character(ChelseaFirstTeam_10$MarketValue)

#save to csv

write.csv(ManCityFirstTeam_12, "C:/Users/peter/Desktop/PlayerData/Manchester City/11-12/FirstTeam_11-12.csv")

write.csv(rbind(ManCityFirstTeam_12), "C:/Users/peter/Desktop/PlayerData/Manchester City/11-12/AllPlayers_11-12.csv")