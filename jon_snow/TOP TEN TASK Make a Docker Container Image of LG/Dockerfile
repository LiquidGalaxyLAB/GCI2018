FROM ubuntu:16.04
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y wget lsb-core lsb curl
RUN apt update
RUN apt upgrade -f
RUN apt-get install -y wget curl tmux git libglib2.0-bin ssh

RUN apt-get update && apt-get install -y apt-utils dpkg ubuntu-restricted-addons gdebi wget lsb-core lsb-security lsb-invalid-mta && rm -rf /var/cache/aet/

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

RUN sh -c 'echo "deb http://dl.google.com/linux/earth/deb/ stable main" >> /etc/apt/sources.list.d/google-earth.list'

RUN apt-get update && apt-get install -y xdg-utils google-earth* && rm -rf /var/cache/a
ADD install.sh /
RUN chmod +x /install.sh
RUN /install.sh
