#!/bin/sh
if [ -f /data/options.json ]; then
  export SERVER_NAME=$(sed -n 's/.*"server_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' /data/options.json)
  export ADMIN_USERNAME=$(sed -n 's/.*"admin_username"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' /data/options.json)
fi
