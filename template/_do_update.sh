#!/bin/sh

mount -o remount,rw /

TARGET_DIR="/userdata/PenMods"
TEMP_DIR=$(pwd)

cp -f "$TEMP_DIR/libPenMods.so" "$TARGET_DIR/libPenMods.so" || exit 255

# 2.4.0 起包里同时带 QML 资源库：设备上若已存在 libPenModsResources.so
# （Engine.cpp 会优先使用它），只更新主库会出现"新 C++ + 旧 QML"的错配。
if [ -f "$TEMP_DIR/libPenModsResources.so" ]; then
    cp -f "$TEMP_DIR/libPenModsResources.so" "$TARGET_DIR/libPenModsResources.so" || exit 255
fi

touch "$TEMP_DIR/INSTALL_SUCCESSFULLY"
