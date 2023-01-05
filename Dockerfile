FROM ubuntu:12.04

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND=noninteractive

# Change sources to old-releases.ubuntu.com
RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    lsb-release \
    gawk \
    wget \
    curl \
    git-core \
    subversion \
    diffstat \
    unzip \
    sysstat \
    texinfo \
    build-essential \
    chrpath \
    libsdl1.2-dev \
    xterm \
    socat \
    python \
    python3 \
    xz-utils  \
    locales \
    cpio \
    sudo \
    iputils-ping \
    iproute \
    gcc-multilib \
    g++-multilib \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -U -m -s /bin/bash -G sudo yoctouser \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && /usr/sbin/locale-gen en_US.UTF-8 \
    && echo 'dash dash/sh boolean false' | debconf-set-selections \
    && dpkg-reconfigure dash

USER yoctouser
WORKDIR /home/yoctouser
CMD /bin/bash
