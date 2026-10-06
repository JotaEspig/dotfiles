#!/usr/bin/env bash
# Emite JSON para o módulo custom/arch do waybar conforme a janela em foco:
#   fora de terminal -> classe "idle" | terminal normal -> "terminal" | terminal com root -> "root"
# Só imprime quando o estado muda.

TERMINALS='^(kitty|Alacritty|foot|org\.wezfurlong\.wezterm)$'
glyph=$'\U000F08C7'

has_root_descendant() {
    local pid child
    for child in $(pgrep -P "$1" 2>/dev/null); do
        [ "$(ps -o euid= -p "$child" 2>/dev/null | tr -d ' ')" = "0" ] && return 0
        has_root_descendant "$child" && return 0
    done
    return 1
}

last=""
while :; do
    read -r class pid < <(hyprctl activewindow -j 2>/dev/null | jq -r '"\(.class // "") \(.pid // 0)"')
    state="idle"
    if [[ "$class" =~ $TERMINALS ]]; then
        state="terminal"
        has_root_descendant "$pid" && state="root"
    fi
    if [ "$state" != "$last" ]; then
        printf '{"text":"%s","class":"%s"}\n' "$glyph" "$state"
        last="$state"
    fi
    sleep 1
done
