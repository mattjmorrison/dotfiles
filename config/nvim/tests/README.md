# Neovim movement tests

This directory is for development-only tests around Neovim cursor and window
movement behavior. It is intentionally outside `lua/` so normal Neovim startup
does not load these files.

Suggested layout:

- `minitest.lua`: headless test runner entry point
- `helpers/`: shared test helpers for child Neovim instances and assertions
- `specs/`: fast Neovim-only specs using mocked tmux/smart-splits behavior

Run with:

```sh
nvim --headless -u config/nvim/tests/minitest.lua
```

The runner sources `config/nvim/init.lua`, then loads each `*_spec.lua` file
under `specs/`. Specs should return a table where each key is a test name and
each value is a test function.

Keep real tmux integration tests outside this directory, for example under
`tests/integration/`, because those validate cross-tool behavior rather than the
Neovim config in isolation.

Run the tmux-backed navigation tests with:

```sh
make test-tmux-nvim
```
