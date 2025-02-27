#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

create_directory() {
    local repo_dir=$1
    if [ ! -d "$repo_dir" ]; then
        echo "create ${repo_dir}..."
        mkdir -p ${repo_dir}
    fi
}

clone_and_checkout() {
    local repo_url=$1
    local repo_dir=$2
    local branch=$3

    if [ -d "$repo_dir" ]; then
        if [ -d "$repo_dir/.git" ]; then
            echo "Repository $repo_dir existiert bereits und ist ein Git-Repository."
            cd "$repo_dir"
            git fetch origin
            git checkout "$branch"
            git pull origin "$branch"
            cd ..
        else
            echo "Verzeichnis $repo_dir existiert, ist aber kein Git-Repository. Lösche und klone neu."
            rm -rf "$repo_dir"
            git clone --branch "$branch" "$repo_url" "$repo_dir"
        fi
    else
        echo "Klonen von $repo_url nach $repo_dir..."
        git clone --branch "$branch" "$repo_url" "$repo_dir"
    fi
}

pushd ../

# ------------------------------------------------------------
# Parameter
# ------------------------------------------------------------

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo ${BASE_DIR}

DEVCON_DIR=${BASE_DIR}/devcon
SSTATE_DIR="${BASE_DIR}/../../sstate-cache"
DOWNLOAD_DIR="${BASE_DIR}/../../downloads"
APPLICATION_DIR=${BASE_DIR}/application

# ------------------------------------------------------------
# install devcon
# ------------------------------------------------------------

create_directory ${DEVCON_DIR}
clone_and_checkout "git@github.com:emblincram/boxy.git" "${DEVCON_DIR}" "main"

# create dev container softlinks
ln -s "${DEVCON_DIR}/.devcontainer" "$BASE_DIR/.devcontainer"
ln -s "${DEVCON_DIR}/.github" "$BASE_DIR/.github"

# ------------------------------------------------------------
# create cache and donwloads links
# ------------------------------------------------------------

create_directory ${SSTATE_DIR}
create_directory ${DOWNLOAD_DIR}

ln -s ${SSTATE_DIR} "$BASE_DIR/sstate-cache"
ln -s ${DOWNLOAD_DIR} "$BASE_DIR/downloads"

# ------------------------------------------------------------
# inatall applications
# ------------------------------------------------------------

create_directory ${APPLICATION_DIR}

clone_and_checkout "git@github.com:emblincram/distrap.git" "${APPLICATION_DIR}/distrap" "main"
clone_and_checkout "git@github.com:emblincram/heartbeat.git" "${APPLICATION_DIR}/heartbeat" "main"
clone_and_checkout "git@github.com:emblincram/helloly.git" "${APPLICATION_DIR}/helloly" "main"
clone_and_checkout "git@github.com:emblincram/streamer.git" "${APPLICATION_DIR}/streamer" "main"

popd
