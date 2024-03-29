# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# zsh config location
export ZSH_CONFIG=$HOME/.zsh

# Custom functions path
fpath=($ZSH_CONFIG/functions $fpath)

# Source all zsh files
source $ZSH_CONFIG/config.zsh
source $ZSH_CONFIG/paths.zsh
source $ZSH_CONFIG/aliases.zsh

# Source local config file specific to machine if it exists
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# Fix for Android Emulator messing with bluetooth audio
export QEMU_AUDIO_DRV=none
