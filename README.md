# herdr-sbx

A [Docker Sandbox Kit v3](https://github.com/docker/sandbox-kit-spec) with [herdr](https://herdr.dev/) for agent management and [mise](https://mise.jdx.dev) for development tool management.

## Usage

```console
sbx setup ssh
sbx create --name herdr ghcr.io/andrcuns/herdr:latest workspace-folder-1 workspace-folder-2
herdr --remote herdr.sbx
```

This lets herdr manage multiple folders within a single sandbox. To attach directly, run `sbx run --name herdr`.

### Pi harness

Use the `pi` mixin to add [pi](https://pi.dev/docs/latest) harness to the sandbox

```console
sbx create --name herdr-pi ghcr.io/andrcuns/herdr:latest --kit "git+https://github.com/andrcuns/herdr-sbx.git#ref=main&dir=pi" workspace-folder-1
```

### Updating internal tools

Run `update` inside the sandbox to trigger update of internal tools
