#!/bin/sh

# Download clone-repo.sh
curl --silent --show-error https://raw.githubusercontent.com/evan-klein/server/master/_sh/clone-repo.sh > ~/.clone-repo.sh

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
sudo apt-get -y upgrade

# Install and configure UFW
sudo apt-get -y install ufw
sudo ufw default deny
sudo ufw allow 22
sudo ufw --force enable

# Set time zone
sudo timedatectl set-timezone $time_zone

# Set hostname
echo "$hostname" | sudo tee /etc/hostname
sudo hostname -F /etc/hostname

# /etc/hosts
etc_hosts="127.0.0.1\t$fqdn $hostname"
grep -qxF "$etc_hosts" /etc/hosts || echo "$etc_hosts" | sudo tee -a /etc/hosts

# .nanorc
sudo cp -f $server/cfg/.nanorc $HOME/.nanorc

# Set default editor
sudo update-alternatives --set editor $default_editor

# fail2ban
if $fail2ban_enabled; then
	sudo apt-get -y install fail2ban
	sudo cp -f "$fail2ban_jails" /etc/fail2ban/jail.d/
	sudo systemctl enable fail2ban
	sudo systemctl restart fail2ban
fi

# git
sudo apt-get -y install git

# Supervisor
if $supervisor_enabled; then
	sudo apt-get -y install supervisor
fi

# Caddy web server
if $caddy_enabled; then
	sudo ufw allow 80
	sudo ufw allow 443
	sudo apt-get -y install caddy
fi

# Node.js
if $nodejs_enabled; then
	sudo apt-get -y install nodejs
fi

# Utilities
if $utilities_enabled; then
	sudo apt-get -y install curl ntp htop mtr-tiny
fi

# Configure unattended upgrades
if [ -e "$apt_daily_timer" ] || [ -e "$apt_daily_upgrade_timer" ]; then
	if [ -e "$apt_daily_timer" ]; then
		sudo cp -f "$apt_daily_timer" /etc/systemd/system/apt-daily.timer
		sudo chmod 644 /etc/systemd/system/apt-daily.timer
	fi
	if [ -e "$apt_daily_upgrade_timer" ]; then
		sudo cp -f "$apt_daily_upgrade_timer" /etc/systemd/system/apt-daily-upgrade.timer
		sudo chmod 644 /etc/systemd/system/apt-daily-upgrade.timer
	fi

	sudo systemctl daemon-reload

	if [ -e "$apt_daily_timer" ]; then
		sudo systemctl restart apt-daily.timer
	fi
	if [ -e "$apt_daily_upgrade_timer" ]; then
		sudo systemctl restart apt-daily-upgrade.timer
	fi
fi

# Evan Bot auto reboot
if $evan_bot_auto_reboot_enabled; then
	sh ~/.clone-repo.sh evan-klein evan-bot-auto-reboot

	# Copy cfg.json
	if [ -e "$evan_bot_auto_reboot_cfg" ]; then
		sudo cp -f "$evan_bot_auto_reboot_cfg" /etc/evan-klein/evan-bot-auto-reboot/cfg.json
	fi

	# Install cron
	if [ -e "$evan_bot_auto_reboot_cron" ]; then
		sudo cp -f "$evan_bot_auto_reboot_cron" /etc/cron.d/
	fi
fi

# Clean up
rm ~/.clone-repo.sh

# Reboot
if $reboot; then
	sudo reboot
fi