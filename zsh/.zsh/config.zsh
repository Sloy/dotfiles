# Defaults
export SHELL=/bin/zsh
export EDITOR=vim

#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(git adb colored-man-pages jump alias-tips zsh-syntax-highlighting sublime atom)

DEFAULT_USER=$(whoami)

source $ZSH/oh-my-zsh.sh

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)


# Gradle completion https://github.com/gradle/gradle-completion
fpath=($HOME/.zsh/gradle-completion $fpath)

# Fzf https://github.com/junegunn/fzf#using-homebrew-or-linuxbrew
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
## add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
