# Create zcompdump files outside of the home directory
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# =====================================================================================================================
# Exports
# =====================================================================================================================
# GPG vars
export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='nvim'
export SUDO_EDITOR="$EDITOR"

# Ruby
export BUNDLE_SUPPRESS_INSTALL_USING_MESSAGES=true
export BUNDLE_AUTO_INSTALL=true

# Misc
export BAT_THEME=ansi

# SHELL
export TERM=xterm-256color
export COLORTERM=truecolor

# =====================================================================================================================
# Oh my zsh settings
# =====================================================================================================================
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# =====================================================================================================================
# Plugins
# =====================================================================================================================
# OS
plugins=(sudo)

# TERMINAL
plugins+=(zsh-syntax-highlighting zsh-autosuggestions zsh-completions zsh-fzf-history-search)

# VM
plugins+=(docker)

# DEV
plugins+=(git npm gem mise)
# =====================================================================================================================
# Sourcing
# =====================================================================================================================
# Oh-my-zsh
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# =====================================================================================================================
# Plugin bindings
# =====================================================================================================================
# History substring search plugin binding
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Autosuggestions + Substring search config
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)

# =====================================================================================================================
# Additional aliases
# =====================================================================================================================
# editors
alias vim='nvim'
alias v='nvim'

# git
alias gbd='git push origin --delete $(git_current_branch)'
alias gcleanup=$'git fetch -p && git branch -v | grep \'gone\' | awk \'{print $1}\' | xargs -n 1 git branch -D'
alias lg='lazygit'

function set-git-user() {
  git config --global user.name "$1" && git config --global user.email "$2"
}

# GitHub CLI
alias gstacka='gh stack add'
alias gstackp='gh stack push'
alias gstacks='gh stack submit'

# docker
alias dockerstopall='docker stop $(docker ps -a -q)'
alias dockerrmall='docker rm $(docker ps -a -q)'
alias dockerrmidangling='docker rmi -f $(docker images -f "dangling=true" -q)'
alias dcontext='docker context use'
alias ld='lazydocker'

# misc
alias cat='batcat'
alias help='tldr'
alias m='mise'
alias ll='eza --long --icons --group-directories-first'
alias la='eza --long --all --icons --group-directories-first --icons'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias p='pnpm'
alias src='cd $WORKSPACE_DIR'

# =====================================================================================================================
# Custom integrations
# =====================================================================================================================
# Activate mise
eval "$(mise activate zsh)"

# Zoxide integration
eval "$(zoxide init --cmd cd zsh)"

# Direnv integration
eval "$(direnv hook zsh)"

# Starship prompt
eval "$(starship init zsh)"
