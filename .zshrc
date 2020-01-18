HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify # Unset the bell
bindkey -e # Use emacs keybindings for terminal
zstyle :compinstall filename '/home/brandon/.zshrc'

# Autocompletion
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES # Allow aliases in autocomplete
zstyle ':completion::complete:*' gain-privileges 1 # Allow autocomplete to work with sudo

ttyctl -f # Force terminal to not freeze

### Rehash command cache after pacman updates ###
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
### End cache ###

add-zsh-hook -Uz precmd rehash_precmd

export EDITOR=vim

ZSH_THEME="agnoster"

export ZSH=/usr/share/oh-my-zsh
source $ZSH/oh-my-zsh.sh

export BROWSER=qutebrowser

# Run the last command with sudo
alias please='echo -e "Fine."; eval "sudo $(fc -ln -1)"'

# Access cli weather
alias weather='curl wttr.in/80528'

# Load plugins from ~/.zsh_plugins.txt
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt
