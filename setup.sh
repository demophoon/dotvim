#!/bin/bash

# Paranoid mode. Exit on error.
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HOMEDIR=${HOME:?}
merge_directories=(
    .config
)
ignoredfiles=(
    .git
    .gitmodules
    LICENSE.md
    README.md
    setup.sh
    update.sh
    classify.sh
    custom
    utils
    .DS_Store
    assets
    files
    Filefile
)
replaced_files=(
)

for class in $("${DIR:?}/classify.sh"); do
    echo "class: ${class}"
    case $class in
        hd)
            ;;
    esac
done
exit

# If we force links to directories which we are deep merging, we gonna have a bad time...
ignoredfiles+=(${merge_directories[@]})

createLinks() {
    for f in ${DIR:?}/{*,.*}; do
        filename=$(basename "$f")
        if [[ ${ignoredfiles[*]} =~ $filename ]]; then
            continue
        fi
        rm -rf "${HOMEDIR:?}/${filename:?}" > /dev/null
        ln -s "${DIR:?}/${filename:?}" "${HOMEDIR:?}/${filename:?}"
    done
}

realizeDirectories() {
    filepath=${1:?}
    realize_path="${HOMEDIR:?}/${filepath%/*}"
    if [ ! -d "${realize_path:?}" ]; then
        mkdir -p "${realize_path:?}"
    fi
}

deepMergeDir() {
    mergePath=${1:?}
    if [ ! -d ${mergePath:?} ]; then
        if [ -e ${mergePath:?} ]; then
            dotfiles_file=${mergePath#$DIR/}
            realizeDirectories ${dotfiles_file}
            rm -f "${HOMEDIR:?}/${dotfiles_file:?}"
            ln -s "${DIR:?}/${dotfiles_file:?}" "${HOMEDIR:?}/${dotfiles_file:?}"
        fi
    else
        for dir in $(find ${mergePath:?}/* -maxdepth 0); do
            deepMergeDir "${dir:?}"
        done
    fi
}

mergeDirs() {
    for dir in ${merge_directories:?}; do
        deepMergeDir "${DIR:?}/${dir:?}"
    done
}

replaceLink() {
    src=$1
    dest=$2

    echo unlink "${HOMEDIR:?}/${src:?}"
    echo ln -s "${DIR:?}/${dest:?}" "${HOMEDIR:?}/${src:?}"
}

replaceLinks() {
    for link in "${replaced_files[@]}"; do
        l=($(echo ${link/:/ }))
        replaceLink "${l[0]}" "${l[1]}"
    done
}

linkDotfiles() {
    createLinks
    mergeDirs
    replaceLinks
}

if [ "$1" = '-f' -o "$1" = '--force' ]; then
    linkDotfiles
else
    read -n 1 -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " reply
    echo

    reply=$(echo "$reply" | tr '[:upper:]' '[:lower:]')

    if [ "${reply}" = 'y' ]; then
        linkDotfiles
    fi
fi
