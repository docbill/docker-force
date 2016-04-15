# docker-force
A docker container to run the Force.com IDE in

## Overview

The Force.com IDE is not officially supported under Fedora, CentOS, or RHEL.   As such getting the IDE to work 100% is difficult and prone to issues every time you upgrade your laptop.   An alternative to avoid these issues is to run the Force.com IDE under a supported OS using a docker container.  This is fairly quick and easy.

 
## Quick Start

 
If you have already have docker working you can start eclipse as easily as:


mkdir ~/workspace
xhost local:root
sudo docker run -i --net=host --rm -e DISPLAY -v $HOME/workspace/:/workspace/ docker-force


The first time you run this command it will download the image.
 

If you do not have docker installed read on.

 
## Installing Docker On Fedora, CentOS and RHEL

 

To install docker on Fedora and RHEL7, the following commands should work:

 

sudo dnf install docker

sudo systemctl start docker

sudo systemctl enable docker

 

For older version of Fedora and RHEL6 the commands are:

 

sudo yum install docker-io

sudo service docker start

sudo chkconfig docker on



One of the things you might want to do is to set storage options to something other than loopback, as I find disk full errors can corrupt all your docker images when using loopback.

## Optional: Create a script to run

I have the following script as salesforce-ide :


#!/bin/bash
xhost local:root
[ -d "$HOME/workspace" ] || mkdir "$HOME/workspace"
exec sudo docker run -i --net=host --rm -e DISPLAY -v $HOME/workspace/:/workspace/ docbill/docker-force "$@"

This just makes running the IDE a bit easier.

## Optional: Create Gnome Application

For a desktop application you simply need to install a file as ~/.local/share/applications/Docker_Force_IDE.desktop :

[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec="/home/docbill/bin/salesforce-ide"
Categories=Application;Development;
Name=Docker Force.com IDE
Name[en_US]=Docker Force.com IDE
Comment="The Force.com IDE is a powerful client application for creating, modifying, testing and deploying Force.com applications. Based on the Eclipse platform, it provides a comfortable environment for programmers familiar with integrated development environments, allowing you to code, compile, test, and deploy all from within the IDE itself."
Comment[en_US]="The Force.com IDE is a powerful client application for creating, modifying, testing and deploying Force.com applications. Based on the Eclipse platform, it provides a comfortable environment for programmers familiar with integrated development environments, allowing you to code, compile, test, and deploy all from within the IDE itself."
Icon=/home/docbill/bin/salesforce-ide.xpm
Icon[en_US]=/home/docbill/bin/salesforce-ide

Be sure to change the home directory from /home/docbil .   The xpm icon is attached.

