FROM ubuntu:latest

ARG UID=1000
ARG GID=1000
ARG UNAME

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV container docker
ENV DEBIAN_FRONTEND=noninteractive
ENV init /lib/systemd/systemd
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
USER root

#add your user with same UID GID
#and install base packages

RUN groupadd -g $GID $UNAME && \
    useradd -m -u $UID -g $GID -s /bin/bash $UNAME && \
    echo "$UNAME:changeme" | chpasswd && \
    yes | /usr/local/sbin/unminimize && \
    apt-get update && apt-get install -y \
    ubuntu-desktop \
    aptitude \
    clang \
    emacs \
    host \
    iputils-ping \
    liblz4-tool \
    libtinfo-dev \
    net-tools \
    openconnect \
    openssh-server \
    quilt \
    rsync \
    sudo \
    systemd \
    wget \
    xxd && \
    echo "X11UseLocalhost no" > /etc/ssh/sshd_config.d/no_localhost.conf && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    sudo dpkg -i google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

RUN systemctl set-default multi-user.target && \
    adduser $UNAME sudo

ENTRYPOINT ["/lib/systemd/systemd"]
