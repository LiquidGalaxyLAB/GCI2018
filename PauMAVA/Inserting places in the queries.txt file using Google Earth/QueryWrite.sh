function installunzip {
if [ "$pkgmissingunzip" = 1 ] && [ "$installpkgunzip" = "Y" ] || [ "$installpkgunzip" = "y" ]; then
	sudo apt-get install unzip
	echo "Unzip was correctly installed"
else
	echo "Script failed! :("
	exit
fi
}

function installxmllint {
if [ "$pkgmissingxmllint" = 1 ] && [ "$installpkgxmllint" = "Y" ] || [ "$installpkgxmllint" = "y" ]; then
	sudo apt-get install libxml2-utils
	echo "Xmllint was correctly installed"
else
	echo "Script failed! :("
	exit
fi
}

pkgchkunzip=$(which unzip)

if [ "$pkgchkunzip" = "/usr/bin/unzip" ]; then
	echo "Unzip package is installed"
else
	pkgmissingunzip=1
	echo "Unzip package is not installed"
	echo "This script needs Unzip in order to work correctly. Do you want to install it?  [Y/N]"
	read -n 1 installpkgunzip
	read -p ""
	installunzip
fi

pkgchkxmllint=$(which xmllint)

if [ "$pkgchkxmllint" = "/usr/bin/xmllint" ]; then
	echo "Xmllint package is installed"
else
	pkgmissingxmllint=1
	echo "Xmllint package is not installed"
	echo "This script needs Xmllint in order to work correctly. Do you want to install it?  [Y/N]"
	read -n 1 installpkgxmllint
	read -p ""
	installxmllint
fi

echo "Proceeding with script"
echo "Input kmz file location (incuding file and extension): "
read -a kmzroute
echo "The file is in $kmzroute"
echo "Creating temporal directory"
mkdir /tmp/QueryWriteTemp
echo "Converting kmz to zip"
cp $kmzroute /tmp/QueryWriteTemp/file.zip
echo "Unzipping file to /tmp/QueryWriteTemp"
unzip /tmp/QueryWriteTemp/file.zip -d /tmp/QueryWriteTemp
cp /tmp/QueryWriteTemp/doc.kml /tmp/QueryWriteTemp/doc.xml
echo "Setting up variables and extracting data from /tmp/QueryWriteTemp/doc.xml"
name=$(xmllint --xpath "/*[local-name()='kml']/*[local-name()='Document']//*[local-name()='Placemark']/*[local-name()='name']/text()" /tmp/QueryWriteTemp/doc.xml)
latitude=$(xmllint --xpath "/*[local-name()='kml']/*[local-name()='Document']//*[local-name()='Placemark']/*[local-name()='LookAt']/*[local-name()='latitude']/text()" /tmp/QueryWriteTemp/doc.xml)
longitude=$(xmllint --xpath "/*[local-name()='kml']/*[local-name()='Document']//*[local-name()='Placemark']/*[local-name()='LookAt']/*[local-name()='longitude']/text()" /tmp/QueryWriteTemp/doc.xml)
altitude=$(xmllint --xpath "/*[local-name()='kml']/*[local-name()='Document']//*[local-name()='Placemark']/*[local-name()='LookAt']/*[local-name()='altitude']/text()" /tmp/QueryWriteTemp/doc.xml)
heading=$(xmllint --xpath "/*[local-name()='kml']/*[local-name()='Document']//*[local-name()='Placemark']/*[local-name()='LookAt']/*[local-name()='heading']/text()" /tmp/QueryWriteTemp/doc.xml)
tilt=$(xmllint --xpath "/*[local-name()='kml']/*[local-name()='Document']//*[local-name()='Placemark']/*[local-name()='LookAt']/*[local-name()='tilt']/text()" /tmp/QueryWriteTemp/doc.xml)
range=$(xmllint --xpath "/*[local-name()='kml']/*[local-name()='Document']//*[local-name()='Placemark']/*[local-name()='LookAt']/*[local-name()='range']/text()" /tmp/QueryWriteTemp/doc.xml)
echo "Praised data field name = $name"
echo "Praised data field latitude = $latitude"
echo "Praised data field longitude = $longitude"
echo "Praised data field altitude = $altitude"
echo "Praised data field tilt = $tilt"
echo "Praised data field range = $range"
echo "Is altitude relative to sea floor? [Y/N]"
read -n 1 relativeAltitude
read -p ""
if [ "$relativeAltitude" = 'Y' ] || [ "$relativeAltitude" = 'y' ]; then
	gxAltitudeMode="relativeToSeaFloor"
else
	gxAltitudeMode="relativeToGround"
fi

echo "gx:AltitudeMode parameter is set to $gxAltitudeMode"

echo "Celestial Body (Earth, Moon, Mars)? [E/M/A]"
read -n 1 celestialBodyInput
read -p ""
if [ "$celestialBodyInput" = 'E' ] || [ "$celestialBodyInput" = 'e' ]; then
	celestialBody="earth"
else
	if [ "$celestialBodyInput" = 'M' ] || [ "$celestialBodyInput" = 'm' ]; then
		celestialBody="moon"
	else
		celestialBody="mars"
	fi
fi

echo "AltitudeMode parameter is set to relativeToGround"

timer=6
while [ "$timer" != "0" ]; do
	timer=$((timer-1))
	echo -en "Writing data to file in $timer (Ctrl + C to abort)\r"
	sleep 1
done

if [ "$celestialBody" = 'earth' ]; then
	echo "@$celestialBody@$name@flytoview=<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><altitude>$altitude</altitude><heading>$heading</heading><tilt>$tilt</tilt><range>$range</range><gx:altitudeMode>$gxAltitudeMode</gx:altitudeMode><\LookAt>" >> /var/www/html/queries.txt
else
	echo "@$celestialBody@$name@flytoview=<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><altitude>$altitude</altitude><heading>$heading</heading><tilt>$tilt</tilt><range>$range</range><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>$gxAltitudeMode</gx:altitudeMode><\LookAt>" >> /var/www/html/queries.txt
fi

echo "Data written for $kmzroute in var/www/html/queries.txt"
echo "Cleaning Up"
rm -rf /tmp/QueryWriteTemp
echo "Success :)"
exit
