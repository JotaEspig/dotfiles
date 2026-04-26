#!/usr/bin/env sh

# Open kitty in the focused kitty shell's cwd when possible.
# Fallback: open kitty normally.

active_json="$(hyprctl activewindow -j 2>/dev/null)"

class="$(printf '%s' "$active_json" | sed -nE 's/.*"class"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/p' | head -n 1)"
pid="$(printf '%s' "$active_json" | sed -nE 's/.*"pid"[[:space:]]*:[[:space:]]*([0-9]+).*/\1/p' | head -n 1)"

if [ "$class" = "kitty" ] && [ -n "$pid" ] && [ -d "/proc/$pid" ]; then
    # Prefer common interactive shells spawned by kitty.
    shell_pid="$(ps --ppid "$pid" -o pid=,comm= 2>/dev/null | awk '
        $2 ~ /^(zsh|bash|fish|sh|dash|nu)$/ {print $1; found=1; exit}
        END { if (!found && NR > 0) print $1 }
    ' | tr -d '[:space:]')"

    if [ -n "$shell_pid" ] && [ -d "/proc/$shell_pid" ]; then
        cwd="$(readlink -f "/proc/$shell_pid/cwd" 2>/dev/null)"
        if [ -n "$cwd" ] && [ -d "$cwd" ]; then
            exec kitty --directory "$cwd"
        fi
    fi
fi

exec kitty
