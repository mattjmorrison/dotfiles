# Rules

1. Only modify files that are tracked in this repository's source control. Do not edit files outside the repo (e.g. `~/.config`, `~/.local`, system paths).
2. Before making any code change, write a test file that exhibits the desired behavior. The test must fail before the change and pass after.
3. Prefer existing configuration options over custom code. Before writing any custom Lua, keymaps, or plugin overrides, check whether the tool, plugin, or framework already exposes a setting that achieves the desired behavior. Only write custom code when no configuration option exists.
4. Do not suppress or skip errors, warnings, or lint failures (e.g. `# shellcheck disable`, `--no-verify`, `|| true`) without first discussing with the user and getting explicit approval. Fix the root cause instead.

See `docs/decisions/` for context on past architectural decisions.
