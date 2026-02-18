#!/bin/bash

if [[ "$1" == "--save" ]]; then
    timestamp=$(date +%s)
    outfile="$HOME/Pictures/screenshot_$timestamp.png"
    grim -g "$(slurp)" - | tee "$outfile" | wl-copy
    notify-send "Screenshot saved & copied" "$outfile"
else
    grim -g "$(slurp)" - | wl-copy
fi

