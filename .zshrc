## zshoptions
# Changing Directories
setopt autocd
setopt chaselinks
# Expansion and Globbing
setopt nocaseglob
setopt extendedglob
setopt magicequalsubst
setopt nonomatch
setopt numericglobsort
setopt rcexpandparam
# History
setopt appendhistory
setopt histignorealldups
setopt histfindnodups
# Job Control
setopt checkrunningjobs
setopt longlistjobs
setopt notify
# Prompting
setopt prompt_subst
# Zle
setopt nobeep

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

autoload -Uz compinit zcalc
_comp_options+=(globdots)
autoload -Uz colors && colors

## Plugins Section
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
## Keybinding Section
bindkey -v
export KEYTIMEOUT=1
zmodload zsh/terminfo
zmodload zsh/complist
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -a '^[[3~' delete-char

## Alias Section
# Git aliases for dotfiles
alias gitcon='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias gitc='gitcon commit -S -m'

# Commonly used flags, shortcuts
alias ls='exa -a'
alias ll='exa -alh'
alias cp='cp -i'
alias fd='fd -H'
alias cls='clear'

# Color for grep and diff
alias diff='diff --color=auto'
alias grep='grep --color=auto'

# Vim & Development
alias e='vim'
alias vim='/usr/bin/nvim'
alias san='ASAN_OPTIONS=detect_leaks=1'

## Function Section
# Make and Change Directory
function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter Directory Name"
  elif [ -d $1 ]; then
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}
# Download Music
function dm {
  mkcd $HOME/Music
  youtube-dl -x --embed-thumbnail --audio-format mp3 --add-metadata $1
  cd -
}

## ZSH Settings
HISTFILE=~/.zsh/history
HISTSIZE=1000
SAVEHIST=1000
WORDCHARS=${WORDCHARS//\/[&.;]}

# Export Section
export MANPAGER='nvim +Man!'
export EDITOR='nvim'
export ARCHFLAGS="-arch x86_64"
export ASAN_OPTIONS=detect_leaks=0
export RANGER_LOAD_DEFAULT_RC=false
export GPG_TTY=$(tty)
export NPM_PACKAGES=$HOME/.npm-packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export JAVA_HOME=/usr/lib/jvm/java-15-openjdk
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

[ -f "/home/formula_one/.ghcup/env" ] && source "/home/formula_one/.ghcup/env" # ghcup-env

# Set Path
typeset -U PATH path
path=("$NPM_PACKAGES/bin" "$HOME/.cargo/bin" "$HOME/go/bin" "$path[@]")
export PATH

# Conda Setup
__conda_setup="$('/home/formula_one/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/home/formula_one/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/home/formula_one/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="/home/formula_one/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup

## FZF Section
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

## Compinit: Once a Day
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

eval "$(starship init zsh)"
