#!/bin/sh

# General
hostname='hostname'
fqdn="$hostname.example.com"
time_zone='America/Los_Angeles'
default_editor='/bin/nano'

apt_daily_timer='/usr/local/lib/evan-klein/server/cfg/systemd/apt-daily.timer'
apt_daily_upgrade_timer='/usr/local/lib/evan-klein/server/cfg/systemd/apt-daily-upgrade.timer'

supervisor_enabled=true
caddy_enabled=true
nodejs_enabled=true
utilities_enabled=true

reboot=true