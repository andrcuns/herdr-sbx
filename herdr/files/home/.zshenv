# herdr rejects sandbox socket because of ownership issues and set's incorrect socket path
# force sandbox exposed ssh agent
export SSH_AUTH_SOCK=/run/ssh-agent.sock
# ssh sessions revert SHELL to /bin/bash
export SHELL=/usr/bin/zsh
