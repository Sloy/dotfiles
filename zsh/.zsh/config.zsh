# Defaults
export SHELL=/bin/zsh
export EDITOR=vim

ZSH_THEME="agnoster"

plugins=(git gradle adb colored-man-pages jump alias-tips zsh-syntax-highlighting sublime atom)

DEFAULT_USER="rafa"

source $ZSH/oh-my-zsh.sh

RPROMPT='$(date +%T)'
