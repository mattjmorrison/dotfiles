function dotfiles-add(){
    repo=$1
    name="${repo##*/}"
    dest="${HOME}/dotfiles/custom-configs/${name}"
    hub clone ${1} ${dest}
    if [[ -a "${dest}/install" ]]; then
        source "${dest}/install"
    fi
}
