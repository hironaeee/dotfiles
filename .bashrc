#!/usr/bin/env bash

export LANG="en_US.UTF-8"
# export LANG="ja_JP.eucJP"
# export LANG="ja_JP.UTF-8"

export TERM="xterm-256color"

# Homebrew
export PATH=/opt/homebrew/bin:$PATH
# NodeJS
export PATH=$HOME/.nodebrew/current/bin:$PATH

# Prompt
# Show random face according to the command return code
rand_face() {
  face="\$(\
    ret=\$?
    rand=\$((RANDOM%36));\
    if [ \$ret -eq 0 ];then\
      if [ \$rand -lt 3 ];then
        printf '\[\e[m\](^_^)\[\e[m\]';\
      elif [ \$rand -lt 5 ];then\
        printf '\[\e[m\](^_-)\[\e[m\]';\
      elif [ \$rand -lt 6 ];then\
        printf '\[\e[m\](.^.)\[\e[m\]';\
      else\
        printf '\[\e[m\](-_-)\[\e[m\]';\
      fi;\
    else\
      if [ \$rand -lt 6 ];then\
        printf '\[\e[31m\](@o@)\[\e[m\]';\
      elif [ \$rand -lt 12 ];then\
        printf '\[\e[31;1m\](>_<)\[\e[m\]';\
      elif [ \$rand -lt 18 ];then\
        printf '\[\e[35m\](*_*)\[\e[m\]';\
      elif [ \$rand -lt 24 ];then\
        printf '\[\e[34m\](T_T)\[\e[m\]';\
      elif [ \$rand -eq 30 ];then\
        printf '\[\e[34;1m\](/_T)\[\e[m\]';\
      else\
        printf '\[\e[31m\](>_<)\[\e[m\]';\
      fi\
    fi;\
    )"
  echo -n $face
}
# Shorten full path like `fish` shell
short_pwd() {
  cwd="\$(\
    pwd |\
    sed -e \"s@^\$HOME@~@\" |\
    awk -F'/' '{for(i=1;i<NF;++i) printf substr(\$(i), 0, 1) \"/\"; printf \$NF}'\
    )"
  echo -n $cwd
}
export PS1="$(rand_face) $(short_pwd) \$ "

# Aliases
if type nvim >& /dev/null; then
  alias vim="nvim"
fi

alias l="/bin/ls"
if [[ "$OSTYPE" =~ linux ]] || [[ "$OSTYPE" =~ cygwin ]];then
    if ls --color=auto --show-control-char >/dev/null 2>&1;then
        alias ls="ls --color=auto --show-control-char"
        alias la="ls -A --color=auto --show-control-char"
    else
        alias ls="ls --color=auto"
        alias la="ls -A --color=auto"
    fi
elif [[ "$OSTYPE" =~ darwin ]];then
    alias ls="ls -G"
    alias la="ls -A -G"
fi
alias lt="ls -altr"

# Editors
export VISUAL=vim
export EDITOR=vim
export PAGER=less

# History
shopt -s cmdhist # a multiple-line command in the same entry in history
HISTSIZE=500000
HISTFILESIZE=100000
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="cd:cd -:cd ../:ls:l:la:lt:pwd*:history:exit"

# Syntax highlighting / Auto completion
ble_sh=~/.local/share/blesh/ble.sh
if [[ -f $ble_sh ]]; then
  source $ble_sh
  bleopt prompt_eol_mark=
  bleopt exec_errexit_mark=
  bleopt exec_exit_mark=
  bleopt edit_marker=
  bleopt edit_marker_error=
fi
