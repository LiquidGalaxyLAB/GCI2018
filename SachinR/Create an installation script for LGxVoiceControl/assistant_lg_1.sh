# First, we create a directory for the project and navigate to it.
mkdir ~/AssistantwLG
cd ~/AssistantwLG

# This is the broad name that the user would have assigned to the child in their Firebase realtime-database. newname is a variable where this information is stored for later use.
read -p "Enter your broad name: " newname

# Updating/upgrading the system
sudo apt-get -y update
sudo apt-get -y upgrade

# Installing curl, nodejs, and firebase.
sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - 
sudo apt-get install -y nodejs
sudo npm install -g -y firebase-tools

# Logging in to firebase
sudo firebase login

# Intializing firebase
sudo firebase init

# Downloading and installing Google Earth
wget https://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
sudo dpkg -i google-earth-stable*.deb
sudo apt-get -f install

# Create a file. We will check if it exists after rebooting
echo $newname > checkExists.txt

chmod +x ~/Downloads/assistant_lg_2.sh

# Restart the system
sudo reboot

# After reboot, if the file exists, we continue with the script in another file (assistant_lg_2.sh) 
