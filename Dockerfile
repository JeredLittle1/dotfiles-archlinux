FROM archlinux:base-devel

# Environment variables
ENV USER=archlinux \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    NODE_VERSION=18 \
    PYTHON_VERSION=3.9.6 \
    SHELL=/bin/zsh

# Update system and install dependencies
RUN pacman -Syu --noconfirm 

# Add a new user
RUN useradd -m ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} \
        && chmod 0440 /etc/sudoers.d/${USER}

# Switch to the new user
USER ${USER}
WORKDIR /home/${USER}
RUN sudo pacman -S --noconfirm git
RUN sudo pacman -S --noconfirm curl
RUN sudo pacman -S --noconfirm zsh
RUN sudo pacman -S --noconfirm sudo
RUN sudo pacman -S --noconfirm jdk11-openjdk
RUN sudo pacman -S --noconfirm ripgrep
RUN sudo pacman -S --noconfirm lazygit 
RUN sudo pacman -S --noconfirm pyenv
RUN sudo pacman -S --noconfirm xdg-user-dirs
RUN sudo pacman -S --noconfirm lsd
RUN sudo pacman -S --noconfirm fzf
RUN sudo pacman -S --noconfirm ranger
RUN sudo pacman -S --noconfirm neovim

# Set zsh as default shell
RUN sudo chsh -s /bin/zsh

# dotfiles
RUN git clone https://github.com/jl178/dotfiles-archlinux.git
RUN cd dotfiles-archlinux && echo -e "y" | ./install.sh

# Packages not available in AUR
## nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> ~/.zshrc 
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc


## node install
RUN /bin/zsh -c "source ~/.zshrc && nvm install $NODE_VERSION"

## python install
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc 
RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc 
RUN echo 'eval "$(pyenv init -)"' >> ~/.zshrc

RUN /bin/zsh -c "source ~/.zshrc && pyenv install $PYTHON_VERSION && pyenv global $PYTHON_VERSION"

# Astrovim
RUN git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

#neovim config
RUN git clone https://github.com/jl178/astrovim_config.git ~/.config/nvim/lua/user


# Set the default command to zsh
CMD [ "/bin/zsh" ]

