#!/bin/sh
if [ -f /data/options.json ]; then
  NAME=$(sed -n 's/.*"server_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' /data/options.json)
  ADMIN=$(sed -n 's/.*"admin_username"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' /data/options.json)
  PUBURL=$(sed -n 's/.*"public_url"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' /data/options.json)
  [ -n "$NAME" ] && export SERVER_NAME="$NAME"
  [ -n "$ADMIN" ] && export ADMIN_USERNAME="$ADMIN"
  [ -n "$PUBURL" ] && export PUBLIC_URL="$PUBURL"
fi
