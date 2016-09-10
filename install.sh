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
  mv $2 ~/dotfiles_old/ &> /dev/null
  ln -sfn $1 $2
  echo "Symlinked ${1} -> ${2}"
}

# Git
createSymlink $DOTFILES_DIR/git/.gitconfig ~/.gitconfig
createSymlink $DOTFILES_DIR/git/.gitignore_global ~/.gitignore_global

# zsh
createSymlink $DOTFILES_DIR/zsh/.zshrc ~/.zshrc
createSymlink $DOTFILES_DIR/zsh/.zsh ~/.zsh
