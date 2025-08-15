autoload -Uz compinit
compinit

PF_COL1=3 PF_COL2=7 PF_COL3=2 pfetch

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

KEYTIMEOUT=1
bindkey -v '^?' backward-delete-char

export EDITOR=nvim

alias ls="ls --color"
alias la="ls -lah --color"
alias lh="ls -lh --color"

alias discord='XDG_SESSION_TYPE=x11 /usr/bin/discord'

export FONTCONFIG_FILE=$HOME/.config/fontconfig/fonts.conf
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
