bindkey -e

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

export PROMPT="%1~ %F{green}%#%f "

export PACMAN_AUTH=run0
export AUR_PACMAN_AUTH=run0

bindkey "\E[H" beginning-of-line
bindkey "\E[F" end-of-line
bindkey "\E[3~" delete-char

bindkey '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY 
