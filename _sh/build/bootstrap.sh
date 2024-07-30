#!/bin/sh

user='devops'
ssh="/home/$user/.ssh"
log='/var/log/evan-klein'

# Install updates
sudo apt-get -o Acquire::ForceIPv4=true update
sudo apt-get -y upgrade

# git
sudo apt-get -y install git

# Create user
sudo adduser --gecos "DevOps,,," $user
echo "$user ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$user

# Make directories and files
mkdir $ssh/
mkdir -p /etc/evan-klein/server/
mkdir $log/
touch $log/server.log
touch $log/bootstrap.log
touch $log/build.log

# Set permissions
curl --silent --show-error https://raw.githubusercontent.com/evan-klein/server/master/_sh/reset-perms.sh > ~/.reset-perms.sh
sh ~/.reset-perms.sh

# Clean up
rm ~/.reset-perms.sh