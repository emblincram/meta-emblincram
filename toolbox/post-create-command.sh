#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

# parameter

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

WORKSPACE_PATH=$1

LAYER_DIRECTORY=${WORKSPACE_PATH}/meta-emblincram

echo "copy toolbox functions"
${LAYER_DIRECTORY}/toolbox/copy-tools.sh ${LAYER_DIRECTORY}/toolbox ${WORKSPACE_PATH}/build 

echo "copy environment activation script"
cp ${LAYER_DIRECTORY}/toolbox/activate-env.sh ${WORKSPACE_PATH}/

echo 'emblincram dev-container ready.'
