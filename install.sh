#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

set -e
set -o pipefail

create_directory() {
    local repo_dir=$1
    if [ ! -d "$repo_dir" ]; then
        echo "creating directory ${repo_dir}..."
        mkdir -p ${repo_dir}
    fi
}

clone_and_checkout() {
    local repo_url=$1
    local repo_dir=$2
    local branch=$3

    repo_url=${repo_url/git@github.com:/https://github.com/}

    if [ -d "$repo_dir" ]; then
        if [ -d "$repo_dir/.git" ]; then
            echo "repository $repo_dir already exists, updating..."
            cd "$repo_dir"
            git fetch origin
            git checkout "$branch"
            git pull origin "$branch"
            cd ..
        else
            echo "cloning $repo_url into $repo_dir..."
            rm -rf "$repo_dir"
            git clone --branch "$branch" "$repo_url" "$repo_dir"
        fi
    else
        echo "cloning $repo_url into $repo_dir..."
        git clone --branch "$branch" "$repo_url" "$repo_dir"
    fi
}

create_symlink() {
    local target=$1
    local link=$2
    if [ -L "$link" ] || [ -e "$link" ]; then
        echo "symlink $link already exists, skipping..."
    else
        echo "creating symlink: $link -> $target"
        ln -s "$target" "$link"
    fi
}

pushd ../

# ------------------------------------------------------------
# Parameter
# ------------------------------------------------------------

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo ${BASE_DIR}

DEVCON_DIR=${BASE_DIR}/devcon
SSTATE_DIR="${YOCTO_SSTATE_DIR:-${BASE_DIR}/sstate-cache}"
DOWNLOAD_DIR="${YOCTO_DL_DIR:-${BASE_DIR}/downloads}"
APPLICATION_DIR=${BASE_DIR}/application

# ------------------------------------------------------------
# install devcon
# ------------------------------------------------------------

create_directory ${DEVCON_DIR}
clone_and_checkout "git@github.com:emblincram/devcon.git" "${DEVCON_DIR}" "main"

# create dev container softlinks
create_symlink "${DEVCON_DIR}/.devcontainer" "$BASE_DIR/.devcontainer"

# ------------------------------------------------------------
# install project worker
# ------------------------------------------------------------

create_symlink "${BASE_DIR}/meta-emblincram/.github" "$BASE_DIR/.github"

# ------------------------------------------------------------
# create cache and donwloads links
# ------------------------------------------------------------

create_directory ${SSTATE_DIR}
create_directory ${DOWNLOAD_DIR}
create_symlink ${SSTATE_DIR} "$BASE_DIR/sstate-cache"
create_symlink ${DOWNLOAD_DIR} "$BASE_DIR/downloads"

# ------------------------------------------------------------
# inatall applications
# ------------------------------------------------------------

create_directory ${APPLICATION_DIR}

clone_and_checkout "git@github.com:emblincram/distrap.git" "${APPLICATION_DIR}/distrap" "main"
clone_and_checkout "git@github.com:emblincram/heartbeat.git" "${APPLICATION_DIR}/heartbeat" "main"
clone_and_checkout "git@github.com:emblincram/helloly.git" "${APPLICATION_DIR}/helloly" "main"
clone_and_checkout "git@github.com:emblincram/streamer.git" "${APPLICATION_DIR}/streamer" "main"

popd
