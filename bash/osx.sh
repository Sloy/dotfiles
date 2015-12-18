# Paths
source ./paths/android_osx.sh

# Aliases for OSX terminal
source ./alias/osx.sh
source ./alias/gradle.sh
source ./alias/git.sh

# Terminal appearance
## http://osxdaily.com/2013/02/05/improve-terminal-appearance-mac-os-x/
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

# Bash (and git) completion
## Requieres brew install bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
