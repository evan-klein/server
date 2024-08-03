#!/bin/sh

# Constants
user="devops"
home="/home/$user"
ssh="$home/.ssh"
ssh_config="$ssh/config"
php_error_log='/var/log/php-error.log'

# SSH directory
sudo chmod -Rf 700 $ssh
sudo chown -Rf $user:$user $ssh

# SSH config
sudo chmod -f 700 $ssh_config
sudo chown -f $user:$user $ssh_config

# PHP error log
sudo chmod -f 664 $php_error_log
sudo chown -f www-data:www-data $php_error_log