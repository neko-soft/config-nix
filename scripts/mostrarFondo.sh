#!/usr/bin/env bash

STATE_FILE="/tmp/hyprland_prev_ws_dual"
MON1="eDP-1"
MON2="HDMI-A-1"
EMPTY_WS1="100"
EMPTY_WS2="101"

if [[ -f $STATE_FILE ]]; then
  # Restaurar workspaces anteriores
  read -r ws1 ws2 < "$STATE_FILE"
  hyprctl dispatch workspace "$ws1"
  hyprctl dispatch workspace "$ws2"
  rm "$STATE_FILE"
else
  # Guardar workspaces actuales
  ws1=$(hyprctl monitors -j | jq -r '.[] | select(.name=="'"$MON1"'") | .activeWorkspace.id')
  ws2=$(hyprctl monitors -j | jq -r '.[] | select(.name=="'"$MON2"'") | .activeWorkspace.id')
  echo "$ws1 $ws2" > "$STATE_FILE"
  
  # Ir a workspaces vacíos
  hyprctl dispatch focusmonitor $MON1
  hyprctl dispatch workspace "$EMPTY_WS1"

  hyprctl dispatch focusmonitor $MON2
  hyprctl dispatch workspace "$EMPTY_WS2"
fi
