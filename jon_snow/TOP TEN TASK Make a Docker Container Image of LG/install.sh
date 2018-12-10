#!/bin/bash

cat << "EOM"
 _ _             _     _               _                  
| (_) __ _ _   _(_) __| |   __ _  __ _| | __ ___  ___   _ 
| | |/ _` | | | | |/ _` |  / _` |/ _` | |/ _` \ \/ / | | |
| | | (_| | |_| | | (_| | | (_| | (_| | | (_| |>  <| |_| |
|_|_|\__, |\__,_|_|\__,_|  \__, |\__,_|_|\__,_/_/\_\\__, |
        |_|                |___/                    |___/ 
https://github.com/LiquidGalaxy/liquid-galaxy
https://github.com/LiquidGalaxyLAB/liquid-galaxy
-------------------------------------------------------------

EOM

# Parameters
MASTER=true
INSTALL_DRIVERS=false
MASTER_IP=""
MASTER_USER=$USER
MASTER_HOME=$HOME
MASTER_PASSWORD=""
LOCAL_USER=$USER
MACHINE_ID="1"
MACHINE_NAME="lg"$MACHINE_ID
TOTAL_MACHINES="3"
INSTALL_DRIVERS_CHAR="n"
LG_FRAMES="lg3 lg1 lg2"
OCTET="42"
SCREEN_ORIENTATION="V"
GIT_FOLDER_NAME="liquid-galaxy"
GIT_URL="https://github.com/LiquidGalaxyLAB/liquid-galaxy"
EARTH_DEB="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.deb"
EARTH_DEB7="https://raw.githubusercontent.com/LiquidGalaxyLAB/liquid-galaxy/master/google-earth-pro7_1.deb"
if [ `getconf LONG_BIT` = "64" ]; then
EARTH_DEB="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb"
fi
EARTH_FOLDER="/opt/google/earth/pro/"
NETWORK_INTERFACE='wlp3s0'
NETWORK_INTERFACE_MAC='34:e6:ad:7f:2d:49'
SSH_PASSPHRASE=""

#
# Pre-start
#

PRINT_IF_NOT_MASTER=""
if [ $MASTER == false ]; then
	PRINT_IF_NOT_MASTER=$(cat <<- EOM

	MASTER_IP: $MASTER_IP
	MASTER_USER: $MASTER_USER
	MASTER_HOME: $MASTER_HOME
	MASTER_PASSWORD: $MASTER_PASSWORD
	EOM
	)
fi

mid=$((TOTAL_MACHINES / 2))

array=()

for j in `seq $((mid + 2)) $TOTAL_MACHINES`;
do
    array+=("lg"$j)
done

for j in `seq 1 $((mid+1))`;
do
    array+=("lg"$j)
done

printf -v LG_FRAMES "%s " "${array[@]}"

if [ $INSTALL_DRIVERS_CHAR == "y" ] || [$INSTALL_DRIVERS_CHAR == "Y" ] ; then
	INSTALL_DRIVERS=true
fi

cat << EOM

Liquid Galaxy will be installed with the following configuration:
MASTER: $MASTER
LOCAL_USER: $LOCAL_USER
MACHINE_ID: $MACHINE_ID
MACHINE_NAME: $MACHINE_NAME $PRINT_IF_NOT_MASTER
TOTAL_MACHINES: $TOTAL_MACHINES
OCTET (UNIQUE NUMBER): $OCTET
INSTALL_DRIVERS: $INSTALL_DRIVERS
GIT_URL: $GIT_URL 
GIT_FOLDER: $GIT_FOLDER_NAME
EARTH_DEB: $EARTH_DEB
EARTH_FOLDER: $EARTH_FOLDER
NETWORK_INTERFACE: $NETWORK_INTERFACE
NETWORK_MAC_ADDRESS: $NETWORK_INTERFACE_MAC

Is it correct? Press any key to continue or CTRL-C to exit
EOM

if [ "$(cat /etc/os-release | grep NAME=\"Ubuntu\")" == "" ]; then
	echo "Warning!! This script is meant to be run on an Ubuntu OS. It may not work as expected."
	echo -n "Press any key to continue or CTRL-C to exit"
fi

# General
#

export DEBIAN_FRONTEND=noninteractive

# Update OS
echo "Checking for system updates..."
apt-get update

echo "Upgrading system packages ..."
apt-get -yqf upgrade

echo "Installing new packages..."
apt-get install -yq git chromium-browser nautilus openssh-server sshpass squid3 squid-cgi apache2 xdotool unclutter

if [ $INSTALL_DRIVERS == true ] ; then
	echo "Installing extra drivers..."
	apt-get install -yq libfontconfig1:i386 libx11-6:i386 libxrender1:i386 libxext6:i386 libglu1-mesa:i386 libglib2.0-0:i386 libsm6:i386
	apt-get install nvidia-361
fi


# OS config tweaks (like disabling idling, hiding launcher bar, ...)
echo "Setting system configuration..."
tee /etc/lightdm/lightdm.conf > /dev/null << EOM
[Seat:*]
autologin-guest=false
autologin-user=$LOCAL_USER
autologin-user-timeout=0
autologin-session=ubuntu
EOM
echo autologin-user=lg >> /etc/lightdm/lightdm.conf
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
echo -e 'Section "ServerFlags"\nOption "blanktime" "0"\nOption "standbytime" "0"\nOption "suspendtime" "0"\nOption "offtime" "0"\nEndSection' | tee -a /etc/X11/xorg.conf > /dev/null
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1
update-alternatives --set x-www-browser /usr/bin/chromium-browser
update-alternatives --set gnome-www-browser /usr/bin/chromium-browser
apt-get remove --purge -yq update-notifier*

#
# Liquid Galaxy
#

# Setup Liquid Galaxy files
echo "Setting up Liquid Galaxy..."
git clone $GIT_URL

cp -r $GIT_FOLDER_NAME/earth/ $HOME
ln -s $EARTH_FOLDER $HOME/earth/builds/latest
awk '/LD_LIBRARY_PATH/{print "export LC_NUMERIC=en_US.UTF-8"}1' $HOME/earth/builds/latest/googleearth | tee $HOME/earth/builds/latest/googleearth > /dev/null

# Enable solo screen for slaves
if [ $MASTER != true ]; then
	sed -i -e 's/slave_x/slave_'${MACHINE_ID}'/g' $HOME/earth/kml/slave/myplaces.kml
	sed -i -e 's/sync_nlc_x/sync_nlc_'${MACHINE_ID}'/g' $HOME/earth/kml/slave/myplaces.kml
fi

cp -r $GIT_FOLDER_NAME/gnu_linux/home/lg/. $HOME

cd $HOME"/dotfiles/"
for file in *; do
    mv "$file" ".$file"
done
cp -r . $HOME
cd - > /dev/null

cp -r $GIT_FOLDER_NAME/gnu_linux/etc/ $GIT_FOLDER_NAME/gnu_linux/patches/ $GIT_FOLDER_NAME/gnu_linux/sbin/ /

chmod 0440 /etc/sudoers.d/42-lg
ln -s /etc/apparmor.d/sbin.dhclient /etc/apparmor.d/disable/
apparmor_parser -R /etc/apparmor.d/sbin.dhclient
 /etc/init.d/apparmor restart > /dev/null
 chown -R $LOCAL_USER:$LOCAL_USER $HOME
 chown $LOCAL_USER:$LOCAL_USER /home/lg/earth/builds/latest/drivers.ini

# Configure SSH
if [ $MASTER == true ]; then
	echo "Setting up SSH..."
	$HOME/tools/clean-ssh.sh
else
	echo "Starting SSH files sync with master..."
	sshpass -p "$MASTER_PASSWORD" scp -o StrictHostKeyChecking=no $MASTER_IP:$MASTER_HOME/ssh-files.zip $HOME/
	unzip $HOME/ssh-files.zip -d $HOME/ > /dev/null
	cp -r $HOME/ssh-files/etc/ssh /etc/
	cp -r $HOME/ssh-files/root/.ssh /root/ 2> /dev/null
	cp -r $HOME/ssh-files/user/.ssh $HOME/
	rm -r $HOME/ssh-files/
	rm $HOME/ssh-files.zip
fi
chmod 0600 $HOME/.ssh/lg-id_rsa
chmod 0600 /root/.ssh/authorized_keys
chmod 0600 /etc/ssh/ssh_host_dsa_key
chmod 0600 /etc/ssh/ssh_host_ecdsa_key
chmod 0600 /etc/ssh/ssh_host_rsa_key
chown -R $LOCAL_USER:$LOCAL_USER $HOME/.ssh

# prepare SSH files for other nodes (slaves)
if [ $MASTER == true ]; then
	mkdir -p ssh-files/etc
	cp -r /etc/ssh ssh-files/etc/
	mkdir -p ssh-files/root/
	cp -r /root/.ssh ssh-files/root/ 2> /dev/null
	mkdir -p ssh-files/user/
	cp -r $HOME/.ssh ssh-files/user/
	zip -FSr "ssh-files.zip" ssh-files
	if [ $(pwd) != $HOME ]; then
		mv ssh-files.zip $HOME/ssh-files.zip
	fi
	chown -R $LOCAL_USER:$LOCAL_USER $HOME/ssh-files.zip
	rm -r ssh-files/
fi

# Screens configuration
cat > $HOME/personavars.txt << 'EOM'
DHCP_LG_FRAMES="lg3 lg1 lg2"
DHCP_LG_FRAMES_MAX=3

FRAME_NO=$(cat /home/lg/frame 2>/dev/null)
DHCP_LG_SCREEN="$(( ${FRAME_NO} + 1 ))"
DHCP_LG_SCREEN_COUNT=1
DHCP_OCTET=42
DHCP_LG_PHPIFACE="http://lg1:81/"

DHCP_EARTH_PORT=45678
DHCP_EARTH_BUILD="latest"
DHCP_EARTH_QUERY="/tmp/query.txt"

DHCP_MPLAYER_PORT=45680
EOM
sed -i "s/\(DHCP_LG_FRAMES *= *\).*/\1\"$LG_FRAMES\"/" $HOME/personavars.txt
sed -i "s/\(DHCP_LG_FRAMES_MAX *= *\).*/\1$TOTAL_MACHINES/" $HOME/personavars.txt
sed -i "s/\(DHCP_OCTET *= *\).*/\1$OCTET/" $HOME/personavars.txt
$HOME/bin/personality.sh $MACHINE_ID $OCTET > /dev/null

# Network configuration
tee -a "/etc/network/interfaces" > /dev/null << EOM
auto eth0
iface eth0 inet dhcp
EOM
sed -i "s/\(managed *= *\).*/\1true/" /etc/NetworkManager/NetworkManager.conf
echo "SUBSYSTEM==\"net\",ACTION==\"add\",ATTR{address}==\"$NETWORK_INTERFACE_MAC\",KERNEL==\"$NETWORK_INTERFACE\",NAME=\"eth0\"" | tee /etc/udev/rules.d/10-network.rules > /dev/null
sed -i '/lgX.liquid.local/d' /etc/hosts
sed -i '/kh.google.com/d' /etc/hosts
sed -i '/10.42./d' /etc/hosts
tee -a "/etc/hosts" > /dev/null 2>&1 << EOM
10.42.$OCTET.1  lg1
10.42.$OCTET.2  lg2
10.42.$OCTET.3  lg3
10.42.$OCTET.4  lg4
10.42.$OCTET.5  lg5
10.42.$OCTET.6  lg6
10.42.$OCTET.7  lg7
10.42.$OCTET.8  lg8
EOM
sed -i '/10.42./d' /etc/hosts.squid
tee -a "/etc/hosts.squid" > /dev/null 2>&1 << EOM
10.42.$OCTET.1  lg1
10.42.$OCTET.2  lg2
10.42.$OCTET.3  lg3
10.42.$OCTET.4  lg4
10.42.$OCTET.5  lg5
10.42.$OCTET.6  lg6
10.42.$OCTET.7  lg7
10.42.$OCTET.8  lg8
EOM
tee "/etc/iptables.conf" > /dev/null << EOM
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [43616:6594412]
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -p tcp -m multiport --dports 22 -j ACCEPT
-A INPUT -s 10.42.0.0/16 -p udp -m udp --dport 161 -j ACCEPT
-A INPUT -s 10.42.0.0/16 -p udp -m udp --dport 3401 -j ACCEPT
-A INPUT -p tcp -m multiport --dports 81,8111 -j ACCEPT
-A INPUT -s 10.42.$OCTET.0/24 -p tcp -m multiport --dports 80,3128,3130 -j ACCEPT
-A INPUT -s 10.42.$OCTET.0/24 -p udp -m multiport --dports 80,3128,3130 -j ACCEPT
-A INPUT -s 10.42.$OCTET.0/24 -p tcp -m multiport --dports 9335 -j ACCEPT
-A INPUT -s 10.42.$OCTET.0/24 -d 10.42.$OCTET.255/32 -p udp -j ACCEPT
-A INPUT -j DROP
-A FORWARD -j DROP
COMMIT
*nat
:PREROUTING ACCEPT [52902:8605309]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [358:22379]
:POSTROUTING ACCEPT [358:22379]
COMMIT
EOM

# Launch on boot
mkdir -p $HOME/.config/autostart/
echo -e "[Desktop Entry]\nName=LG\nExec=bash "$HOME"/bin/startup-script.sh\nType=Application" > $HOME"/.config/autostart/lg.desktop"

# Web interface
if [ $MASTER == true ]; then
	echo "Installing web interface (master only)..."
	apt-get -yq install php php-cgi libapache2-mod-php
	touch /etc/apache2/httpd.conf
	sed -i '/accept.lock/d' /etc/apache2/apache2.conf
	rm /var/www/html/index.html
	cp -r $GIT_FOLDER_NAME/php-interface/. /var/www/html/
	chown -R $LOCAL_USER:$LOCAL_USER /var/www/html/
fi

# Cleanup
rm -r $GIT_FOLDER_NAME

#
# Global cleanup
#

echo "Cleaning up..."
apt-get -yq autoremove

if [ `getconf LONG_BIT` = "64" ]; then
echo “Installing additional libraries for 64 bit OS”
apt-get install -y libfontconfig1:i386 libx11-6:i386 libxrender1:i386 libxext6:i386 libglu1-mesa:i386 libglib2.0-0:i386 libsm6:i386
fi

echo "Liquid Galaxy installation completed! :-)"
echo "Press ENTER key to reboot now"
reboot

exit 0

