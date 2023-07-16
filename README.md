# Dotfiles Repository

This repository is a curated collection of dotfiles. The dotfiles were initially forked from [`3rfaan/dotfiles`](https://github.com/3rfaan/dotfiles). The collection includes configurations optimized for Windows, MacOS, and a variety of Linux distributions that I frequently use.

## Installation

There are two ways to install these dotfiles: on your host machine directly, or within a Docker container.

### Docker Container Installation

#### Prerequisites

1. Ensure `docker` is installed on your Unix-based host machine. The host can be a Windows Subsystem for Linux (WSL), MacOS, or any Linux distribution.
2. To fully utilize `neovim`, `ranger`, and `lsd` configurations, use a terminal emulator that supports a font such as [JetBrains Nerd Font](https://www.nerdfonts.com/font-downloads).

#### Container Setup

First, clone my repository [`jl178/dev-containers`](https://github.com/jl178/dev-containers), then execute the following commands:

```bash
cd dev-containers
make build && make run
```

This sequence of commands will:

1. Create a Docker volume that preserves any changes made in the `$HOME` directory within the container.
2. Build a Docker image using the username and password you provide. This image installs all prerequisite software (and some packages I use for dev work).
3. Start the container and attach it to your current terminal session. This also adds volume mounts for your host system. This includes docker, `$HOME/workplace`, and `$HOME:/home/container_user/host/`.

To attach to the running container from another terminal window, simply execute `make run`.

To simplify this process, consider adding an alias in your `~/.zshrc`, `.bashrc`, `~/.profile`, or any other terminal shell configuration file you use:

```bash
alias dev="cd $HOME/dev-containers/ make run"
```

### Host Machine Installation

To install the dotfiles on your host machine, clone this repository and execute `./install.sh`. Please note that this will replace your existing `~/.config` directory & may vary in functionality depending on your host OS.
