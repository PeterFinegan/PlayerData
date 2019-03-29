from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup

my_url = 'https://www.pro-football-reference.com/teams/crd/2015_injuries.htm'

# opening up connection, grabbing the page
uClient = uReq(my_url)
page_html = uClient.read()
uClient.close()

# html parsing
page_soup = soup(page_html, "html.parser")

containers = page_soup.find("tbody")
head = page_soup.find("thead")


player = containers.find_all("tr")

weeks = head.find_all('th')
week_list = [i['data-stat'] for i in weeks][1:]

for week in week_list:
    for tr in player:
        th = tr.find_all("th")
        name = [i.text for i in th]

        td = tr.find('td', {'data-stat':week})
        week = td["data-stat"]

        try:
            injury = td["data-tip"]
            print(week)
        except KeyError:
            injury = "NA"
            print(week)
