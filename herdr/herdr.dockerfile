FROM docker/sandbox-templates:shell-docker@sha256:1560168ac5fb9ce23d413c878349334c5845c07e264cd675d7867f0c78ad1761

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
    OZSH_DIR=/home/agent/.oh-my-zsh \
    MISE_DATA_DIR=/home/agent/.local/share/mise

# keep all mise tools in agent space
ENV MISE_CONFIG_DIR=/home/agent/.config/mise \
    MISE_CACHE_DIR=$MISE_DATA_DIR/cache \
    PATH="$PATH:$MISE_DATA_DIR/shims"

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

# setup lazyvim
RUN git clone https://github.com/LazyVim/starter.git /home/agent/.config/nvim && rm -rf /home/agent/.config/nvim/.git

# install mise tools
COPY --from=ghcr.io/jdx/mise:2026.9.17 /usr/local/bin/mise /usr/local/bin/mise
COPY --chown=agent:agent files/home/.config/mise/config.toml /home/agent/.config/mise/
RUN mise trust && mise install

# add configs
COPY --chown=agent:agent files/home/ /home/agent/
COPY --chown=agent:agent files/update.zsh ${OZSH_DIR}/custom/update.zsh

ENTRYPOINT ["herdr"]
