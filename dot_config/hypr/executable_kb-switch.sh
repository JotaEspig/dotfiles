#!/usr/bin/env bash
# Alterna entre os layouts definidos em kb_layout (us intl <-> br abnt2) e notifica.
hyprctl switchxkblayout all next >/dev/null
keymap=$(hyprctl -j devices | jq -r '[.keyboards[] | select(.main)][0].active_keymap // .keyboards[0].active_keymap')
notify-send -t 1500 -h string:x-canonical-private-synchronous:kb-layout "Teclado" "$keymap"
