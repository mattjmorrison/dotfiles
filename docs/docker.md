# Docker / Colima Setup

## Why `cliPluginsExtraDirs` instead of a brew for docker-compose

Initial approach (commit `b2941dd`): added `docker-compose` as a `homebrew.brews` entry in `modules/darwin/docker.nix`.

Problem: Colima failed to start because it attempted to modify a file on the Nix-managed filesystem, which is read-only.

Fix (commit `35572c6`): removed the brew entry and instead added `cliPluginsExtraDirs` in `.docker/config.json` (managed via `home.file` in `modules/home/docker.nix`) pointing to `/opt/homebrew/lib/docker/cli-plugins`. Docker Compose itself is still installed via Homebrew, but Docker CLI discovers the plugin through config rather than through any path Nix controls.

`DOCKER_HOST` is also set in `home.sessionVariables` to `unix://~/.colima/default/docker.sock` because Colima uses a non-standard socket path that Docker CLI won't find on its own.

### Stale tmux sessions

`home.sessionVariables` are sourced via `~/.zshenv` → `hm-session-vars.sh`. A tmux server started before a `darwin-rebuild switch` won't pick up the new env. If Docker can't connect, run `tmux kill-server` and start a fresh session.
