#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

# Attention: works proper only in build directory

CURRENT_DIR=$(pwd)

SDK_DIR="${CURRENT_DIR}/deploy-ti/sdk/"
TARGET_DIR="${CURRENT_DIR}/../sdk"
#SDK_NAME="poky-glibc-x86_64-core-image-full-cmdline-armv7at2hf-neon-beaglebone-toolchain-4.0.24"

SDK_FILE=$(find "$SDK_DIR" -type f -name "poky-*.sh" | head -n 1)
if [ -z "$SDK_FILE" ]; then
    echo "error: no SDK-file founds."
    exit 1
fi

backup_existing_dir() {
    local dir="$1"
    if [ -d "$dir" ]; then
        local timestamp=$(date +"%Y%m%d_%H%M%S")
        local backup_dir="${dir}.${timestamp}"
        mv "$dir" "$backup_dir"
        echo "backup current directory: $backup_dir"
    fi
}

backup_existing_dir "$TARGET_DIR"
"${SDK_FILE}" -d "${TARGET_DIR}"
