#!/usr/bin/env bash

cd "$(dirname "{BASH_SOURCE[0]}")" || exit 1

BASE=$(pwd -P)
for rc in .*rc .*profile .*.conf .*config; do
  mkdir -pv bak
  [ -e ~/"$rc" ] && mv -v ~/"$rc" bak/"$rc"_$(date '+%Y%m%d%H%M%S')
  ln -sfv "$BASE/$rc" ~/"$rc"
done

# nvim
mkdir -p ~/.config/nvim
ln -sfv "$BASE/.vimrc" ~/.config/nvim/init.vim
