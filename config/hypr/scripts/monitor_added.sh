#!/bin/sh

handle() {
  case $1 in
    monitoradded*) 
    ~/.config/eww/launch_bar  
    ;;
  esac
}

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
