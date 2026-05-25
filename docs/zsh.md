# Zsh Configuration

This repo manages zsh through nix-darwin and Home Manager.

## Where It Lives

System-level zsh support is enabled in:

```text
modules/darwin/system.nix
```

User-level zsh behavior is configured in:

```text
modules/home/shell.nix
```

There is no separate checked-in `.zshrc` file. Home Manager generates the user shell configuration from the Nix module settings.

## System-Level Setup

nix-darwin enables zsh at the macOS system level:

```nix
programs.zsh.enable = true;
```

That makes zsh available as a managed shell through the nix-darwin system configuration.

## Home Manager Setup

Home Manager enables zsh for the user:

```nix
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  initContent = builtins.readFile ../../config/zsh/aliases.zsh;
};
```

This configures:

- zsh itself
- shell completion
- command autosuggestions
- command syntax highlighting
- custom aliases from `config/zsh/aliases.zsh`

## Completion

Completion is enabled with:

```nix
enableCompletion = true;
```

Home Manager wires zsh completion into the generated shell configuration. This provides tab completion support for commands that expose completion definitions through the managed environment.

## Autosuggestions

Autosuggestions are enabled with:

```nix
autosuggestion.enable = true;
```

This enables zsh autosuggestions in interactive shells. Suggestions are based on command history and appear inline as you type.

## Syntax Highlighting

Syntax highlighting is enabled with:

```nix
syntaxHighlighting.enable = true;
```

This highlights commands while typing, which helps distinguish valid commands, invalid commands, strings, paths, and shell syntax before execution.

## Aliases

Custom aliases are loaded through Home Manager with:

```nix
initContent = builtins.readFile ../../config/zsh/aliases.zsh;
```

The current aliases are:

```zsh
alias vi='nvim'
alias vim='nvim'
```

## Prompt

The prompt is managed by Starship:

```nix
programs.starship = {
  enable = true;
  enableZshIntegration = true;
};
```

`enableZshIntegration` lets Home Manager initialize Starship from the generated zsh config, so zsh uses the Starship prompt automatically.

There is no custom Starship prompt format in this repo right now, so Starship uses its default configuration unless another local machine-level config exists outside this repository.

## Related Shell Configuration

The same Home Manager shell module also manages nearby terminal tooling:

- installs `tmux`
- links `config/tmux/tmux.conf` to `~/.tmux.conf`
- writes Ghostty config to `~/.config/ghostty/config.ghostty`
- sets the Ghostty theme to `TokyoNight Night`
- sets Ghostty to treat the macOS Option key as Alt

Those settings are not zsh options directly, but they live in the same shell module because they affect the interactive terminal environment.

## What Is Not Customized

The current repo does not define custom zsh settings for:

- shell functions
- environment variables
- PATH entries
- history behavior
- keybindings
- custom `.zshrc` text
- custom Starship prompt format

Add those to `modules/home/shell.nix` if they should be managed by this dotfiles repo.
