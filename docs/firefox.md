# Firefox Configuration

This repo installs Firefox Developer Edition through Homebrew and manages Firefox profiles through Home Manager.

## App Install

The macOS app is installed as a Homebrew cask in:

```text
modules/darwin/homebrew.nix
```

Current cask:

```text
firefox@developer-edition
```

## Profile Management

Firefox profile files are managed in:

```text
modules/home/firefox.nix
```

Profile names and the default profile are defined in:

```text
settings.nix
```

The Home Manager Firefox module is enabled with:

```nix
programs.firefox = {
  enable = true;
  package = null;
};
```

`package = null` keeps Home Manager from installing a separate Firefox package. The browser app remains managed by Homebrew, while profile metadata is managed declaratively.

Home Manager writes:

```text
~/Library/Application Support/Firefox/profiles.ini
```

and creates profile directories under:

```text
~/Library/Application Support/Firefox/Profiles/
```

## Profile Extensions

Bitwarden is declared on the `mattjmorrison` profile in:

```text
settings.nix
```

`modules/home/firefox.nix` reads the profile extension list from `settings.firefox.profiles` and turns the named extension into the corresponding Firefox add-on package. The same profile record can also carry Firefox prefs, such as `sidebar.verticalTabs` and `sidebar.position_start` for vertical tabs on the right. Other Firefox profiles do not receive it.

## Profiles

Profile names are defined in `settings.firefox.profiles`.

The default profile is defined in `settings.firefox.defaultProfile`.

The generated Home Manager profile IDs are assigned from the profile list order, starting at `0`. Each profile uses its profile name as both the Firefox profile name and profile directory path.
