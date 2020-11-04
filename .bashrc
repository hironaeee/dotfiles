#!/usr/bin/env bash
# .bashrc

# Function for 'source file' with precheck of the file {{{
source_file () {
    if [ $# -lt 1 ]; then
        echo "ERROR!!! source_file is called without an argument"
        return
    fi
    arg="$1"
    shift
    if [ -r "$arg" ]; then
        source "$arg"
    fi
 
} # }}} Function for 'source file' with precheck of the file

# Shell/Environmental variables {{{
# Prompt
# PS1="[\[\e[1;32m\]\h \[\e[1;35m\]\W\[\e[0;37m\]]\$ "
PS1="\$(\
  ret=\$?
  rand=\$((RANDOM%36));\
  if [ \$ret -eq 0 ];then\
    if [ \$rand -lt 3 ];then
      printf '\[\e[m\](^_^)\[\e[m\] \$ ';\
    elif [ \$rand -lt 5 ];then\
      printf '\[\e[m\](^_-)\[\e[m\] \$ ';\
    elif [ \$rand -lt 6 ];then\
      printf '\[\e[m\](.^.)\[\e[m\] \$ ';\
    else\
      printf '\[\e[m\](-_-)\[\e[m\] \$ ';\
    fi;\
  else\
    if [ \$rand -lt 6 ];then\
      printf '\[\e[31m\](@o@)\[\e[m\] \$ ';\
    elif [ \$rand -lt 12 ];then\
      printf '\[\e[31;1m\](>_<)\[\e[m\] \$ ';\
    elif [ \$rand -lt 18 ];then\
      printf '\[\e[35m\](*_*)\[\e[m\] \$ ';\
    elif [ \$rand -lt 24 ];then\
      printf '\[\e[34m\](T_T)\[\e[m\] \$ ';\
    elif [ \$rand -eq 30 ];then\
      printf '\[\e[34;1m\](/_T)\[\e[m\] \$ ';\
    else\
      printf '\[\e[31m\](>_<)\[\e[m\] \$ ';\
    fi\
  fi;\
  )"

# Lang
# export LANG=C
# export LANG="en_GB.UTF-8"
export LANG="en_US.UTF-8"
# export LANG="ja_JP.eucJP"
# export LANG="ja_JP.UTF-8"
# export LC_ALL="en_GB.UTF-8"
export LC_ALL="en_US.UTF-8"
# export LC_ALL="ja_JP.UTF-8"
# export LC_MESSAGES="en_GB.UTF-8"
# export LC_DATE="en_GB.UTF-8"

# Editors
if type vim >& /dev/null;then
    export VISUAL=vim
    export EDITOR=vim
fi
export PAGER=less

export PATH=~/usr/bin:~/usr/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/usr/local/lib

# for my clipboards
export CLMAXHIST=100

# Homebrew
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
# for 'python3' symlink to 'python'
export PATH=$(brew --prefix)/opt/python3/libexec/bin:$PATH

# brew-file
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# }}} Environmental variables

# History {{{
HISTSIZE=500000
HISTFILESIZE=100000
# HISTCONTROL:
# ignoredups # ignore duplication
# ignorespace # ignore command starting with space
# ignoreboth # ignore dups and space
# erasedups # erase a duplication in the past
export HISTCONTROL="erasedups:ignoreboth"
# export HISTIGNORE="?:??:???:????:history:cd ../"
export HISTIGNORE="cd:cd -:cd ../:ls:l:pwd*:history:exit:bg:fg"

# add time to history
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S '

# Simple method to add history everytime {{{
#PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}history -a"
# }}}
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -u histappend

# }}} history

# Alias, Function {{{

alias l='/bin/ls'
if [[ "$OSTYPE" =~ linux ]] || [[ "$OSTYPE" =~ cygwin ]];then
    if ls --color=auto --show-control-char >/dev/null 2>&1;then
        alias ls='ls --color=auto --show-control-char'
        alias la='ls -A --color=auto --show-control-char'
    else
        alias ls='ls --color=auto'
        alias la='ls -A --color=auto'
    fi
elif [[ "$OSTYPE" =~ darwin ]];then
    alias ls='ls -G'
    alias ls='ls -A -G'
fi
alias lt='ls -altr'
# }}}

# Setup for each environment {{{
# vim, neovim
if type nvim >& /dev/null;then
  alias vi="nvim" # vi->nvim
  alias memo="nvim ~/.memo.md"
  alias vid="nvim -d"
  alias vinon="nvim -u NONE"
elif type vim >& /dev/null;then
  alias vim="vim -X" # no X
  alias vi="vim" # vi->vim
  alias memo="vim ~/.memo.md"
  alias vid="vim -d"
  alias vinon="vim -u NONE"
fi


# File used in linux
[[ "$OSTYPE" =~ linux ]] && source_file ~/.linuxrc

# File used in mac
[[ "$OSTYPE" =~ darwin ]] && source_file ~/.macrc

# File used in windows (cygwin)
#[[ "$OSTYPE" =~ cygwin ]] && source_file ~/.winrc
[[ "$OSTYPE" =~ linux-gnu ]] && [[ $(cat /proc/version | grep Microsoft) ]] && source_file ~/.winrc

# .localrc in each machine
[[ -e ~/.localrc ]] && source_file ~/.localrc

# return code 0
:
