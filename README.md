# docbill/docker-force
A docker container to run the Force.com IDE in

## Overview

The Force.com IDE is not officially supported under Fedora, CentOS, or RHEL.   As such getting the IDE to work 100% is difficult and prone to issues every time you upgrade your laptop.   An alternative to avoid these issues is to run the Force.com IDE under a supported OS using a docker container.  This is fairly quick and easy.

 
## Quick Start

1. If you have already have docker working you can start eclipse as easily as:

	[ -d ~/workspace ] || mkdir ~/workspace
	xhost local:root
	docker run -i --net=host --rm -e DISPLAY -v $HOME/workspace/:/workspace/:z docbill/docker-force

2. For windows this was a bit more complicated.  I had to make sure Xwin (from
cygwin) was started with the -listen tcp option, and that security was 
disabled.  Once that was done the following command worked:

	docker run -i --rm -e DISPLAY=172.31.253.119:0 -v /d/cygwin64/home/docbi/workspace/:/workspace/:z docbill/docker-force

Where my ip address is 172.31.253.119, and the folder I wanted the workspace in
was D:\cygwin64\home\docbi\workspace\

3. If you want to do something more advance such as granting eclipse access to
the firefox browser on your desktop you'll need to do something more
complicated such as:

	xhost local:root
	[ -n "$WORKSPACE" ] || WORKSPACE="$HOME/workspace"
	[ -d "$WORKSPACE" ] || mkdir "$WORKSPACE"
	docker run -i --net=host --rm --name docker-force -e DISPLAY -v /var/lib/sss:/var/lib/sss:ro -v "$HOME:$HOME" -v "$WORKSPACE/.eclipse:$HOME/.eclipse" -v /tmp:/tmp:z -v "$WORKSPACE:/workspace/:z" docbill/fedora-eclipse "$@"



The first time you run the docker command it will download the image.

Project upgrades do not always work.
 
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

