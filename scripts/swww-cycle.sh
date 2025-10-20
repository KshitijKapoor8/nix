#!/usr/bin/env bash
DIR="$HOME/nix/wallpapers"

# start daemon if needed
pgrep -x swww-daemon >/dev/null || (
    swww-daemon &
    sleep 0.2
)

# pick a random image (common formats)
IMG=$(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n 1)

# set it
swww img "$IMG" --transition-type fade --transition-duration 0.8
