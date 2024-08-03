#!/bin/sh

# General
hostname='hostname'
fqdn="$hostname.example.com"
time_zone='America/Los_Angeles'
default_editor='/bin/nano'

fail2ban_enabled=true
fail2ban_jails='/usr/local/lib/evan-klein/server/cfg/fail2ban/*.local'

apt_daily_timer='/usr/local/lib/evan-klein/server/cfg/systemd/apt-daily.timer'
apt_daily_upgrade_timer='/usr/local/lib/evan-klein/server/cfg/systemd/apt-daily-upgrade.timer'

supervisor_enabled=true
caddy_enabled=true
nodejs_enabled=true
utilities_enabled=true

evan_bot_auto_reboot_enabled=true
evan_bot_auto_reboot_cfg='/usr/local/lib/evan-klein/evan-bot-auto-reboot/cfg.json'
evan_bot_auto_reboot_cron='/usr/local/lib/evan-klein/evan-bot-auto-reboot/cron'

reboot=true