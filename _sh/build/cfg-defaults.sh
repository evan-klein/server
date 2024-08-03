#!/bin/sh

# General
hostname='hostname'
fqdn="$hostname.example.com"
time_zone='America/Los_Angeles'
default_editor='/bin/nano'

fail2ban_enabled=true
fail2ban_jails='/usr/local/lib/evan-klein/server/cfg/fail2ban/*.local'

supervisor_enabled=true

caddy_enabled=true

php_enabled=true
php_error_log='/var/log/php-error.log'

nodejs_enabled=true

utilities_enabled=true

apt_daily_timer='/usr/local/lib/evan-klein/server/cfg/systemd/apt-daily.timer'
apt_daily_upgrade_timer='/usr/local/lib/evan-klein/server/cfg/systemd/apt-daily-upgrade.timer'

evan_bot_server_monitor_enabled=true
evan_bot_server_monitor_cfg='/usr/local/lib/evan-klein/evan-bot-server-monitor/cfg.json'
evan_bot_server_monitor_cron='/usr/local/lib/evan-klein/evan-bot-server-monitor/cron'

reboot=true