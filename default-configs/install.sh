function dotfiles-add(){
    repo=$1
    name="${repo##*/}"
    dest="${HOME}/dotfiles/custom-configs/${name}"
    hub clone ${1} ${dest}
    if [[ -a "${dest}/install.sh" ]]; then
        source "${dest}/install.sh"
    fi
}
