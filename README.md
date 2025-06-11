# My Dotfiles

This repo contains all of the configuration for all of the tools that I use everyday as a software developer. It is a combination of my personal configuration and work configuration. See [General Setup](#general-setup) for the details on how I ensure that my work-specific and home-specific configuration doesn't mix.

Each folder in this repo corresponds (usually) to a tool that I use. In the following sections I'll go over each of these tools in the order that I would install/set then up if I were starting from a fresh machine

## General Setup

First, clone the repository to your home directory (or wherever you prefer to store your dotfiles):

    git clone https://github.com/ethancobos/dotfiles.git ~/.dotfiles

In the future I'd like to create a script to automate all of the sim linking required for each directory, but for now I'll just put detailed instructions below for each sub-directory in this repo.

### FOR WORK

In order to include special work specific configuration, my `.zshrc` has some logic to check for the existence of a `$HOME/dotfiles/zsh/.work_mode` file, and if present, set an environment variable `ON_WORK_COMPUTER` to true, and false otherwise. I use the following command to create this file:

    touch ~/dotfiles/zsh/.work_mode

## [Homebrew](https://brew.sh)

The Missing Package Manager for macOS (or Linux).

### Installation and Configuration

**Follow the guidance on the official Homebrew website for detail of how to install on your machine**

### Usage

The first tool that I install on a new machine is Homebrew which is my package manager of choice. Instead of installing packages ad hoc with `brew install <package>`, I use a special set of commands along with a Brewfile to keep it declarative. This ensures that the contents of `dotfiles/homebrew/Brewfile` represent the exact state of my packages. Each time I want to install or uninstall a package, I simply add it or remove it from the Brewfile, then I run the following command:

    brew update && brew bundle install --cleanup --file=~/dotfiles/homebrew/Brewfile && brew upgrade

The `--cleanup` argument is key in making sure whatever is not present in my Brewfile is not on my machine. In my `.zshrc` file I alias this command to `bbic`

## [Karabiner-elements](https://karabiner-elements.pqrs.org/)

A powerful and stable keyboard customizer for macOS.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `cask "karabiner-elements"`
2. Soft-link karabiner directory to `.config` directory:

        ln -s ~/dotfiles/karabiner ~/.config/karabiner 

### Usage

Karabiner-elements allows you to rebind keys on 3rd-party keyboards as well as the MacBook built in keyboard. There are a few modifications that I use which I think everyone should consider trying out, especially if you are considering using this repository as a guide for you own configuration. I'll go into detail about each below.

#### The Caps Lock Key

The caps lock key is the biggest waste of space on the keyboard, especially considering that it occupies a prime location right next to the left pinky. I use karabiner elements to instead give this key the following behavior:

- When held or pressed along side other keys it registers as a `control` modifier
- When tapped in isolation it registers an `escape`

This behavior is optimized for my setup in a number of ways. Firstly I'm a die hard Neovim user, so having the escape key in a prime location right next to my pinky is super useful. Secondly, I am also a die hard tmux user with my leader sequence bound to `C-Space`, so again its so natural to just move my pinky over one key instead of needing to reach way over for the dedicated control key.

#### ctrl-alt-cmd and ctrl-alt-cmd-shift

The other rebinding that I do on every keyboard I have is to have a dedicated key to hit `ctrl-alt-cmd` and `ctrl-alt-cmd-shift` all in one stroke. On a Macbook I bind `ctrl-alt-cmd` to right command and `ctrl-alt-cmd-shift` to right option, but for other keyboards the rule of thumb is to just bind `ctrl-alt-cmd` to whatever key is directly to the right of the space bar and then `ctrl-alt-cmd-shift` to whatever is directly to the right of that. The reasoning behind this is that each of these keys serve as leader keys for my [Aerospace](#aerospace) bindings which is one of the most important tools in my workflow.

## [AeroSpace](https://github.com/nikitabobko/AeroSpace)

An i3-like tiling window manager for macOS.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `cask "karabiner-elements"`
2. Soft-link `.aerospace.toml` file to home directory:

        ln -s ~/dotfiles/aerospace/.aerospace.toml ~/.aerospace.toml

### Usage

I use AeroSpace as my choice of tiling window manager. It is much less popular the [Yabai](https://github.com/koekeishiya/yabai), but its simple and does more than what I use it for.


## [Oh My Posh](https://ohmyposh.dev/)

## [Alacritty](https://alacritty.org/)

## bin
### Installation

**N/A**

### Configuration


## [Git](https://git-scm.com/)
### Installation and Configuration
### Configuration
## [Java](https://www.java.com/en/)
### Installation and Configuration
### Configuration
## [Neovim](https://neovim.io/doc/)
### Installation and Configuration
### Configuration
## [Python](https://www.python.org/)
### Installation and Configuration
### Configuration
## [Ruby](https://www.ruby-lang.org/en/)
### Installation and Configuration
### Configuration
## [Tmux](https://github.com/tmux/tmux/wiki)
### Installation and Configuration
### Configuration
## [Vim](https://github.com/vim/vim)
### Installation and Configuration
### Configuration
## [Zsh](https://www.zsh.org/)
### Installation and Configuration
### Configuration

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
