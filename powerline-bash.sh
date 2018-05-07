function __ps1_powerline
{
  local retcode=$1
  function code
  {
    echo -en "\[\033[${1}m\]"
  }
  function codefront
  {
    echo -en "\[\033[3${1}m\]"
  }
  function codeback
  {
    echo -en "\[\033[4${1}m\]"
  }
  function sep
  {
    echo -en " $1${2}"
  }
  local prevback=''
  function segment
  {
    local front=$(codefront $1)
    local back=$(codeback $2)
    local frontsep=$(codefront $prevback)
    local data=$3
    if [ -z $4 ]; then
      echo -en "$(sep $back $frontsep)"
    fi
    prevback="$2"
    echo -en "$front$back $data"
  }
  # user segment
  segment '8;5;250' '8;5;240' '\u' 'nosep'
  # hostname segment
  segment '8;5;220' '5;5;230' '\h'

  # potential SSH segment
  function is_ssh
  {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
      return 0
    else
      case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) return 0;;
      esac
    fi
    return 1
  }
  if is_ssh; then
    segment '8;5;254' '8;5;166' 'SSH'
  fi
  if [ "$(pwd)" = "$HOME" ]; then
    segment '8;5;15' '8;5;31' '\W'
  else
    segment '8;5;254' '8;5;237' '\W'
  fi

  # potential $? segment & $ segment
  if [ $retcode -ne 0 ]; then
    segment '8;5;15' '8;5;161' "$retcode"
    segment '8;5;15' '8;5;161' '$'
  else
    segment '8;5;15' '8;5;236' '$'
  fi

  # reset segment
  echo -en "$(sep $(codefront $prevback) $(codeback '9'))$(code 0) "
}
