# Pyenv Setup <<1
PATH=~/.pyenv/shims:$PATH
LDFLAGS="-L/usr/local/opt/zlib/lib"  # hack for install on Mojave
CPPFLAGS="-I/usr/local/opt/zlib/include"  # hack for install on Mojave
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# >>1

#===============================================================================
# Workon virtualenv <<1
#--------------------------------------------------------------------
# If we cd into a directory that is named the same as a virtualenv
# auto activate that virtualenv
# -------------------------------------------------------------------

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

workon_virtualenv() {
  if [[ -d .git ]]; then
     VENV_CUR_DIR="${PWD##*/}"
     if [[ -a ~/.pyenv/versions/$VENV_CUR_DIR ]]; then
        pyenv deactivate > /dev/null 2>&1
        pyenv activate $VENV_CUR_DIR
     fi
  fi
}
# >>1

# Run the virtual environments functions for the prompt on each cd <<2
# -------------------------------------------------------------------
cd() {
  builtin cd "$@"
  workon_virtualenv
}
# >>2
