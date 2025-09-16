# Defaults
export SHELL=/bin/zsh
export EDITOR=vim

# Skips the default user name from the prompt
DEFAULT_USER=$(whoami)

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
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Homebrew
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

# My custom Charles Proxy helper
source $HOME/dotfiles/proxy/prox.sh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
