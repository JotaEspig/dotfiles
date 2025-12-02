# Completion settings
autoload -Uz compinit
compinit

# Pfetch
PF_COL1=3 PF_COL2=7 PF_COL3=2 pfetch

# History settings
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Vim mode
KEYTIMEOUT=1
bindkey -v '^?' backward-delete-char

# Aliases
alias ls="ls --color --group-directories-first -X"
alias la="ls -lah --color"
alias lh="ls -lh --color"
alias discord='XDG_SESSION_TYPE=x11 /usr/bin/discord'

# Environment variables
export EDITOR=nvim
export FONTCONFIG_FILE=$HOME/.config/fontconfig/fonts.conf
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct

# Zsh plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"

# Zsh configurations
typeset -g ZLE_REMOVE_SUFFIX_CHARS=
zstyle ':completion:*' add-space true
