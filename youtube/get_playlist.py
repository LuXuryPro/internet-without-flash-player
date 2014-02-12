#-*- coding: utf-8 -*-
import requests
import sys
import re

if len (sys.argv) < 2:
    print "Usage:"
    print sys.argv[0] + " [youtube playlist link]"
    sys.exit(1)

link = sys.argv[1]
id = re.findall(".*list=(.*)",link)[0]

request_api_url = "https://gdata.youtube.com/feeds/api/playlists/{0}?v=2&alt=json"
try:
    data = requests.get(request_api_url.format(id)).json()
    for entry in data['feed']['entry']:
        print entry['link'][0]['href'].strip("&feature=youtube_gdata")
except:
    pass
