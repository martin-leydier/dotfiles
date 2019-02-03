#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
install() {
  files="bashrc Xresources vimrc powerline-bash.sh gitconfig"
  for i in $files; do
    if [ -f "$HOME/.$i" ]; then
      echo "backing up exising .$i"
      mv "$HOME/.$i" "$DIR/$i.bak"
    fi
    echo "linking $i"
    ln -s "$DIR/$i" "$HOME/.$i"
  done

  if [ "$(fc-list | grep Powerline | wc -l)" -gt 0 ]; then
    echo "Fonts already installed, skipping"
  else
    echo "Font Setup"
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf ./fonts
    echo "Font done"
  fi

  echo "Fzf Setup"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  echo "Fzf Setup done"

  echo "Bat Setup"
  wget https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb
  sudo dpkg -i bat_0.9.0_amd64.deb
  rm bat_0.9.0_amd64.deb
  mkdir -p "$(bat cache --config-dir)/themes"
  cd "$(bat cache --config-dir)/themes"
  git clone https://github.com/Briles/gruvbox.git --depth=1
  bat cache --init
  cd -
  echo "Bat Setup done"

  echo "Vim Setup"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
  echo "Vim done"

}
install
echo "Install complete"
