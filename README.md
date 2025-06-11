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

I use AeroSpace as my choice of tiling window manager. It is much less popular the [Yabai](https://github.com/koekeishiya/yabai), but its simple and does more than what I use it for. Apples virtual desktops suck, and instead of having to swip left right and up to find application windows, aerospace allows me to jump to and rearrange windows with at most two keys. As previously mentioned I use `ctrl-alt-cmd` as one of my Aerospace leader keys and I bind it to the key directly to the right of my space bar. I then bind every letter key on the left side of my keyboard to an aerospace window. This means to jump around i just grab the leader key with my thumb and the window key with my left hand. It is so natural and so fast, it is probably my favorite configuration in this repo.

## [Alacritty](https://alacritty.org/)

A fast, cross-platform, OpenGL terminal emulator.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `cask "alacritty"`
2. Soft-link `alacritty` directory to `.config` directory:

        ln -s ~/dotfiles/alacritty ~/.config/alacritty

### Usage

I used to use [iTerm2](https://iterm2.com/) as my terminal emulator of choice, but I soon realized that there was no way to declaratively store my configuration in a text-based format. This prompted me to look for an alternative which is when I found alacritty. The configuration is super simple and though it lacks certain features that iTerm may have (like native tabs), it's nothing that I wouldn't already be using tmux for.

## [Oh My Posh](https://ohmyposh.dev/)

A prompt theme engine for any shell.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `brew "oh-my-posh"`
2. Add `eval "$(oh-my-posh init zsh --config $HOME/dotfiles/oh-my-posh/main.yaml)"` to `.zshrc` (already in this repo's `.zshrc`, see [Zsh](#zsh))

### Usage

oh-my-posh is responsible for giving my terminal a super clean and minimalist look, I especially love the transient prompt feature.

Full disclosure, my configuration was almost entirely stolen/copied from [this video](https://www.youtube.com/watch?v=9U8LCjuQzdc&t=84s) by Dreams of Code on YouTube. His channel is super underrated overall and I highly recommend you check him out. 

## [Zinit](https://github.com/zdharma-continuum/zinit)

A flexible and fast Zshell plugin manager.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `brew "zinit"`
2. Add `source "${HOMEBREW_PREFIX}/opt/zinit/zinit.zsh"` to `.zshrc` (already in this repo's `.zshrc`, see [Zsh](#zsh))

### Usage

Zinit is my choice of terminal plugin manager. It is faster and less bloated than the more popular [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh). Again, this is mostly copied from [another video](https://www.youtube.com/watch?v=ud7YxC33Z3w&t=900s) by Dreams of Code. I would recommend you watch that for the details of what each plugin does and how configuration works.

## [fzf](https://github.com/junegunn/fzf)

A general-purpose command-line fuzzy finder.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `brew "fzf"`
2. Add `eval "$(fzf --zsh)"` to the `.zshrc` file. There are also some fancy plugins in zinit that integrate which `fzf`
 
### Usage

`fzf` is a really great terminal fuzzy finder. I don't really use it in isolation as much as I probably should, but integrating it with your shell history is one of the best decisions I've ever made. 

## [Zsh](https://www.zsh.org/)

An interactive login shell and a command interpreter.

### Installation and Configuration

1. Can be installed with Homebrew, but it should come pre-installed on most machines. 
2. Soft-link `.zshrc` file to home directory:

        ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc

Once this is done, reloading your shell should enable all of the `oh-my-posh`, `zinit`, and `fzf` configuration.

### Usage

Zshell is probably the most popular shell among software developers. I just throw everything into my `.zshrc` file usually.

## [Neovim](https://neovim.io/doc/)

Vim-fork focused on extensibility and usability.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `brew "neovim"`
2. Soft-link `nvim` directory to the `.config` directory:

        ln -s ~/dotfiles/nvim ~/.config/nvim

### Usage

TODO

## [Tmux](https://github.com/tmux/tmux/wiki)

A terminal multiplexer.

### Installation and Configuration

TODO

### Usage

TODO

## bin

A place to store custom bash scripts

### Installation and Configuration

1. Create a `bin` directory on your machine via:

        mkdir -p ~/.local/bin

2. Soft-link any relevant directories under `dotfiles/bin`. For my general purpose scripts I do: 

        ln -s ~/dotfiles/bin/general ~/.local/bin

3. Add the relevant directory to your `PATH` variable:

        export PATH=$HOME/.local/bin/general:$PATH 

### Usage

TODO

## [Git](https://git-scm.com/)

A fast, scalable, and distributed revision control system

### Installation and Configuration

TODO

### Usage

TODO

## [Java](https://www.java.com/en/)

TODO

### Installation and Configuration

TODO

### Usage

TODO

## [Python](https://www.python.org/)

TODO

### Installation and Configuration

TODO

### Usage

TODO

## [Ruby](https://www.ruby-lang.org/en/)

TODO

### Installation and Configuration

TODO

### Usage

TODO

## [Vim](https://github.com/vim/vim)

TODO

### Installation and Configuration

TODO

### Usage

TODO
