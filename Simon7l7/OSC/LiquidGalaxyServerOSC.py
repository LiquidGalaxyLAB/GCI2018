import argparse
import math

import os


from pythonosc import dispatcher
from pythonosc import osc_server



def data_handler(addr):
    print(addr)
    if addr == "/btn1/1":
        os.system("plink lg@lg1 -pw margate01 \"echo 'flytoview=<LookAt><longitude>-73.985303</longitude><latitude>40.748460</latitude><altitude>0</altitude><heading>-147.000000</heading><tilt>62.000000</tilt><range>1817</range><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>'> /tmp/query.txt\"")
        print(1)
    elif addr == "/btn2/1":
        os.system("plink lg@lg1 -pw margate01 \"echo 'flytoview=<LookAt><longitude>121.4981287411351</longitude><latitude>31.2397149331515</latitude><altitude>0</altitude><heading>-48.78189093439979</heading><tilt>64.56281385188321</tilt><range>1695.115340158771</range><altitudeMode>relativeToGround</altitudeMode></LookAt>'> /tmp/query.txt\"")
        print(2)
    elif addr == "/btn3/1":
        os.system("plink lg@lg1 -pw margate01 \"echo 'flytoview=<LookAt><longitude>-0.127360</longitude><latitude>51.499404</latitude><altitude>0</altitude><heading>49.000000</heading><tilt>62.000000</tilt><range>374</range><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>'> /tmp/query.txt\"")
        print(3)
    elif addr == "/btn4/1":
        os.system("plink lg@lg1 -pw margate01 \"echo 'flytoview=<LookAt><longitude>-122.478469</longitude><latitude>37.820118</latitude><altitude>0</altitude><heading>135.000000</heading><tilt>76.000000</tilt><range>2809</range><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>'> /tmp/query.txt\"")
        print(4)
    elif addr == "/btn5/1":
        os.system("plink lg@lg1 -pw margate01 \"echo 'flytoview=<Camera><longitude>151.2214029820703</longitude><latitude>-33.85367077770335</latitude><altitude>207.1795327618231</altitude><heading>-90.6822609492343</heading><tilt>74.18569523263631</tilt><roll>-2.018597890945746</roll><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></Camera>'> /tmp/query.txt\"")
        print(5)
    elif addr == "/btn6/1":
        os.system("plink lg@lg1 -pw margate01 \"echo 'planet=earth'> /tmp/query.txt\"")
        print(6)
    elif addr == "/btn7/1":
        os.system("plink lg@lg1 -pw margate01 \"echo 'planet=moon'> /tmp/query.txt\"")
        print(7)
    elif addr == "/btn8/1":
        os.system("plink lg@lg1 -pw margate01 \"echo 'planet=mars'> /tmp/query.txt\"")
        print(8)
    else:
        print("Error")


    
if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("--ip",
      default="192.168.1.25", help="The ip to listen on")
  parser.add_argument("--port",
      type=int, default=5005, help="The port to listen on")
  args = parser.parse_args()

  dispatcher = dispatcher.Dispatcher()
  dispatcher.map("/btn1/1", data_handler)
  dispatcher.map("/btn2/1", data_handler)
  dispatcher.map("/btn3/1", data_handler)
  dispatcher.map("/btn4/1", data_handler)
  dispatcher.map("/btn5/1", data_handler)
  dispatcher.map("/btn6/1", data_handler)
  dispatcher.map("/btn7/1", data_handler)
  dispatcher.map("/btn8/1", data_handler)

  server = osc_server.ThreadingOSCUDPServer(
      (args.ip, args.port), dispatcher)
  print("Serving on {}".format(server.server_address))
  server.serve_forever()
