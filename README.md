# Server

Server build scripts and config files for a Ubuntu server.

Compatible with Ubuntu Server 24.04 LTS or newer.

## DevOps cheat sheet

### Caddy

#### Reload running configuration

```sh
caddy reload --config /etc/caddy/Caddyfile
```

### PHP-FPM

#### Reload

```sh
sudo systemctl reload php8.3-fpm
```

#### Restart

```sh
sudo systemctl restart php8.3-fpm
```

#### Start

```sh
sudo systemctl start php8.3-fpm
```

#### Stop

```sh
sudo systemctl stop php8.3-fpm
```

#### Status

```sh
sudo systemctl status php8.3-fpm
```