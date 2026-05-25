# MacBook Host

macOS configuration for the `macbook` nix-darwin target.

## Files

- `default.nix` - imports nix-darwin modules, Home Manager, and host-specific Home Manager wiring.
- `home-manager.nix` - enables Home Manager integration for the `matt-nix` user.
- `home.nix` - Home Manager profile for the `matt-nix` user on this host.
