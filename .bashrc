# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.2-3

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
source /usr/share/bash-completion/bash_completion
source ~/.git-completion.bash
source ~/.make-completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# Add tmie information in history file. See it with the command "history"
export HISTTIMEFORMAT="%d/%m/%y %T "

#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Allow more expansions
shopt -s extglob

# Enable more sloppy spelling of directories
shopt -s cdspell

# Enable easy access to frequently used folders
export CDPATH=.:/cygdrive/c/myCC:/cygdrive/d/myGitD:/cygdrive/c/myGit:~/.shortcuts

# This is an alternative way of shortcuts taken from "http://aaverin.github.io/unix/macox/2014/05/26/bash-named-folders/"
# Now instead a .shortcuts folder is added to CDPATH
#source $HOME/bin/cd_wrapper



# Set the editor to sublime
#export VISUAL="/cygdrive/c/Program\ Files/Sublime\ Text\ 2/sublime_text.exe -n -w"
export VISUAL="subl"
export EDITOR="$VISUAL"

# Set the prompt
# Use the git-prompt whenever in a git clone subfolder
source ~/.git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=1
PS1='\t ${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\h\[\033[00m\] $(__git_ps1 " (%s)")\[\033[01;34m\]\w\[\033[00m\] \$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac


# Aliases
#
# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
   source "${HOME}/.bash_aliases"
fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias cdgit='cd `git rev-parse --show-toplevel`'  # goto git root folder
alias msgit='_msgit(){ (PATH="/cygdrive/c/Program Files (x86)/Microsoft Visual Studio/2017/Professional/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer/Git/mingw32/bin":"/cygdrive/c/Program Files (x86)/Microsoft Visual Studio/2017/Professional/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer/Git/mingw32/lib/engines":"/cygdrive/c/Program Files (x86)/Microsoft Visual Studio/2017/Professional/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer/Git/mingw32/lib/pkcs11":"/cygdrive/c/Program Files (x86)/Microsoft Visual Studio/2017/Professional/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer/Git/mingw32/libexec/git-core":$PATH ; /cygdrive/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2017/Professional/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team\ Explorer/Git/mingw32/bin/git.exe $@ ); }; _msgit'
alias wgit='_wgit(){ PATH="/cygdrive/c/Program Files/Git/bin":"/cygdrive/c/Program Files/Git/bin":"/usr/local/bin":"/usr/bin" "/cygdrive/c/Program Files/Git/bin/git.exe" $@; }; time _wgit'
#
# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'   

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
fi

#Set DISPLAY to be able to use XWin (Also in .ssh/config set "ForwardX11Trusted yes" and "ForwardX11 yes")
export DISPLAY=:0.0

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
settitle () 
{ 
  echo -ne "\e]2;$@\a\e]1;$@\a"; 
}
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias cd=cd_func
# Add $HOME/bin to PATH
export PATH=$PATH:~/bin

## Use Windows native python instead of cygwin python

#export PATH=/cygdrive/c/Python27/:/cygdrive/c/Python27/Scripts:$PATH
#alias python2.7=/cygdrive/c/Python27/python.exe
#alias python=/cygdrive/c/Python27/python.exe
#alias pip=/cygdrive/c/Python27/Script/pip.exe
#alias pip2=/cygdrive/c/Python27/Script/pip2.exe
#alias pip2.7=/cygdrive/c/Python27/Script/pip2.7.exe
#export PYTHONUNBUFFERED=1  # Required for windows python in cygwin console


_make()
{
    local mdef makef makef_dir="." makef_inc gcmd cur prev i;
    COMPREPLY=();
    cur=${COMP_WORDS[COMP_CWORD]};
    prev=${COMP_WORDS[COMP_CWORD-1]};

    #See if we have specified a target folder
    for (( i=0; i < ${#COMP_WORDS[@]}; i++ )); do
        if [[ ${COMP_WORDS[i]} == -C ]]; then
           # eval for tilde expansion
           eval makef_dir=${COMP_WORDS[i+1]}
           break
        fi
    done
    case "$prev" in
        -f|--file|--makefile|-o|--old-file|--assume-old|-W|--what-if|\
        --new-file|--assume-new)
            shopt -s extglob
           COMPREPLY=($(cd ${makef_dir} >/dev/null && compgen -X '!@(*.mk|*Makefile)' -f $cur));
            return 0
        ;;
        -C)
            COMPREPLY=($(compgen -d -S/ $cur));
            return 0
        ;;
    esac;
    case "$cur" in
        --*)
            COMPREPLY=($(_get_longopts $1 $cur));
            return 0
        ;;
        -*)
            COMPREPLY=($(_get_shortopts $1 $cur));
            return 0
        ;;
    esac;

        # Before we scan for targets, see if a Makefile name was
        # specified with -f ...
        for (( i=0; i < ${#COMP_WORDS[@]}; i++ )); do
            if [[ ${COMP_WORDS[i]} == -f ]]; then
               # eval for tilde expansion
               eval makef=${COMP_WORDS[i+1]}
               break
            fi
        done
        if [[ ! -f ${makef_dir}/$makef ]]; then
            # make reads `GNUmakefile', then `makefile', then `Makefile'
            if [ -f ${makef_dir}/GNUmakefile ]; then
                makef=${makef_dir}/GNUmakefile
            elif [ -f ${makef_dir}/makefile ]; then
                makef=${makef_dir}/makefile
            elif [ -f ${makef_dir}/Makefile ]; then
                makef=${makef_dir}/Makefile
            fi
        fi
        [ ! -f ${makef_dir}/$makef ] && return 0

        [[ -n $makef ]] && makef="-f ${makef}"
        [[ -n $makef_dir ]] && makef_dir="-C ${makef_dir}"

        COMPREPLY=( $( compgen -W "$( make -qp $makef $makef_dir 2>/dev/null | \
            perl -ne 'if (m/^([a-zA-Z0-9][^#\/\t=]*):([^=]|$)/) {foreach (split " ",$1) {print "$_\n";}}' \
            -e 'elsif (m/^([A-Z][A-Z0-9_]*)\s*(=|:=)/) {print "$1=\n"}' \
            -e 'foreach (m/\$\(([A-Z][A-Z0-9_]*)\)/g) {print "$_=\n"}' )" \
            -- "$cur" ) )

#       COMPREPLY=( $( compgen -W "$( make -qp $makef $makef_dir 2>/dev/null | \
#           awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ \
#           {split($1,A,/ /);for(i in A)print A[i]}' )" \
#           -- "$cur" ) )

}
complete -o nospace -F _make make gmake pmake

