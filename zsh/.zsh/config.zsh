# Defaults
export SHELL=/bin/zsh
export EDITOR=vim

#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(git adb colored-man-pages jump zsh-syntax-highlighting sublime)

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

# Git in English, please
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Nvm
if [[ -a ~/.nvm ]]
then
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
