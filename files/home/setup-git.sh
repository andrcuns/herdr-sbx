#!/usr/bin/env bash
set +e

# Configure Git SSH signing from the forwarded SSH agent at runtime.
# The SSH agent socket is available in interactive runs, but may not be
# available when Docker Sandboxes executes kit startup commands.
signing_key="$(ssh-add -L 2>/dev/null | head -n 1 || true)"
if [ -n "$signing_key" ]; then
  git config --global commit.gpgsign true
  git config --global tag.gpgsign true
  git config --global gpg.format ssh
  git config --global user.signingkey "key::${signing_key}"
  echo "Setup Git SSH signing config"
else
  echo "No SSH public key available from ssh-add; skipping Git SSH signing config" >&2
fi
