require(rvest)
library(lubridate)

# Web Scraping tutorial
# https://fcrstats.wordpress.com/2018/02/08/introduction-to-scraping-data-from-transfermarkt/

#taking the html page
page <- "https://www.transfermarkt.com/chelsea-fc-u23/leihspielerhistorie/verein/9250/plus/1?saison_id=2015&leihe=ist"

#assinging the page
scraped_page <- read_html(page)

#Start date of players loan
LoanStart <- scraped_page %>%html_nodes("td:nth-child(5)") %>% html_text() #%>% as.character()

#End date of players loan
LoanEnd <- scraped_page %>%html_nodes("td:nth-child(6)") %>% html_text() #%>% as.character()

#Name of players
PlayerNamesChels <- scraped_page %>%html_nodes(".spielprofil_tooltip") %>% html_text() #%>% as.character()

#Age
Age <- scraped_page %>%html_nodes("td.zentriert:nth-child(2)") %>% html_text() #%>% as.character()

#Name of club
PlayerLoanClub <- scraped_page %>%html_nodes(".hauptlink .vereinprofil_tooltip") %>% html_text() #%>% as.character()

#image that shows the country that the club is from
LoanClubCountry <- scraped_page %>%html_nodes(".inline-table img.flaggenrahmen")

#Number of appearences made by player
PlayerAppearences <- scraped_page %>%html_nodes("td:nth-child(8)") %>% html_text() #%>% as.character()


#taking the alt text of the Country image html attr.
#https://stackoverflow.com/questions/30693476/web-scraping-of-image
clubCountry <- html_attr(LoanClubCountry, "alt")


#Convert loan dates to date format
#https://stackoverflow.com/questions/53782218/convert-string-dates-to-date-in-r
LoanStart <- format(mdy(LoanStart),"%d/%m/%Y")

LoanEnd <- format(mdy(LoanEnd),"%d/%m/%Y")

#assiging dataframe
ChelseaU23_16 <- data.frame(LoanStart, LoanEnd, PlayerNamesChels, Age, PlayerLoanClub, clubCountry, PlayerAppearences, stringsAsFactors=FALSE)

#converts the "-" sign to a 0
#https://stackoverflow.com/questions/53787049/converting-to-a-0-in-r
ChelseaU23_16$PlayerAppearences[ChelseaU23_16$PlayerAppearences == "-"] <- "0"
ChelseaU23_16$PlayerAppearences <- as.numeric(ChelseaU23_16$PlayerAppearences)

#save to csv

write.csv(ChelseaU23_16, "C:/Users/peter/Desktop/PlayerData/15-16/Under23s_15-16.csv")

write.csv(rbind(ChelseaFirstTeam_16, ChelseaFirstTeam_17, ChelseaFirstTeam_18, ChelseaFirstTeam_19, ChelseaU23_19, ChelseaU23s_18, ChelseaU23s_17, ChelseaU23_16), "C:/Users/peter/Desktop/PlayerData/AllPlayers.csv")
write.csv(rbind(ChelseaFirstTeam_16, ChelseaU23_16), "C:/Users/peter/Desktop/PlayerData/15-16/AllPlayers_15-16.csv")