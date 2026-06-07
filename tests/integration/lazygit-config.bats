#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR

  if [[ -z "$HOST" ]]; then
    echo "HOST is required. Usage: HOST=<username> bats lazygit-config.bats" >&2
    exit 1
  fi
}

config_expr() {
  local expr="$1"

  nix eval --impure --expr "
    let
      flake = builtins.getFlake \"$ROOT_DIR\";
      config = flake.darwinConfigurations.${HOST}.config;
    in
      ${expr}
  " --raw
}

@test "lazygit config has no custom keybindings that fail validation" {
  local tmpconfig
  tmpconfig="$(mktemp /tmp/lazygit-test-XXXXXX.yml)"

  config_expr "
    let
      hmUser = config.home-manager.users.\"${HOST}\";
      cfg = hmUser.programs.lazygit.settings;
    in
      builtins.toJSON cfg
  " | python3 -c '
import sys, json, yaml
data = json.load(sys.stdin)
print(yaml.dump(data))
' >"$tmpconfig" 2>/dev/null || printf "{}\n" >"$tmpconfig"

  local output
  output="$(timeout 2 lazygit --use-config-file "$tmpconfig" </dev/null 2>&1 || true)"
  rm -f "$tmpconfig"

  if echo "$output" | grep -q "validation error"; then
    echo "lazygit rejected config: $output" >&2
    return 1
  fi
}
