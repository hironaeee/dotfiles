#!/usr/bin/env bash

exclude=('.' '..' '.git' '.gitignore' 'README.md')
instdir="$HOME"

backup=""
overwrite=1
curdir=$(pwd -P)

# help
HELP="Usage: $0 [-b <backup file postfix>] [-e <exclude file>] [-i <install dir>]

Make links of dot files in home directory (default:$instdir)

Arguments:
	-b Set backup postfix, like \"bak\" (default: \"\": no backup is made)
	-e Set additional exclude file (default: ${exclude[*]})
	-i Set install directory (default: $instdir)
"
while getopts b:e:i OPT;do
  case $OPT in
    "b" ) backup=$OPTARG ;;  
    "e" ) exclude=("${exclude[@]}" "$OPTARG") ;;
    "i" ) instdir=$OPTARG ;;  
  esac
done

myinstall () {
  origin="$1"
  target="$2"
  if [ -z "$origin" ] || [ -z "$target" ]; then
    echo "Wrong args for myinstall: origin=$origin, target=$target"
    exit 1
  fi

  install_check=1

  newlink=("${newlink[@]}" "$(basename "$target")")
  if [ $install_check -eq 1 ];then
    mkdir -p "$(dirname "$target")"

    ln -s "$origin" "$target"
  fi
}

echo "*************************"
echo "Install .X to $instdir"
echo "*************************"
echo
for f in .*;do
  for e in "${exclude[@]}";do
    flag=0
    if [ "$f" = "$e" ];then
      flag=1
      break
    fi
  done
  if [ $flag = 1 ];then
    continue
  fi

  myinstall "$curdir/$f" "$instdir/$f"
done
