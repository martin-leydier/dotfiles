if [ -z $(type -t __ps1_powerline_code) ]; then
  function __ps1_powerline_code
  {
    echo -en "\[\033[${1}m\]"
  }
  function __ps1_powerline_codefront
  {
    echo -en "\[\033[38;5;${1}m\]"
  }
  function __ps1_powerline_codeback
  {
    echo -en "\[\033[48;5;${1}m\]"
  }
  function __ps1_powerline_sep
  {
    echo -en " $1${2}"
  }
  function __ps1_powerline_sgement
  {
    local front=$(__ps1_powerline_codefront $1)
    local back=$(__ps1_powerline_codeback $2)
    local frontsep=$(__ps1_powerline_codefront $prevback)
    local data=$3
    if [ -z $4 ]; then
      echo -en "$(__ps1_powerline_sep $back $frontsep)"
    fi
    prevback="$2"
    echo -en "$front$back $data"
  }
  __ps1_powerline_hostfront=$( echo $(($(hostname | sum | cut -d ' ' -f 1) % 64 + 1)) | tr -d -)
  __ps1_powerline_hostback=$( echo $(((16#$(hostname | md5sum | cut -d ' ' -f 1) + 64) % 256 + 1)) | tr -d -)
fi

function __ps1_powerline
{
  local retcode=$1

  # user segment
  __ps1_powerline_sgement '250' '240' '\u' 'nosep'
  # hostname segment
  __ps1_powerline_sgement "$__ps1_powerline_hostfront" "$__ps1_powerline_hostback" '\h'

  # potential SSH segment
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    __ps1_powerline_sgement '254' '166' 'SSH'
  fi
  if [ "$PWD" = "$HOME" ]; then
    __ps1_powerline_sgement '15' '31' '\W'
  else
    __ps1_powerline_sgement '254' '237' '\W'
  fi

  # potential $? segment & $ segment
  if [ "$retcode" != '0' ]; then
    __ps1_powerline_sgement '15' '161' "$retcode"
    __ps1_powerline_sgement '15' '161' '$'
  else
    __ps1_powerline_sgement '15' '236' '$'
  fi

  # reset segment
  echo -en "$(__ps1_powerline_sep $(__ps1_powerline_codefront $prevback) $(__ps1_powerline_code '49'))$(__ps1_powerline_code 0) "
}
