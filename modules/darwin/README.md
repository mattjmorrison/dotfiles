# Darwin Modules

Reusable nix-darwin system modules. These configure macOS-level behavior and machine-level packages/apps.

## Modules

- `default.nix` - imports all Darwin modules.
- `homebrew.nix` - enables Homebrew and installs casks.
- `nix.nix` - configures Nix/nixpkgs behavior, including the unfree package allowlist.
- `system.nix` - sets nix-darwin system state and primary user.
- `users.nix` - defines the macOS home directory for `matt-nix`.
