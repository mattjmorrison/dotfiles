#!/usr/bin/env bats

setup_file() {
  ROOT_DIR="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  SESSION="dotfiles-nvim-nav-$$"
  SOCKET="$ROOT_DIR/.nvim-dev/tmux-integration-$$.sock"
  TMUX=(tmux -S "$SOCKET" -f "$ROOT_DIR/config/tmux/tmux.conf")
  NVIM_DEV_ENV=(
    XDG_CONFIG_HOME="$ROOT_DIR/config"
    XDG_STATE_HOME="$ROOT_DIR/.nvim-dev/state"
    XDG_CACHE_HOME="$ROOT_DIR/.nvim-dev/cache"
  )

  mkdir -p "$ROOT_DIR/.nvim-dev"

  "${TMUX[@]}" new-session -d -s "$SESSION" -x 120 -y 40 -c "$ROOT_DIR" \
    env "${NVIM_DEV_ENV[@]}" nvim

  NVIM_PANE="$(active_pane)"
  SHELL_PANE="$("${TMUX[@]}" split-window -h -t "$SESSION" -c "$ROOT_DIR" -P -F '#{pane_id}')"

  export ROOT_DIR SESSION SOCKET NVIM_PANE SHELL_PANE
}

teardown_file() {
  tmux -S "$SOCKET" kill-server >/dev/null 2>&1 || true
  rm -f "$SOCKET"
}

setup() {
  TMUX=(tmux -S "$SOCKET" -f "$ROOT_DIR/config/tmux/tmux.conf")
}

active_pane() {
  "${TMUX[@]}" display-message -p -t "$SESSION" '#{pane_id}'
}

pane_option() {
  local pane="$1"
  local option="$2"

  "${TMUX[@]}" show-options -p -t "$pane" -v "$option" 2>/dev/null || true
}

wait_for() {
  local condition="$1"

  for _ in {1..100}; do
    if eval "$condition"; then
      return 0
    fi
    sleep 0.05
  done

  return 1
}

assert_active_pane() {
  local expected="$1"

  wait_for "[[ \"\$(active_pane)\" == \"$expected\" ]]"
}

assert_root_nav_binding() {
  local key="$1"
  local tmux_direction="$2"

  "${TMUX[@]}" list-keys -T root "$key" | grep -F "#{@pane-is-vim}" | grep -F "select-pane $tmux_direction"
}

press_root_nav_key() {
  local key="$1"
  local tmux_direction="$2"

  "${TMUX[@]}" if-shell -F -t "$SESSION" "#{@pane-is-vim}" "send-keys $key" "select-pane $tmux_direction"
}

@test "tmux root Ctrl-h binding routes through pane-is-vim" {
  assert_root_nav_binding C-h -L
}

@test "tmux root Ctrl-l binding routes through pane-is-vim" {
  assert_root_nav_binding C-l -R
}

@test "smart-splits marks the Neovim pane for tmux passthrough" {
  wait_for "[[ \"\$(pane_option \"$NVIM_PANE\" '@pane-is-vim')\" == '1' ]]"
}

@test "Ctrl-h moves from a shell tmux pane into the Neovim tmux pane" {
  "${TMUX[@]}" select-pane -t "$SHELL_PANE"

  press_root_nav_key C-h -L

  assert_active_pane "$NVIM_PANE"
}

@test "Ctrl-l leaves a Neovim pane for the adjacent tmux pane" {
  "${TMUX[@]}" select-pane -t "$NVIM_PANE"

  press_root_nav_key C-l -R

  assert_active_pane "$SHELL_PANE"
}
