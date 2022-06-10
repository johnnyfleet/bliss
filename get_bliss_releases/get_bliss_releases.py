import requests
from bs4 import BeautifulSoup
import re

from wcwidth import list_versions

# Bliss blog site to scrape
URL = "https://www.blisshq.com/music-library-management-blog/tags/release/"

# Get and parse to pull all list items (and content below)
page = requests.get(URL)
soup = BeautifulSoup(page.content,"html.parser")
versions = soup.find_all("li", class_="nobullets")

lists_versions = []
for version in versions:
    version_name = version.find("a")

    # Extract out the version number, looking for matches on 8 digits together
    just_version = re.search(r"\d{8}",version_name.text)

    # If a match then append to the list.
    if bool(just_version):
        lists_versions.append(just_version.group(0))

top_5_versions = lists_versions[0:5]
# Request the header of each download path to validate available.
for version in top_5_versions:
    version_url = 'https://www.blisshq.com/downloads/bliss-install-' + version + '.jar'
    response = requests.head(version_url)
    if response.status_code == 200:
        print('Version %s exists for download.' % version_url)
    else:
        print('Version %s does not exist for download.' % version_url) 