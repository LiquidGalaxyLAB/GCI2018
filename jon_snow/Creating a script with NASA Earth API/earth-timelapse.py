import requests
import json
import shutil
import os
from datetime import datetime, timedelta
from subprocess import call
import time
import sys
import argparse
import imageio

#Make API call, return response body in JSON format
def call_api(lat, lon, date):
    response = requests.get("https://api.nasa.gov/planetary/earth/imagery/?lon="+str(lon)+"&lat="+str(lat)+"&date="+date+"&cloud_score=True&api_key="+api_key)
    return response.json()

def get_image(url, filename):
    path = './data/' +  filename + ".png"
    response = requests.get(url, stream=True)
    out = open(path, "wb")
    shutil.copyfileobj(response.raw, out)
    return out.name

# Get all the suitable images from between 2 dates

def create_timelapse(lat, lon, start, end, clouds, cloudscore, interval):

    delta = timedelta(days=float(interval))
    while end > start:
        response = call_api(lat, lon, start)
        while response is None:
            print("Api Call Fail: Waiting 10 seconds before retry...")
            time.sleep(10)
            response = call_api(lat, lon, start)
        print("Api Call")
        try:
            if clouds:
                if response["cloud_score"] > cloudscore:
                     print("Request does not match threshold")
                else:
                    get_image(response["url"], start)
                    print("Got Image")
            else:
                get_image(response["url"], start)
                print("Got Image")
        except:
            print("Internal Service Error")

        start = datetime.strptime(start, "%Y-%m-%d") + delta
        start = start.strftime("%Y-%m-%d")

    # Create gif

    images = []
    for filename in os.listdir(r'C:\Users\Lenovo\Desktop\Google Code in\Nasa api timelapse\data'):
        filename = './data/' + filename
        images.append(imageio.imread(filename))
    imageio.mimsave('./data/gif.gif', images, duration=args.duration)


parser = argparse.ArgumentParser (description="Create timelapse from nasa earth image api")
parser.add_argument("--latitude")
parser.add_argument("--longitude")
parser.add_argument("--start", help="Starting date in form YYYY-MM-DD")
parser.add_argument("--end", help="Ending date in form YYYY-MM-DD")
parser.add_argument("--interval", help="Interval at which pictures are to be taken.", type=int)
parser.add_argument("--apikey", help="NASA API key")
parser.add_argument("--clouds", help = "Incude clouds in timelapse? Defaults to false", default=False, action='store_true')
parser.add_argument("--cloudscore", help="Maximum value for cloudscore to include in timelapse, default = 0.1, maximum = 1.0", type=float)
parser.add_argument("--duration", help="Duration of one picture", type=int)

args = parser.parse_args()




cloudscore = 0.1
if args.cloudscore is not None:
    cloudscore = float(args.cloudscore)


# Prepare data directory to store images
if not os.path.exists('./data'):
    os.makedirs('./data')
api_key=args.apikey

#Call main function
create_timelapse(args.latitude, args.longitude, args.start, args.end, args.clouds, cloudscore, args.interval)


