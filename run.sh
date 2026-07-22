#!/bin/sh
set -e

CONFIG_PATH=/data/options.json

if [ -f "$CONFIG_PATH" ]; then
  NAME=$(grep -o '"server_name"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_PATH" | head -1 | sed 's/.*"server_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
  ADMIN=$(grep -o '"admin_username"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_PATH" | head -1 | sed 's/.*"admin_username"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
  [ -n "$NAME" ] && export SERVER_NAME="$NAME"
  [ -n "$ADMIN" ] && export ADMIN_USERNAME="$ADMIN"
fi

exec node server.js
