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

# parameter

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <pfad>"
    exit 1
fi

WORKSPACE_PATH=$1

create_directory ${WORKSPACE_PATH}/build

# yocto layer for beagle-x15

clone_and_checkout "git://git.yoctoproject.org/poky" "${WORKSPACE_PATH}/poky" "kirkstone"
clone_and_checkout "git://git.yoctoproject.org/meta-ti" "${WORKSPACE_PATH}/meta-ti" "kirkstone"
clone_and_checkout "git://git.yoctoproject.org/meta-arm" "${WORKSPACE_PATH}/meta-arm" "kirkstone"
clone_and_checkout "git://git.openembedded.org/meta-openembedded.git" "${WORKSPACE_PATH}/meta-openembedded" "kirkstone"

