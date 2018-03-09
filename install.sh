#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
files="bashrc Xresources vimrc powerline-shell.json gitconfig"
for i in $files; do
  if [ -f "$HOME/.$i" ]; then
    echo "backing up exising .$i"
    mv "$HOME/.$i" "$DIR/$i.bak"
  fi
  echo "linking $i"
  ln -s "$DIR/$i" "$HOME/.$i"
done

echo "Font Setup"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf ./fonts

echo "Prompt Setup"
git clone https://github.com/b-ryan/powerline-shell --depth=1
cd powerline-shell
sudo python setup.py install
cd ..
sudo rm -rf ./powerline-shell

echo "Hstr Setup"
if command -v apt; then
  sudo apt -y install libncursesw5-dev
fi
git clone https://github.com/dvorka/hstr.git
cd hstr
cd ./dist && ./1-dist.sh && cd ..
./configure && make && sudo make install
cd ..
rm -rf ./hstr
hh --show-configuration > ~/.hhrc

echo "Vim Setup"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
echo "Install complete, remember to source ~/.bashrc"
