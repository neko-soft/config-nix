#!/usr/bin/env bash

STATUS_FILE="$HOME/.cache/dunst_paused"
NOTIFY_ID=4545
if [[ -f "$STATUS_FILE" ]]; then
  # Desmutear
  dunstctl set-paused false
  rm "$STATUS_FILE"
  dunstify -u critical -r $NOTIFY_ID "🔔 Notificaciones activadas"
  sleep 10
  dunstctl close "$NOTIFY_ID"

else
  # Mutear
  dunstctl close-all
  dunstify -u critical -r $NOTIFY_ID "🔕 Notificaciones silenciadas"
  dunstctl set-paused true
  touch "$STATUS_FILE"
  sleep 10
  dunstctl close "$NOTIFY_ID"
  
fi
