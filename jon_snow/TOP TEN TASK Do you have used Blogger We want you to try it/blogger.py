import feedparser
import requests
import time

import os
# OAuth 2.0 for Installed Applications
from oauth2client.client import flow_from_clientsecrets
# OAuth 2.0 for Server to Server Applications
from oauth2client.service_account import ServiceAccountCredentials
from httplib2 import Http
from oauth2client.client import flow_from_clientsecrets
import json
import webbrowser
import httplib2

from apiclient import discovery
from oauth2client import client
from apiclient.discovery import build
from googleapiclient import sample_tools

"""
service, flags = sample_tools.init(
    argv, 'blogger', 'v3', __doc__, __file__,
    scope='https://www.googleapis.com/auth/blogger')

scopes = ['https://www.googleapis.com/auth/blogger', 'https://www.googleapis.com/auth/blogger.readonly']
credentials = ServiceAccountCredentials.from_json_keyfile_name('<project>-<keyID>.json', scopes)
http_auth = credentials.authorize(Http())
"""
# Client Secrets
# https://developers.google.com/api-client-library/python/guide/aaa_client_secrets
flow = flow_from_clientsecrets('client_id.json',
                               scope='https://www.googleapis.com/auth/blogger',
                               redirect_uri='urn:ietf:wg:oauth:2.0:oob')
# This section copied from https://developers.google.com/api-client-library/python/auth/installed-app#example
auth_uri = flow.step1_get_authorize_url()
webbrowser.open(auth_uri)
auth_code = input('Enter the auth code: ')
credentials = flow.step2_exchange(auth_code)
http_auth = credentials.authorize(httplib2.Http())
# THis returns no errors - so what's next????

service = build('blogger', 'v3', http=http_auth)   # (api_name, api_version)


url = feedparser.parse('https://www.liquidgalaxylab.com/feeds/posts/default?redirect=false&max-results=500')

for x in url.entries:
    y = x.content[0]
    title = str(x.title)
    content = str(y.value)
    published = str(x.published)
    URL = "http://maps.googleapis.com/maps/api/geocode/json"

    PARAMS = {
        "kind": "blogger#post",
        "blog": {
            "id": "5787419028695692324"
        },
        "title": title,
        "content": content,
        "published": published,
    }
    parse = json.dumps(PARAMS)
    PARAMS2 = json.loads(parse)
    request = service.posts().insert(blogId=5787419028695692324, body=PARAMS2)
    response = request.execute()
    print(json.dumps(response, indent=4, separators=(',', ': ')))
    time.sleep(5);


