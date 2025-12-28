#!/bin/sh

mount -o remount,rw /

TARGET_DIR="/userdata/PenMods"
TEMP_DIR=$(pwd)

cp -f "$TEMP_DIR/libPenMods.so" "$TARGET_DIR/libPenMods.so" || exit 255

touch "$TEMP_DIR/INSTALL_SUCCESSFULLY"
