#
# ~/.bashrc
#

[[ $- != *i* ]] && return

export LANG=en_US.utf8
export NNTPSERVER="news.epita.fr"

export EDITOR=vim
export PAGER=less

man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

exitst()
{
  stat=$?
  if [ $stat == 0 ]; then
    echo -e "\e[0m0\e[33m"
  else
    echo -e "\E[1m\e[31m$stat"
  fi
}

PS1='\[\e[33m\e[1m\][\[\e[21m\e[0m\]\W\[\e[1m\e[33m\]] \[\e[21m\]$(exitst) \[\e[1m\]> \[\e[0m\]'

shopt -s histappend

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export EDITOR="vim"
alias gits="git status"
alias gitl="git log --oneline --decorate --all"
alias ll="ls -lh"
alias la="ls -alh"
alias xclip="xclip -selection c"
alias ls='ls --color=auto'
alias grep='grep --color=always'
