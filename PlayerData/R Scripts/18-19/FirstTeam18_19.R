require(rvest)
library(lubridate)

# Web Scraping tutorial
# https://fcrstats.wordpress.com/2018/02/08/introduction-to-scraping-data-from-transfermarkt/

#taking the html page
page <- "https://www.transfermarkt.com/chelsea-fc/leihspielerhistorie/verein/631/plus/1?saison_id=2018&leihe=ist"

#assinging the page
scraped_page <- read_html(page)

#Start date of players loan
LoanStart <- scraped_page %>%html_nodes(".bg_gruen_20 .zentriert:nth-child(5)") %>% html_text() #%>% as.character()

#End date of players loan
LoanEnd <- scraped_page %>%html_nodes(".bg_gruen_20 .zentriert:nth-child(6)") %>% html_text() #%>% as.character()

#Name of players
PlayerNamesChels <- scraped_page %>%html_nodes(".bg_gruen_20 .spielprofil_tooltip") %>% html_text() #%>% as.character()

#Age
Age <- scraped_page %>%html_nodes(".bg_gruen_20 .zentriert:nth-child(2)") %>% html_text() #%>% as.character()

#Name of club
PlayerLoanClub <- scraped_page %>%html_nodes(".bg_gruen_20 .hauptlink .vereinprofil_tooltip") %>% html_text() #%>% as.character()

#image that shows the country that the club is from
LoanClubCountry <- scraped_page %>%html_nodes(".bg_gruen_20 .inline-table img.flaggenrahmen")

#Number of appearences made by player
PlayerAppearences <- scraped_page %>%html_nodes(".bg_gruen_20 .zentriert:nth-child(8)") %>% html_text() #%>% as.character()


#taking the alt text of the Country image html attr.
#https://stackoverflow.com/questions/30693476/web-scraping-of-image
clubCountry <- html_attr(LoanClubCountry, "alt")


#Convert loan dates to date format
#https://stackoverflow.com/questions/53782218/convert-string-dates-to-date-in-r
LoanStart <- format(mdy(LoanStart),"%d/%m/%Y")

LoanEnd <- format(mdy(LoanEnd),"%d/%m/%Y")

#assiging dataframe
ChelseaFirstTeam_19 <- data.frame(LoanStart, LoanEnd, PlayerNamesChels, Age, PlayerLoanClub, clubCountry, PlayerAppearences, stringsAsFactors=FALSE)

#https://stackoverflow.com/questions/53787049/converting-to-a-0-in-r
ChelseaFirstTeam_19$PlayerAppearences[ChelseaFirstTeam_19$PlayerAppearences == "-"] <- "0"
ChelseaFirstTeam_19$PlayerAppearences <- as.numeric(ChelseaFirstTeam_19$PlayerAppearences)

#save to csv
write.csv(ChelseaFirstTeam_19, "C:/Users/peter/Desktop/PlayerData/18-19/FirstTeam_18-19.csv")

write.csv(rbind(ChelseaFirstTeam_18, ChelseaFirstTeam_19, ChelseaU23_19), "C:/Users/peter/Desktop/PlayerData/AllPlayers.csv")
write.csv(rbind(ChelseaFirstTeam_19, ChelseaU23_19), "C:/Users/peter/Desktop/PlayerData/18-19/AllPlayers_18-19.csv")