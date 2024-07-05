#!/bin/sh

. '/usr/local/lib/evan-klein/server/_sh/build/cfg-defaults.sh'
. '/etc/evan-klein/server/cfg.sh'

# Shortcuts
lib='/usr/local/lib'
lib_ek="$lib/evan-klein"
server="$lib_ek/server"

# Create symlinks
sudo ln -sfT $lib/ $HOME/lib
sudo ln -sfT $lib_ek/ $HOME/lib-ek
sudo ln -sfT /etc/evan-klein/server/cfg.sh $HOME/cfg.sh
sudo ln -sfT /srv/ $HOME/srv
sudo ln -sfT /var/log/ $HOME/log

# Install updates
sudo apt-get -o Acquire::ForceIPv4=true update
sudo apt-get upgrade -y