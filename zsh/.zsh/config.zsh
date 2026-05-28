# Defaults
export SHELL=/bin/zsh
export EDITOR=vim

# Skips the default user name from the prompt
DEFAULT_USER=$(whoami)

# Fzf https://github.com/junegunn/fzf#using-homebrew-or-linuxbrew
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
## add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# Git in English, please
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Nvm — lazy-loaded. nvm.sh costs ~1s to source, so we defer it until nvm/node/npm/npx is actually invoked.
if [[ -s /opt/homebrew/opt/nvm/nvm.sh ]]; then
  export NVM_DIR="$HOME/.nvm"
  _nvm_load() {
    unset -f nvm node npm npx
    source /opt/homebrew/opt/nvm/nvm.sh
    [[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ]] && source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm
  }
  nvm()  { _nvm_load; nvm  "$@" }
  node() { _nvm_load; node "$@" }
  npm()  { _nvm_load; npm  "$@" }
  npx()  { _nvm_load; npx  "$@" }
fi

# Homebrew on MacOS ARM (inlined `brew shellenv` to avoid forking /opt/homebrew/bin/brew on every shell start)
if [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
fi

# My custom Charles Proxy helper
source $HOME/dotfiles/proxy/prox.sh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Disable maestro.dev AI ads
export MAESTRO_CLI_ANALYSIS_NOTIFICATION_DISABLED=true