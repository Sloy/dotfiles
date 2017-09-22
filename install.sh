#!/usr/bin/env bash

# https://github.com/kaicataldo/dotfiles/blob/master/bin/install.sh
# https://github.com/nicksp/dotfiles/blob/master/setup.sh

# Warn user this script will overwrite current dotfiles
while true; do
  read -p "Warning: this will overwrite your current dotfiles. Continue? [y/n] " yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Get the dotfiles directory's absolute path
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
DOTFILES_DIR=$SCRIPT_DIR

# Create dotfiles_old in homedir
mkdir -p ~/dotfiles_old

# Symlink and report creation of link
createSymlink() {
  mv -n $2 ~/dotfiles_old/ &> /dev/null
  ln -sfn $1 $2
  echo "Symlinked ${1} -> ${2}"
}

# Git
createSymlink $DOTFILES_DIR/git/.gitconfig ~/.gitconfig
createSymlink $DOTFILES_DIR/git/.gitignore_global ~/.gitignore_global

# zsh
createSymlink $DOTFILES_DIR/zsh/.zshrc ~/.zshrc
createSymlink $DOTFILES_DIR/zsh/.zsh ~/.zsh

# brew
./homebrew/install.sh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh gradle completion
git clone git://github.com/eriwen/gradle-completion ~/.zsh/gradle-completion

# Download powerlevel9k oh-my-zsh theme if not exists, update otherwise
[ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ] && \
  # exists
  git -C ~/.oh-my-zsh/custom/themes/powerlevel9k pull || \
  # doesn't exist
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Powerline fonts
# clone
git clone https://github.com/powerline/fonts.git
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

# Terminal theme
open ./terminal/Chalk.terminal

# iTerm2 (thanks http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
