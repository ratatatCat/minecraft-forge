# Minecraft moded server, v1.12.2
FROM ubuntu:16.04
MAINTAINER SteamFab <martin@steamfab.io>

USER root

# install Minecraft dependencies
RUN apt-get update && apt-get install -y \
    default-jre-headless \
    wget \
    rsyslog \
    unzip \
    locales

RUN update-ca-certificates -f

# clean up
RUN apt-get clean
RUN rm -rf /tmp/* /tmp/.[!.]* /tmp/..?*  /var/lib/apt/lists/*

# Setup locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV VERSION 1.12.2-14.23.5.2810
ENV SHELL /bin/bash
ENV NB_USER minecraft
ENV NB_UID 1000
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Create minecraft user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_USER

# download and unpack Minecraft
WORKDIR $HOME
RUN wget --quiet https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2810/forge-1.12.2-14.23.5.2810-installer.jar

# run Minecraft installer
RUN java -jar forge-$VERSION-installer.jar --installServer
RUN rm forge-$VERSION-installer.jar

# Install some mods
RUN mkdir mods
RUN cd mods/ && wget --quiet https://ore.spongepowered.org/Nucleus/Nucleus/versions/recommended/download
RUN cd mods/ && wget --quiethttps://repo.spongepowered.org/maven/org/spongepowered/spongeforge/1.12.2-2768-7.1.5/spongeforge-1.12.2-2768-7.1.5.jar
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet
RUN cd mods/ && wget --quiet

# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
