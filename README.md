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

## [Fzf](https://github.com/junegunn/fzf)

A general-purpose command-line fuzzy finder.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `brew "fzf"`
2. Add `eval "$(fzf --zsh)"` to the `.zshrc` file. There are also some fancy plugins in zinit that integrate which `fzf`
 
### Usage

`fzf` is a really great terminal fuzzy finder. I don't really use it in isolation as much as I probably should, but integrating it with your shell history is one of the best decisions I've ever made. 

## [Tmux](https://github.com/tmux/tmux/wiki)

A terminal multiplexer.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `brew "tmux"`
2. Soft-link `.tmux.conf` file to the home directory:

        ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

### Usage

Tmux is one of the more important tools that I work with everyday. Since I do a lot of work on a remote desktop I always ensure that I'm working within a tmux session so that my dev environment does not get lost when I close the shh session. Additionally it makes managing independent projects much smother since I can keep them in separate tmux sessions. I have a lot of useful scripts for configuring my tmux sessions from scratch as well as some aliases which make switching between sessions really fast.

## bin

A place to store custom bash scripts

### Installation and Configuration

1. Create a `bin` directory on your machine via:

        mkdir -p ~/.local/bin

2. Soft-link any relevant directories under `dotfiles/bin`. For my general purpose scripts I do: 

        ln -s ~/dotfiles/bin/general ~/.local/bin

3. Add the relevant directory to your `PATH` variable (already in the `.zshrc` for this configuration):

        export PATH=$HOME/.local/bin/general:$PATH 

### Usage

Basically any script the I write which needs to be executable from anywhere I put in here.

## [Neovim](https://neovim.io/doc/)

Vim-fork focused on extensibility and usability.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `brew "neovim"`
2. Soft-link `nvim` directory to the `.config` directory:

        ln -s ~/dotfiles/nvim ~/.config/nvim

### Usage

I love Neovim. I could talk for hours about Neovim is so so so much better than any popular IDE on the market for a number of reasons, but I'll try to keep it brief. Back when I first began programming I started with [Atom](https://atom-editor.cc/), which was super nice and minimalist until it got killed :(. Then, like most young developers, I began using (trigger warning) 🤮~~Visual Studio Code~~🤮 which was probably the worst decision of my life. It wasn't until I discovered Emacs that I finally came to my senses and started taking my dev configuration seriously. Emacs was great, but there were some serious limitations that pushed me towards using Neovim as my code editor. The following sections outline my argument for why Neovim is the superior code editor.

#### Turing Complete Configuration

This is the biggest advantage that Neovim offers. Unlike other editors, like 🤮~~Visual Studio Code~~🤮 for example which uses plain json for configuration, Neovim uses Lua. Lua is a scripting language famous for its use as an embedded language in a variety of applications (Roblox, Balatro, and Neovim of course). The beauty here is that Lua is a real, Turing complete language, meaning the bar for configuring Neovim is essentially anything that is computationally possible. This enables you get extremely personal with how your configuration and to do all sorts of useful hacky things. For example, at my job there is a tool which is used to enable a variety of popular [language servers](https://en.wikipedia.org/wiki/Language_Server_Protocol) to work with internal code bases. For Ruby code, however, this tool only has support for [solargraph](https://solargraph.org/) which is an awful language server. Since I much prefer to use [ruby-lsp](https://github.com/Shopify/ruby-lsp), I can use Lua to programmatically parse out the paths to any ruby index farms from the `.solargraph.yml` file that is generated by the tool. I can then pass the paths to these farms to the ruby-lsp on initialization, all within Neovim. This is incredibly powerful. If I were a 🤮~~Visual Studio Code~~🤮 user I would need to either manually do all of that or maybe there would be some super bloated extension out there to do do it for me which most likely wouldn't work with whatever ruby plugin people use with 🤮~~Visual Studio Code~~🤮. 

The other benefit to Lua is that it is so dang easy to understand. Emacs is famously written and configured in Lisp, which though also being Turing complete is so much harder to work with and makes it super hard to use without using an Emacs distribution.

On the topic of distributions, my Neovim configuration is essentially a fork of the [NvChad](https://github.com/NvChad/NvChad) base code (not a fork of the NvChad starter config). If you get into Neovim I would highly recommend forking a distribution or using something like [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Forking and modifying a distribution allows you to keep everything about the distribution that you like, while still giving you the flexibility and freedom to change it however your heart desires. In my case I really love the NvChad UI, but I didn't like how it used [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for LSP integration. Since I forked NvChad I was able to get rid of this dependency while keeping the nice UI that the distribution offers.

#### Lightweight 

Neovim is incredibly lightweight compared to every IDE on the market. The benefits to this are huge. Firstly it makes working on multiple projects at a time a breeze. Lets say you need to have multiple code bases open at the same time for a package. In Intellij this could become disastrous as memory consumption rises, often resulting in an inevitable crash. Unlike Intellij, you can basically spawn as many Neovim processes as you want and not need to worry about performance or crashing. Secondly,Neovim is incredibly fast both at startup and while working. Even with gigantic code bases it takes milliseconds for neovim to open, connect to a language server, and display diagnostics. 

#### Maintainable

Just like everything else in this repository, Neovim is configured within a dedicated `nvim` directory which is soft-linked to the `.config` directory. This allows you to get all of the benefits of version control with your Neovim configuration. If you accidentally break Neovim while messing around in Lua, just go back to the previous commit. Additionally, say your machine has a catastrophic disk failure and you lose all of your data, you can push to a remote repository so that you never lose your configuration.  

#### Debloated

There is so much unnecessary crap littered around the edges of every popular IDE. With Neovim you have full control over the UI and UX. For me I keep it incredibly minimal. I have a collapsible file tree and line numbers on the left, a tab bar on top and a status bar on the bottom. You do not need anything else to be a productive developer. No plugin management tab, and certainly no git UI tab. 

#### Command line integration

Neovim is an application entirely contained within the command line. When you combine it with something like tmux, there is no better workflow. No more needing to wait for Intellij to startup and connect to your remote host every time you open and close your laptop, only for the connection to drop randomly while working. With Neovim just clone you configuration on you remote machine and `ssh` though the command line. If your connection is interrupted its no worry since you're using tmux and your session will persist. 

## [Git](https://git-scm.com/)

A fast, scalable, and distributed revision control system

### Installation and Configuration

1. Can be installed with Homebrew, but it should come pre-installed on most machines. 
2. Create the following file:

        touch ~/dotfiles/git/.gitconfig.local


3. Add the following lines with your name and email to this new file:

```
[user]
	name = foo bar
	email = foo.bar@baz.com
```        

4. Soft-link the `.gitconfig` file (which imports `.gitconfig.local`) to the home directory:

        ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig

5. **ENSURE THAT YOU DO NOT COMMIT `.gitconfig.local` TO A REMOTE REPO**

### Usage

The reason for this goofy git configuration is to ensure that I don't commit my personal email to a remote repository, that's it really.

## [Zsh](https://www.zsh.org/)

An interactive login shell and a command interpreter.

### Installation and Configuration

1. Can be installed with Homebrew, but it should come pre-installed on most machines. 
2. Soft-link `.zshrc` file to home directory:

        ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc

Once this is done, reloading your shell should enable all of the `oh-my-posh`, `zinit`, and `fzf` configuration.

### Usage

Zshell is probably the most popular shell among software developers. I just throw everything into my `.zshrc` file usually.

## [Java](https://www.java.com/en/)

Write once, run anywhere.

### Installation and Configuration

Gonna depend on your machine.

### Usage

I don't really have anything important in this folder, just a file containing formatting rules.

## [Python](https://www.python.org/)

Beautiful is better than ugly.

### Installation and Configuration

1. Python installation is going to depend on your machine or virtual environment, just do what works for you. Additional tools like linters and such can also be installed with Homebrew. 
2. Soft-link the `.mypy.ini` file and the `.ruff.toml` file to your home directory:

        ln -s ~/dotfiles/python/.mypy.ini ~/.mypy.ini
        ln -s ~/dotfiles/python/.ruff.toml ~/.ruff.toml

### Usage

For python development I use [ruff](https://github.com/astral-sh/ruff) as my general purpose linter and formatter and [mypy](https://mypy-lang.org/) for type checking (typed python is better). I like storing config files for these tools in my home directory to give myself a nice base configuration when there are no project specific config files. The good thing about this setup is that if a given project has it's own configuration for either of these tools, the project specific config file will override my config file in my home directory.

## [Ruby](https://www.ruby-lang.org/en/)

A Programmer's Best Friend.

### Installation and Configuration

1. Installed along with other packages in Brewfile via `brew "ruby"`
2. Soft-link `.rubocop.yml` directory to the home directory:

        ln -s ~/dotfiles/ruby/.rubocop.yml ~/.rubocop.yml

### Usage

`.rubocop.yml` is where I keep my rubocop configuration. The main use of this file, along with the other linting files in this repo, is to ignore linting errors that I don't find important

## [Vim](https://github.com/vim/vim)

A highly configurable text editor.

### Installation and Configuration

1. Can be installed with Homebrew, but it should come pre-installed on most machines. 
2. Soft-link `.vimrc` file to home directory:

        ln -s ~/dotfiles/vim/.vimrc ~/.vimrc

### Usage

I never use vim, so this configuration is very minimal. It's probably best to not even bother with configuring it, Neovim will always be better.
