# ============================================================
# Path (must be early so everything below sees these paths)
# ============================================================
export PATH="$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# ============================================================
# Homebrew (must be before anything that depends on brew-installed tools)
# ============================================================
eval "$(brew shellenv)"
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fpath=(/Users/cam/.docker/completions $fpath)

# ============================================================
# Oh My Zsh
# ============================================================
export ZSH="$HOME/.oh-my-zsh"

# NOTE: zsh-autosuggestions and zsh-syntax-highlighting are external plugins.
# Install via: git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
#              git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
plugins=(
  git
  docker
  kubectl
  npm
  yarn
  rust
  golang
  copypath
  copyfile
  history-substring-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ============================================================
# History
# ============================================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# ============================================================
# Completion
# ============================================================
setopt COMPLETE_IN_WORD

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Exclude . and .. from all completions
zstyle ':completion:*' file-list all
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*:*:-command-:*:*' ignored-patterns '.|..'

# ============================================================
# Aliases
# ============================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls -al'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ============================================================
# Editor
# ============================================================
export EDITOR='vim'
export VISUAL='vim'

# ============================================================
# Keybindings
# ============================================================
bindkey -e

# ============================================================
# Shell Options
# ============================================================
setopt GLOB_DOTS
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# ============================================================
# Environment
# ============================================================
export LESS='-R'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export NODE_PATH="$HOME/.config/opencode/node_modules" # additional path to help enable dotfile management of opencode

# ============================================================
# Tools (evaluated last so they can modify PATH/prompt)
# ============================================================
eval "$(fnm env --use-on-cd --shell zsh)"

if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# ============================================================
# Local overrides (machine-specific, not checked in)
# ============================================================
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# bun completions
[ -s "/Users/cam/.bun/_bun" ] && source "/Users/cam/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
