#!/usr/bin/env python3
import requests
from bs4 import BeautifulSoup
URL = 'http://whatthecommit.com'
page = requests.get(URL)
soup = BeautifulSoup(page.content, 'html.parser')
commitmsg = soup.find(id='content').find_next('p').text.strip()
permalink= URL+soup.find(class_ = 'permalink').find_next('a')['href']
print(commitmsg)#Comment ales vous
