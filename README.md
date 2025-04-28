# My Dotfile Repo 

**TL;DR** Almost all configuration is inspired/stolen from [Dreams of Code](https://github.com/dreamsofcode-io) and [
Dreams of Autonomy](https://github.com/dreamsofautonomy). I would highly recommend browsing through his Github and YouTube accounts.

This repo contains a combination of my personal configuration and work configuration. See [General Setup](#general-setup) for the details on how I ensure that my work-specific and home-specific configuration doesn't mix.

## General Setup

First, clone the repository to your home directory (or wherever you prefer to store your dotfiles):

    git clone https://github.com/ethancobos/dotfiles.git ~/.dotfiles

In the future I'd like to create a script to automate all of the sim linking required for each directory, but for now I'll just put detailed instructions below for each sub-directory in this repo.

### FOR WORK

In order to include special work specific configuration, my `.zshrc` has some logic to check for the existence of a `$HOME/dotfiles/zsh/.work_mode` file, and if present, set an environment variable `ON_WORK_COMPUTER` to true, and false otherwise. I use the following command to create this file:

    touch ~/dotfiles/zsh/.work_mode

## Fine Grained Setup

Below are all of the sub-directories of this repo and the commands to soft link all necessary configuration files

## AeroSpace
### Links

https://github.com/nikitabobko/AeroSpace

* Also check out (yabai)[https://github.com/koekeishiya/yabai] which is the more popular window manager

## bin

This is where I keep any scripts that I write, both work related ones and general purpose ones. I soft link them using the following:

    ln -s ~/dotfiles/bin/general/ ~/.local/bin/
    ln -s ~/dotfiles/bin/amazon/ ~/.local/bin/

## Karabiner

https://karabiner-elements.pqrs.org

## Neovim/NvChad

https://nvchad.com

## powerlevel10k

https://github.com/romkatv/powerlevel10k

## python

https://github.com/microsoft/pyright
https://github.com/astral-sh/ruff-lsp

## tmux

https://github.com/tmux/tmux/wiki


## vim

* Don't even bother, just use Neovim

## zsh/zinit

https://github.com/junegunn/fzf
https://github.com/zdharma-continuum/zinit

## Other Important Tools and Configurations

### iTerm2 

https://iterm2.com

* My terminal emulator of choice

### Catppuccin

https://catppuccin.com

* I try to keep my theme consistent throughout every tool I use. I've found that cattpuccin is supported in almost everything I use

### JetBrainsMono Nerd Font

https://formulae.brew.sh/cask/font-jetbrains-mono-nerd-font

* My font of choice that I also try to keep consistent everywhere, but really any nerd font should do.
