#!/usr/bin/env bash

cd "$(dirname "{BASH_SOURCE[0]}")" || exit 1

BASE=$(pwd -P)

# create a backup folder
mkdir -pv bak

# create links
for rc in .*rc .*profile; do
  [ -e ~/"$rc" ] && mv -v ~/"$rc" bak/"$rc"_$(date '+%Y%m%d%H%M%S')
  ln -sfv "$BASE/$rc" ~/"$rc"
done
mkdir -pv ~/.config
for config in .config/*; do
  if [ ! -e ~/"$config" ]; then
    ln -sfv "$BASE/$config" ~/"$config"
  fi
done
