function dotfiles-add(){
    repo=$1
    name="${repo##*/}"
    dest="${HOME}/dotfiles/custom-configs/${name}"
    hub clone ${1} ${dest}
    if [[ -a "${dest}/install" ]]; then
        source "${dest}/install"
    fi
}

function dotfiles-update(){
    git -C ~/dotfiles pull origin master
    for config in `find ~/dotfiles/custom-configs -maxdepth 2 -mindepth 1 -type d -name .git`
    do
        git -C $(dirname $config) pull origin master
    done
}
