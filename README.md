# My Dotfiles

This repo contains all of the configuration for all of the tools that I use everyday as a software developer. It is a combination of my personal configuration and work configuration. See [General Setup](#general-setup) for the details on how I ensure that my work-specific and home-specific configuration doesn't mix.

Each folder in this repo cooresponds (ussually) to a tool that I use. In the following sections I'll go over each of these tools in the order that I would install/set then up if I were starting from a fresh machine

## General Setup

First, clone the repository to your home directory (or wherever you prefer to store your dotfiles):

    git clone https://github.com/ethancobos/dotfiles.git ~/.dotfiles

In the future I'd like to create a script to automate all of the sim linking required for each directory, but for now I'll just put detailed instructions below for each sub-directory in this repo.

### FOR WORK

In order to include special work specific configuration, my `.zshrc` has some logic to check for the existence of a `$HOME/dotfiles/zsh/.work_mode` file, and if present, set an environment variable `ON_WORK_COMPUTER` to true, and false otherwise. I use the following command to create this file:

    touch ~/dotfiles/zsh/.work_mode

## [Homebrew](https://brew.sh)

**Follow the guidence on the official homebrew website for detail of how to install on your machine**

The first tool that I would install on a new machine is Homebrew which is my package manager of choice. Instead of installing packages ad hoc with `brew install <package>`, I use a special set of commands along with a Brewfile to keep it declarative. This ensures that the contents of `dotfiles/homebrew/Brewfile` represent the exact state of my packages. each time I want to install or uninstall a package, I simply add it or remove it from the Brewfile, then I run the following command:

```
brew update && brew bundle install --cleanup --file=~/dotfiles/homebrew/Brewfile && brew upgrade
```

The `--cleanup` argument is key in making sure whatever is not present in my Brewfile is not on my machine. In my `.zshrc` file I alias this command to `bbic`

## [Karabiner-elements](https://karabiner-elements.pqrs.org/)

**Installed along with other packages in Brewfile**

Karabiner-elements allows you to rebind keys on 3rd-party keyboads as well as the Macbook built in keyboard.

## [AeroSpace](https://github.com/nikitabobko/AeroSpace)

**Installed along with other packages in Brewfile**

I use AeroSpace as my choice of tiling window manager. It is much less popular the yabai, but its simple and does more than what I use it for.

    ln -s ~/dotfiles/aerospace/.aerospace.toml ~/.aerospace.toml

## bin

This is where I keep any scripts that I write, both work related ones and general purpose ones. I soft link them using the following:

    mkdir -p ~/.local/bin
    ln -s ~/dotfiles/bin/general/ ~/.local/bin/

For amazon specific scripts:

    ln -s ~/dotfiles/bin/amazon/ ~/.local/bin/

## git

I put all my git configuration in a non-tracked file since it is confidential. I load this data into my `.gitconfig` file.

    ln -s ~/dotfiles/git/.gitconfig ~/
   
## java

This is where I keep any custom java LSP related things

## Karabiner

I use karabiner elements to rebind a ton of macbook keys.

    ln -s ~/dotfiles/karabiner/ ~/.config/  

### Links
https://karabiner-elements.pqrs.org

## Neovim/NvChad

The best code editor out there

    ln -s ~/dotfiles/nvim/ ~/.config/ 

### Links
https://nvchad.com

## powerlevel10k

For making my Zshell elite

    ln -s ~/dotfiles/p10k/.p10k.zsh ~/

### Links
https://github.com/romkatv/powerlevel10k

## python

Where I keep my LSP configuration files

### Links
https://github.com/microsoft/pyright
https://github.com/astral-sh/ruff-lsp

## ruby

Where I keep my LSP configuration files

    ln -s ~/dotfiles/ruby/.rubocop.yml ~/

### Links
https://github.com/Shopify/ruby-lsp

## tmux

    ln -s ~/dotfiles/tmux/.tmux.conf ~/

### Links
https://github.com/tmux/tmux/wiki

## vim

Don't even bother, just use Neovim

    ln -s ~/dotfiles/vim/.vimrc ~/
    

## zsh/zinit

    ln -s ~/dotfiles/zsh/.zshrc ~/

### Links
https://github.com/junegunn/fzf
https://github.com/zdharma-continuum/zinit
