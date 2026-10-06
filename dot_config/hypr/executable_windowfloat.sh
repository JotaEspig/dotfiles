#!/bin/bash

active_window_json=$(hyprctl activewindow -j)
window_class=$(echo "$active_window_json" | jq -r '.class')
is_floating=$(echo "$active_window_json" | jq -r '.floating')

hyprctl dispatch "hl.dsp.window.float({ action = 'toggle' })"

# is_floating is the state *before* the toggle: false means it just became floating
if [ "$is_floating" = "false" ] && [ "$window_class" = "kitty" ]; then
    sleep 0.1
    hyprctl dispatch "hl.dsp.window.resize({ exact = true, x = 1000, y = 800 })"
    hyprctl dispatch "hl.dsp.window.center()"
fi
