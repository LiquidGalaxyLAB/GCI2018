# Continuing on from previous script
# If the file checkExists.txt exists, then add the required ";ViewSync..." to the file at the specified position

if [ -f ~/AssistantwLG/checkExists.txt ]; then
	cd /opt/google/earth/pro
	sudo sed -i '/CPUVertexBlendEfficiency = 1.2/i \;ViewSync settings\nViewSync/queryFile = /tmp/query.txt\nViewSync/send = true' drivers.ini
 	

	cd ~/AssistantwLG

# Getting LGScript.sh from GitHub

	wget https://raw.githubusercontent.com/MyWorldRules/LGxVoiceControl/master/LGScript.sh

# Getting and assigning broad name
	value=`cat ~/AssistantwLG/checkExists.txt`
	sudo sed -i 's/BROADNAME/'$value'/g' LGScript.sh
	echo "" > save.txt
	chmod +x LGScript.sh

# Delete the checkExists file so this script does not run every power-on.
	rm checkExists.txt

# Open Google Earth
	google-earth-pro
	sleep 60

# Run LGScript.sh
	sudo ./LGScript.sh

fi
