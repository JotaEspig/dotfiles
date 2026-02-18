#!/bin/bash

window_class=$(hyprctl activewindow -j | jq -r '.class')
is_floating=$(echo "$active_window_json" | jq -r '.floating')

# means that the window is not floating anymore
hyprctl dispatch togglefloating
if [ "$window_class" = "kitty" ]; then
    sleep 0.1
    hyprctl dispatch resizeactive exact 1000 800
    hyprctl dispatch centerwindow
fi
