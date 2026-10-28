#!/bin/sh
set -e

mount -o remount,rw /

TARGET_DIR="/userdata/PenMods"
TEMP_DIR=$(pwd)

# Keep the running application on its original inode until it restarts.
# Copying over a mapped shared library can corrupt its live code pages.
cp -f "$TEMP_DIR/libPenMods.so" "$TARGET_DIR/libPenMods.update.tmp.so"
if [ -f "$TEMP_DIR/libPenModsResources.so" ]; then
    cp -f "$TEMP_DIR/libPenModsResources.so" "$TARGET_DIR/libPenModsResources.update.tmp.so"
    mv -f "$TARGET_DIR/libPenModsResources.update.tmp.so" "$TARGET_DIR/libPenModsResources.so"
fi
mv -f "$TARGET_DIR/libPenMods.update.tmp.so" "$TARGET_DIR/libPenMods.so"
sync

touch "$TEMP_DIR/INSTALL_SUCCESSFULLY"
