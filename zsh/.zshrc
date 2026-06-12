# Powerlevel10k instant prompt — only in iTerm2, matching the gate in config.zsh.
# Must stay near the top of ~/.zshrc; any initialization that may require console
# input (password prompts, [y/n] confirmations, etc.) must go above this block.
if [[ "$TERM_PROGRAM" == "iTerm.app" && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
