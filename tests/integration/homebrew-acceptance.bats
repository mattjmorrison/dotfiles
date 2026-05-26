#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  export ROOT_DIR
}

@test "login shell can resolve homebrew, colima, and docker" {
  run /bin/zsh -lic 'command -v brew >/dev/null && command -v colima >/dev/null && command -v docker >/dev/null'

  [ "$status" -eq 0 ]
}

@test "homebrew formulas are installed" {
  run /bin/zsh -lic '
    brew="$(command -v brew)" || exit 1
    [ -x "$brew" ] || exit 1
    "$brew" list --formula colima >/dev/null 2>&1
    "$brew" list --formula docker >/dev/null 2>&1
  '

  [ "$status" -eq 0 ]
}
