#/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

TARGET_DIR="/mnt/ssd/work/bbb-sdk/"

ENV_FILE=$(find "$TARGET_DIR" -type f -name "environment-setup-*" | head -n 1)

if [ -z "$ENV_FILE" ]; then
    echo "error: no proper ENV-file found."
    exit 1
fi

source "${ENV_FILE}"
