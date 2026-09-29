# herdr-sbx

A [Docker Sandbox Kit v3](https://github.com/docker/sandbox-kit-spec) for the [pi](https://pi.dev/) harness, with [herdr](https://herdr.dev/), [mise](https://mise.run), and an opinionated zsh setup.

The sandbox supports direct and remote herdr sessions. It requires an `sbx` release with Kit v3 support.

## Usage

```console
$ sbx setup ssh
$ sbx create --name herdr ghcr.io/andrcuns/herdr-sbx:latest workspace-folder-1 workspace-folder-2
$ herdr --remote herdr.sbx
```

This lets herdr manage multiple folders within a single sandbox. To attach directly, run `sbx run --name herdr`.

To build from source instead of using the published image:

```console
$ sbx create --name herdr "git+https://github.com/andrcuns/herdr-sbx.git" workspace-folder-1 workspace-folder-2
```
