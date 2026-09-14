function update() {
  update-npm-packages() {
    o=$(npm outdated -g --parseable --depth=0)
    if [ -z "$o" ]; then
      echo "✓ All global npm packages are up to date."
    else
      echo "Updating the following global packages:"
      npm outdated -g # pretty table view
      echo "$o" | cut -d: -f4 | sed 's/@[^@]*$/@latest/' | xargs npm install -g
    fi
  }

  update-pi-extensions() {
    pi update --extensions
  }

  log-info() {
    echo -e "\033[1;33m$1\033[0m"
  }

  # Clean up helper functions when update() returns
  trap 'unfunction log-info update-pi-extensions update-npm-packages 2>/dev/null' EXIT

  local original_dir=$(pwd)
  echo "Moving to $HOME directory before performing update"
  cd $HOME

  echo ""
  log-info "***Run OS package update***"
  sudo apt-get update && sudo apt-get upgrade -y

  echo
  log-info "***Update global mise tools and run cleanup***"
  mise up --bump --cd $HOME/.config/mise
  mise prune --cd $HOME/.config/mise --yes

  echo
  log-info "***Update global npm packages***"
  update-npm-packages

  echo
  log-info "***Update pi extensions***"
  update-pi-extensions

  echo
  log-info "***Update omzsh and plugins***"
  echo "Update oh-my-zsh"
  git -C $OZSH_DIR pull
  echo "Update zsh plugins"
  git -C $PLUGINS_DIR/zsh-syntax-highlighting pull
  git -C $PLUGINS_DIR/zsh-autosuggestions pull
  git -C $PLUGINS_DIR/zsh-completions pull
  git -C $PLUGINS_DIR/zsh-history-substring-search pull
  git -C $PLUGINS_DIR/zsh-fzf-history-search pull

  echo ""
  echo "Update complete!"
  cd "$original_dir"
}
