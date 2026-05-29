# matt-nix

Host configuration for the MacBook with username `matt-nix`.

## Files

- `default.nix` - imports `modules/macbook`, the shared MacBook profile.
- `settings.nix` - user-specific values: `username`, `homeDirectory`, `fullName`, `email`, and Firefox profile configuration.

## Adding a New Host

1. Create a new directory under `hosts/` named after the macOS username.
2. Add a `default.nix` importing `../../modules/macbook`.
3. Add a `settings.nix` modelled on this one with the new user's values.

The flake discovers host directories automatically — no changes to `flake.nix` are needed.
