export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$HOME/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}
export GIT_EDITOR=nvim
ZSH_THEME="refined"

# dont know what this does yet
# . "$HOME/.cargo/env"

# oh my zsh plugins
plugins=(git fzf tmux)

#
# personal configuations below
#

# tmux stuff
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=false

# does fancy fzf stuff
export FZF_DEFAULT_OPS="--extended"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# opam stuff
[[ ! -r /Users/ethancobos/.opam/opam-init/init.zsh ]] || source /Users/ethancobos/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

source $ZSH/oh-my-zsh.sh

# collects al my current aliases
source ~/dotfiles/zsh/.zsh_aliases
