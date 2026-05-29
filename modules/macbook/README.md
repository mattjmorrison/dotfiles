# MacBook Module

Shared nix-darwin and Home Manager profile for MacBook hosts. All MacBook hosts import this module.

## Files

- `default.nix` - enables nix-homebrew, imports Darwin modules, and wires Home Manager.
- `home-manager.nix` - configures the Home Manager integration for the host user.
- `home.nix` - Home Manager profile; imports all Home Manager modules and sets user identity.
