#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_directory> <target_directory>"
  exit 1
fi

SOURCE_DIR="$1"
TARGET_DIR="$2"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Fehler: Quellverzeichnis '$SOURCE_DIR' existiert nicht oder ist kein Verzeichnis."
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "Fehler: Zielverzeichnis '$TARGET_DIR' existiert nicht oder ist kein Verzeichnis."
  exit 1
fi

scripts=(
flash_emmc.sh
flash_sd-card.sh
install_sdk.sh
prepare_sd_card.sh
save_config.sh
)

for script in "${scripts[@]}"; do
  script_path="$SOURCE_DIR/$script"
  if [ -f "$script_path" ]; then
    if command -v realpath >/dev/null 2>&1; then
      rel_path=$(realpath --relative-to="$TARGET_DIR" "$script_path")
    else
      rel_path="$script_path"
    fi

    target_link="$TARGET_DIR/$script"
    
    if [ -e "$target_link" ]; then
      echo "Entferne vorhandenen Link/Datei: $target_link"
      rm -f "$target_link"
    fi

    ln -s "$rel_path" "$target_link"
    echo "Erstellt: $target_link -> $rel_path"
    
  else
    echo "Skript $script nicht gefunden in $SOURCE_DIR"
  fi
done
