# herdr-sbx

Custom docker sandbox template for [pi](https://pi.dev/) harness with [herdr](https://herdr.dev/) and [mise](https://mise.run) preinstalled in addition with some opinionated zshell setup.

Sandbox is designed for either direct or remote herdr sessions.

## Usage

```console
$ sbx setup ssh
$ sbx create --name herdr "git+https://github.com/andrcuns/herdr-sbx.git" workspace-folder-1 workspace-folder-2
$ herdr --remote herdr.sbx
```

This allows to manage multiple folders via herdr within a single sandbox
