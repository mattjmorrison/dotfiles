#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<hostname> bats lazygit-config.bats" >&2
    exit 1
  fi

  USERNAME="$(nix eval --impure --expr "(import $ROOT_DIR/hosts/$HOST/settings.nix).username" --raw)"
  export USERNAME
}

config_expr() {
  local expr="$1"

  nix eval --impure --expr "
    let
      flake = builtins.getFlake \"$ROOT_DIR\";
      config = flake.configurations.${HOST}.config;
    in
      ${expr}
  " --raw
}

@test "lazygit run does not corrupt terminal state" {
  local before after
  before="$(stty -g 2>/dev/null || echo 'no-tty')"
  setsid timeout --kill-after=1 2 lazygit --use-config-file /dev/null </dev/null 2>&1 || true
  after="$(stty -g 2>/dev/null || echo 'no-tty')"
  [ "$before" = "$after" ]
}

@test "lazygit config has no custom keybindings that fail validation" {
  local tmpconfig
  tmpconfig="$(mktemp /tmp/lazygit-test-XXXXXX.yml)"

  config_expr "
    let
      hmUser = config.home-manager.users.\"${USERNAME}\";
      cfg = hmUser.programs.lazygit.settings;
    in
      builtins.toJSON cfg
  " | python3 -c '
import sys, json, yaml
data = json.load(sys.stdin)
print(yaml.dump(data))
' >"$tmpconfig" 2>/dev/null || printf "{}\n" >"$tmpconfig"

  local output
  output="$(setsid timeout --kill-after=1 2 lazygit --use-config-file "$tmpconfig" </dev/null 2>&1 || true)"
  rm -f "$tmpconfig"

  if echo "$output" | grep -q "validation error"; then
    echo "lazygit rejected config: $output" >&2
    return 1
  fi
}
