#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
install() {
  files="bashrc Xresources vimrc powerline-shell.json gitconfig"
  for i in $files; do
    if [ -f "$HOME/.$i" ]; then
      echo "backing up exising .$i" >&2
      mv "$HOME/.$i" "$DIR/$i.bak"
    fi
    echo "linking $i" >&2
    ln -s "$DIR/$i" "$HOME/.$i"
  done

  echo "Font Setup, this can take a long time" >&2
  git clone https://github.com/powerline/fonts.git --depth=1 2>&1
  cd fonts
  ./install.sh 2>&1
  cd ..
  rm -rf ./fonts
  echo "Font done" >&2

  echo "Prompt Setup" >&2
  git clone https://github.com/b-ryan/powerline-shell --depth=1 2>&1
  cd powerline-shell
  sudo python setup.py install 2>&1
  cd ..
  sudo rm -rf ./powerline-shell
  echo "Prompt done" >&2

  echo "Hstr Setup" >&2
  if command -v hstr; then
    echo "Hstr already exists, skipping..." >&2
  else
    if command -v apt; then
      sudo apt -y install libncursesw5-dev
    else
      echo "apt not found, could not try to install libncursesw5-dev"
    fi
    echo "Building from source, this can take a long time"
    git clone https://github.com/dvorka/hstr.git 2>&1
    cd hstr
    cd ./dist && ./1-dist.sh 2>&1 && cd ..
    ./configure 2>&1 && make 2>&1 && sudo make install 2>&1
    cd ..
    rm -rf ./hstr  2>&1
    hh --show-configuration > ~/.hhrc
  fi
  echo "Prompt done" >&2

  echo "Hstr Setup" >&2
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2>&1
  vim +PluginInstall +qall 2>&1 > /dev/null
  echo "Vim done" >&2

  echo "Git startup check setup" >&2
  echo -e "#!/bin/sh\ncd $DIR;./gitcheck.sh" > "$HOME/.updatecheck.sh"
  chmod +x "$HOME/.updatecheck.sh"
  echo "Git startup check done" >&2

  if command -v xrdb; then
    xrdb ~/.Xresources
  fi
}
install > "$DIR/install.log"
echo "Install complete, remember to source ~/.bashrc, log is in $DIR/install.log"
