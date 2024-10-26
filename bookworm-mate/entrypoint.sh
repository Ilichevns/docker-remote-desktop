#!/usr/bin/env bash

# Create the user account
groupadd --gid 1020 debian
useradd --shell /bin/bash --uid 1020 --gid 1020 --password $(openssl passwd debian) --create-home --home-dir /home/debian debian
usermod -aG sudo debian

# Start xrdp sesman service
/usr/sbin/xrdp-sesman

# Run xrdp in foreground if no commands specified
if [ -z "$1" ]; then
    /usr/sbin/xrdp --nodaemon
else
    /usr/sbin/xrdp
    exec "$@"
fi
