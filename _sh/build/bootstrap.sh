#!/bin/sh

user='devops'
ssh="/home/$user/.ssh"

# Install updates
sudo apt-get -o Acquire::ForceIPv4=true update
sudo apt-get -y upgrade

# git
sudo apt-get -y install git

# Create user
sudo adduser --gecos "DevOps,,," $user