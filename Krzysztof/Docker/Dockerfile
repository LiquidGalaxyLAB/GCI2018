FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y install sudo

ENV user lg

RUN useradd -m -d /home/${user} ${user} && \
    chown -R ${user} /home/${user} && \
    adduser ${user} sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${user}

WORKDIR /home/${user}

RUN sudo apt-get -y install curl && \
    sudo apt-get -y install lsb-core && \
    sudo apt-get -y install lsb && \
    sudo apt-get -y upgrade -f