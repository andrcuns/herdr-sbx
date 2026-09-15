FROM docker/sandbox-templates:shell-docker@sha256:5fc81bc7a127e59d81b244a06831ae3212a0310b2e5a0349c54e29249e45e919

USER root

# install packages
RUN set -eu; \
    apt-get update  \
    && apt-get -y --no-install-recommends install  \
    curl \
    git \
    ca-certificates \
    build-essential \
    ripgrep \
    fd-find \
    zsh \
    fzf \
    starship \
    bat \
    direnv \
    zoxide \
    neovim \
    eza \
    gnupg \
    lazygit \
    && apt-get autoclean; \
    chsh -s /usr/bin/zsh agent

# env
ENV SHELL=/usr/bin/zsh \
    LANG=C.UTF-8 \
    OZSH_DIR=/home/agent/.oh-my-zsh

USER agent

# setup shell
ENV PLUGINS_DIR=$OZSH_DIR/custom/plugins
RUN set -eu; \
    git clone https://github.com/robbyrussell/oh-my-zsh.git $OZSH_DIR; \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINS_DIR/zsh-syntax-highlighting; \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $PLUGINS_DIR/zsh-autosuggestions; \
    git clone https://github.com/zsh-users/zsh-completions.git $PLUGINS_DIR/zsh-completions; \
    git clone https://github.com/zsh-users/zsh-history-substring-search.git $PLUGINS_DIR/zsh-history-substring-search; \
    git clone https://github.com/joshskidmore/zsh-fzf-history-search.git $PLUGINS_DIR/zsh-fzf-history-search

COPY --chown=agent:agent docker/.zshrc /home/agent/.zshrc
COPY --chown=agent:agent docker/starship.toml /home/agent/.config/starship.toml
COPY --chown=agent:agent docker/update.zsh ${OZSH_DIR}/custom/update.zsh

# setup lazyvim
RUN git clone https://github.com/LazyVim/starter.git /home/agent/.config/nvim && rm -rf /home/agent/.config/nvim/.git

# install mise
ARG MISE_VERSION
RUN curl https://mise.run | sh && mise --version

# install herdr
RUN curl -fsSL https://herdr.dev/install.sh | sh && herdr --version
COPY --chown=agent:agent docker/herdr/config.toml /home/agent/.config/herdr/config.toml
