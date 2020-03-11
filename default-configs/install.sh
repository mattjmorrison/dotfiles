function dotfiles-add(){
    repo=$1
    name="${repo##*/}"
    dest="${HOME}/dotfiles/custom-configs/${name}"
    hub clone ${1} ${dest}
    install-custom-config $dest
}

function dotfiles-update(){
    git -C ~/dotfiles pull origin master
    for config in `find ~/dotfiles/custom-configs -maxdepth 2 -mindepth 1 -type d -name .git`
    do
        DIR=$(dirname $config)
        git -C $DIR pull origin master
        install-custom-config $DIR
    done
}

function install-custom-config(){
    DIR=$1
    if [[ -a "${DIR}/install" ]]; then
        source "${DIR}/install"
    fi
}
