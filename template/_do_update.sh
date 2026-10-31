#!/bin/sh
set -eu
package_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$package_dir"
rm -f INSTALL_SUCCESSFULLY
prefix=${PENMODS_BOOTSTRAP_PREFIX:-}
case "$prefix" in ''|/*) ;; *) echo "bootstrap prefix must be absolute" >&2; exit 1 ;; esac
module_dir=$prefix/userdata/PenMods
root=$prefix/userdisk/PenMods/update-system
helper=$module_dir/penmods-update
snapshot_mode=--snapshot-only
reenabling=0
if [ -e "$root/disabled" ]; then
    snapshot_mode=--reinstall-snapshot
    reenabling=1
fi
mkdir -p "$module_dir"
temporary=$helper.new.$$
[ ! -e "$temporary" ] && [ ! -L "$temporary" ] || { echo "bootstrap scratch file already exists" >&2; exit 1; }
trap 'rm -f "$temporary"' EXIT HUP INT TERM
cp penmods-update "$temporary"
chmod 755 "$temporary"
sync
mv -f "$temporary" "$helper"
sync
# Snapshot first. Neither imports nor stage may replace old app aliases.
if [ -n "$prefix" ]; then
    "$helper" --root "$root" --prefix "$prefix" --core-version 0.0.0 init "$snapshot_mode"
    "$helper" --root "$root" --prefix "$prefix" stage "$package_dir/core-descriptor.json" "$package_dir/core-package.zip"
    sh "$package_dir/install-launcher.sh" --rootfs-prefix "$prefix"
else
    "$helper" --root "$root" --core-version 0.0.0 init "$snapshot_mode"
    "$helper" --root "$root" stage "$package_dir/core-descriptor.json" "$package_dir/core-package.zip"
    mount -o remount,rw /
    sh "$package_dir/install-launcher.sh"
fi
if [ "$reenabling" = 1 ]; then
    if [ -n "$prefix" ]; then
        "$helper" --root "$root" --prefix "$prefix" enable
    else
        "$helper" --root "$root" enable
    fi
fi
sync
touch INSTALL_SUCCESSFULLY
trap - EXIT HUP INT TERM
