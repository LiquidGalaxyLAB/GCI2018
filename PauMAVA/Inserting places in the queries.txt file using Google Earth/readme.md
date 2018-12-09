# About
This script was developed for GoogleCodeIn 2018 contest and for Liquid Galaxy 's orgatization. Get the liquid galaxy core from https://github.com/LiquidGalaxyLAB/liquid-galaxy and learn more about the project in liquidgalaxy.org
# Prerequisites

In order to run this script, you'll need the following:
- An **Ubuntu** installation (Tested on 18.04).
- **Google Earth Pro**, it's deb file can be downloaded from: https://www.google.com/earth/download/gep/agree.html
After the download execute this commands on your terminal:

    `sudo apt-get install gdebi`
    `sudo gdebi path_to_the_google_earth_package.deb`
- **Liquid Galaxy Core** from https://github.com/LiquidGalaxyLAB/liquid-galaxy. Follow installation instructions from their readme.md.
- Package **curl**, it can be installed issuing the following command on the terminal: 
`sudo apt-get install curl`
 
 Any other requirements will be supplied automatically by the script.

# Utility
This bash script takes certain data from a kmz file and writes it on /var/www/http/queries.txt in this format:
**Teide Mountain (Spain)**
   

     @Earth@Teide@flytoview=<LookAt><longitude>-16.62972190880223</longitude><latitude>28.24500918646396</latitude><altitude>0</altitude><heading>-1.02710320710307</heading><tilt>65.63268174357455</tilt><range>13286.04774162735</range><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>

# Usage
The first thing you must do is to open a terminal instance and issue this command: 
`bash <(curl -s https://raw.githubusercontent.com/PauMAVA/query-write/master/QueryWrite.sh)` 

The script will check for the packages: **unzip** and **libxml2-utils** that are needed to run the script correctly. If those are not installed in your system the it will ask you: 

    This script needs Unzip in order to work correctly. Do you want to install it?  [Y/N]

or/and

    This script needs xmllint in order to work correctly. Do you want to install it?  [Y/N]
If you input **Y** the package will be installed on your machine (you may be asked for password confirmation) and if you select **N** the script will exit.

**Note:** It is mandatory to have select **Y** if you want to use the script.

If you had these packages already installed the script will skip this step.

Next, you will be asked to provide the .kmz file directory:

    Input kmz file location (incuding file and extension): 
   Here you must insert the full directory including the extension, as it will be stored as a variable:
  
  **Example** - If your file is in your desktop then you should input:
  

    /home/Username/Desktop/filename.kmz
   
After this step the script will create a temporal directory and will extract the **kml** from the **kmz** file by converting it to a **zip** and extracting it using **unzip**.

The script will also convert the kml file to xml file and using `xmllint --xpath` commands will praise data elements. The output given should be:

    Praised data field name = *string*
    Praised data field latitude = *value*
    Praised data field longitude = *value*
    Praised data field altitude = *value*
    Praised data field tilt = *value*
    Praised data field range = *value*

Afterwards, you will be asked if the altitude parameter is relative to the sea or relative to the ground. 

    Is altitude relative to sea floor? [Y/N]

Input **Y** if it is relative to the sea or **N** if it's relative to the ground.

Also the script will require you to specify which celestial body is the placemark on:

    Celestial Body (Earth, Moon, Mars)? [E/M/A]

Choose **E** for Earth, **M** for the Moon and **A** for Mars.

Finally the script will wait 5 seconds before writing the new data to the queries.txt **in case you want to abort**.

**Note:** No data from queries.txt will be overwritten.

The script will write the data to queries.txt and exit. 

# Queries.txt location
This script is configured in a way that the queries.txt is found into `/var/www/html/queries.txt`. If this file is on another directory in your system you have two options.

The frist one is to move the queries.txt file to the preconfigured directory and the second one is to change it on the lines 106, 108 and 111 of the code. For example if your queries.txt is found in the Desktop of your machine the original code should be:

    106. echo "@$celestialBody@$name@flytoview=<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><altitude>$altitude</altitude><heading>$heading</heading><tilt>$tilt</tilt><range>$range</range><gx:altitudeMode>$gxAltitudeMode</gx:altitudeMode><\LookAt>" >> /var/www/html/queries.txt
    108. echo "@$celestialBody@$name@flytoview=<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><altitude>$altitude</altitude><heading>$heading</heading><tilt>$tilt</tilt><range>$range</range><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>$gxAltitudeMode</gx:altitudeMode><\LookAt>" >> /var/www/html/queries.txt
    111. echo "Data written for $kmzroute in var/www/html/queries.txt"
 And the modified one:

    106. echo "@$celestialBody@$name@flytoview=<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><altitude>$altitude</altitude><heading>$heading</heading><tilt>$tilt</tilt><range>$range</range><gx:altitudeMode>$gxAltitudeMode</gx:altitudeMode><\LookAt>" >> home/Username/Desktop/queries.txt"
    108. echo "@$celestialBody@$name@flytoview=<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><altitude>$altitude</altitude><heading>$heading</heading><tilt>$tilt</tilt><range>$range</range><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>$gxAltitudeMode</gx:altitudeMode><\LookAt>" >> home/Username/Desktop/queries.txt"
    111. echo "Data written for $kmzroute in home/Username/Desktop/queries.txt"

# Usage Example
![Alt Text](https://media.giphy.com/media/1lBJjvphW5FHYmA2Y4/giphy.gif)
