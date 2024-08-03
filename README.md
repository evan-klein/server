# Server

Server build scripts and config files for a Ubuntu server.

Compatible with Ubuntu Server 24.04 LTS or newer.

## DevOps cheat sheet

### Caddy

#### Reload running configuration

```sh
caddy reload --config /etc/caddy/Caddyfile
```

### PHP

#### Reload

```
sudo systemctl reload php8.3-fpm
```

#### Restart

```
sudo systemctl restart php8.3-fpm
```

#### Start

```
sudo systemctl start php8.3-fpm
```

#### Stop

```
sudo systemctl stop php8.3-fpm
```

#### Status

```
sudo systemctl status php8.3-fpm
```