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

if [[ -d /usr/share/oh-my-zsh ]]; then
  export ZSH=/usr/share/oh-my-zsh
elif [[ -d ~/.oh-my-zsh ]]; then
  export ZSH=~/.oh-my-zsh
fi

source $ZSH/oh-my-zsh.sh

export BROWSER=qutebrowser

# Run the last command with sudo
alias please='echo -e "Fine."; eval "sudo $(fc -ln -1)"'

# Access cli weather
alias weather='curl wttr.in/80528'


function proxy() {
  PROXY='http://proxy.houston.hpecorp.net:8080'
  export http_proxy=$PROXY
  export HTTP_PROXY=$PROXY
  export https_proxy=$PROXY
  export HTTPS_PROXY=$PROXY
  export ftp_proxy=$PROXY
  export FTP_PROXY=$PROXY
  export no_proxy='localhost,127.0.0.1,/var/run/docker.sock'
  export NO_PROXY='localhost,127.0.0.1,/var/run/docker.sock'
}

function noproxy() {
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset ftp_proxy
  unset FTP_PROXY
}

# Load plugins from ~/.zsh_plugins.txt
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

autoload -U +X bashcompinit && bashcompinit
if [ -f /usr/local/bin/vault ]; then
  complete -o nospace -C /usr/local/bin/vault vault
fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

export PATH=$PATH:~/.local/bin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
