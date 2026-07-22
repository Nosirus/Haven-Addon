#!/bin/sh
set -e

CONFIG_PATH=/data/options.json
ENV_FILE="${HAVEN_DATA_DIR:-/config/addons_config/haven}/.env"

if [ -f "$CONFIG_PATH" ]; then
  NAME=$(grep -o '"server_name"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_PATH" | head -1 | sed 's/.*"server_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
  ADMIN=$(grep -o '"admin_username"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_PATH" | head -1 | sed 's/.*"admin_username"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

  if [ -n "$NAME" ]; then
    export SERVER_NAME="$NAME"
    if [ -f "$ENV_FILE" ]; then
      sed -i "s/^SERVER_NAME=.*/SERVER_NAME=$NAME/" "$ENV_FILE" || true
      grep -q "^SERVER_NAME=" "$ENV_FILE" || echo "SERVER_NAME=$NAME" >> "$ENV_FILE"
    fi
  fi

  if [ -n "$ADMIN" ]; then
    export ADMIN_USERNAME="$ADMIN"
    if [ -f "$ENV_FILE" ]; then
      sed -i "s/^ADMIN_USERNAME=.*/ADMIN_USERNAME=$ADMIN/" "$ENV_FILE" || true
      grep -q "^ADMIN_USERNAME=" "$ENV_FILE" || echo "ADMIN_USERNAME=$ADMIN" >> "$ENV_FILE"
    fi
  fi
fi

exec node server.js
