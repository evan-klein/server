#!/bin/sh

# Constants
user="devops"
home="/home/$user"
ssh="$home/.ssh"
ssh_config="$ssh/config"

# SSH directory
sudo chmod -Rf 700 $ssh
sudo chown -Rf $user:$user $ssh

# SSH config
sudo chmod -f 700 $ssh_config
sudo chown -f $user:$user $ssh_config