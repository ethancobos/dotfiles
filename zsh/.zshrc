# Determine if we are on work computer using the presence of a `.work_mode` file
[ -f "$HOME/dotfiles/zsh/.work_mode" ] && export ON_WORK_COMPUTER=true || export ON_WORK_COMPUTER=false

## ╭──────────────────────────────────────────────╮
## │              Amazon Q Pre-Block              │
## ╰──────────────────────────────────────────────╯

if $ON_WORK_COMPUTER; then   
    [[ -f "${HOME}/.local/share/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/zshrc.pre.zsh"
fi

## ╭──────────────────────────────────────────────╮
## │            Environment Variables             │
## ╰──────────────────────────────────────────────╯

if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -f /opt/homebrew/bin/brew ]] then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# consistent colors when this config is on a remote host
if [[ -n "$SSH_CONNECTION" ]]; then
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi

if $ON_WORK_COMPUTER; then
    export BRAZIL_WORKSPACE_DEFAULT_LAYOUT=short
fi

export AUTO_TITLE_SCREENS="NO"
export AWS_EC2_METADATA_DISABLED=true
export GIT_EDITOR=nvim

## ╭──────────────────────────────────────────────╮
## │                   PATH                       │
## ╰──────────────────────────────────────────────╯

# Work only PATHs
if $ON_WORK_COMPUTER; then   
    export PATH=$HOME/.toolbox/bin:$PATH
    export PATH=$JAVA_HOME/bin:$PATH
    export PATH=/apollo/env/OdinTools/bin:$PATH
    export PATH=/apollo/env/envImprovement/bin:$PATH
    export PATH=$HOME/.local/bin/amazon:$PATH
fi

# Common Paths
export PATH=$HOME/.local/bin/general:$PATH

## ╭──────────────────────────────────────────────╮
## │                Completions                   │
## ╰──────────────────────────────────────────────╯

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# for some reason this won't work on work box
if ! $ON_WORK_COMPUTER; then   
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a --color $realpath'
fi

# Load completions
autoload -Uz compinit && compinit

# Work only completions
if $ON_WORK_COMPUTER; then   
    source /home/ecobos/.brazil_completion/zsh_completion

    [ -f "/apollo/env/MechanicBigBirdCli/bin/mechanic-autocomplete.sh" ] && source "/apollo/env/MechanicBigBirdCli/bin/mechanic-autocomplete.sh"
fi

## ╭──────────────────────────────────────────────╮
## │                   Zinit                      │
## ╰──────────────────────────────────────────────╯

# Source/Load zinit
source "${HOMEBREW_PREFIX}/opt/zinit/zinit.zsh"

# Add in zsh plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

## ╭──────────────────────────────────────────────╮
## │                Keybindings                   │
## ╰──────────────────────────────────────────────╯

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

## ╭──────────────────────────────────────────────╮
## │                    History                   │
## ╰──────────────────────────────────────────────╯

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

## ╭──────────────────────────────────────────────╮
## │                   Aliases                    │
## ╰──────────────────────────────────────────────╯

# Work only aliaes
if $ON_WORK_COMPUTER; then
    # Brazil
    alias bb=brazil-build
    alias bba='brazil-build apollo-pkg'
    alias bre='brazil-runtime-exec'
    alias brc='brazil-recursive-cmd'
    alias bws='brazil ws'
    alias bwsuse='bws use -p'
    alias bwscreate='bws create -n'
    alias brc=brazil-recursive-cmd
    alias bbr='brc brazil-build'
    alias bball='brc --allPackages'
    alias bbb='brc --allPackages brazil-build'
    alias bbra='bbr apollo-pkg'

    # Other
    alias print-java-version='printf "\n☕️ Java\n\n" && which java && java -version'
    alias switch-java-version='sudo alternatives --config java && source ~/.zshrc'
    alias isengard="/apollo/env/AmazonAwsCli/bin/isengard"
    alias kcurl="/apollo/env/envImprovement/bin/kcurl"

# Home only aliases
else
    export PATH=$HOME/opt/homebrew/opt/python@3.13/libexec/bin:$PATH
fi

# Common Aliases

# misc
alias h="cd ~"
alias c="clear"

# python
alias python="python3"
alias pip="pip3"
alias i="ipython3"

# give me more info with ls
alias ls="ls -a --color"

# vim
alias vim=nvim
# aliases for editing and sourcing configuration files
alias vz="vim ~/.zshrc"
alias vt="vim ~/.tmux.conf"
alias va="vim ~/dotfiles/zsh/.zsh_aliases"
alias sz="source ~/.zshrc"
alias st="tmux source ~/.tmux.conf"

# tmux
alias trs="tmux rename-session"
alias tat="tmux attach -t"
alias tst="tmux switch -t"
alias tks="tmux kill-session"
alias tkst="tmux kill-session -t"
alias tls="tmux ls"

# homebrew
alias bbic="brew update &&\
    brew bundle install --cleanup --file=~/dotfiles/homebrew/Brewfile &&\
    brew upgrade"
## ╭──────────────────────────────────────────────╮
## │              Shell Integrations              │
## ╰──────────────────────────────────────────────╯

# Common shell integrations
eval "$(mise activate zsh)"
eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config $HOME/dotfiles/oh-my-posh/main.yaml)"

## ╭──────────────────────────────────────────────╮
## │             Amazon Q Post-Block              │
## ╰──────────────────────────────────────────────╯

if $ON_WORK_COMPUTER; then
    [[ -f "${HOME}/.local/share/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/zshrc.post.zsh"
fi
