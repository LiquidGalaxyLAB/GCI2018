#!/bin/bash

cd ~
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g firebase-tools
echo "press y when asked to"
sudo firebase login
echo "When asked to choose a project, choose the one where your project is initialised. Press y or enter for all other options"
sleep 5
sudo firebase init
wget https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb
sudo dpkg -i google-earth-pro-stable_current_amd64.deb
sudo apt-get install -f
sudo sed -i '/^SETTINGS {$/a     ;ViewSync settings\n    ViewSync/queryFile = /tmp/query.txt\n    ViewSync/send = true' /opt/google/earth/pro/drivers.ini
wget https://raw.githubusercontent.com/MyWorldRules/LGxVoiceControl/master/LGScript.sh
read -p "Enter Broadname: " broadname
sed -i "s/BROADNAME/$broadname/g" LGScript.sh
chmod +x LGScript.sh
echo "script is now running"
chmod +x LGScript.sh
sudo ./LGScript.sh
