#!/bin/sh

# This script runs as root

# Ensure the cardinal user owns the mounted volumes
chown -R cardinal:cardinal /usr/src/app/configs \
                            /usr/src/app/logs \
                            /usr/src/app/storage \
                            /usr/src/app/plugins

# Drop privileges and execute the main command as the cardinal user
exec gosu cardinal "$@"