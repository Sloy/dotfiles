# Paths
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

# Aliases for OSX terminal
## Hidden files in finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias meh='echo "¯\_(シ)_/¯" | pbcopy && echo "¯\_(シ)_/¯ copied"'
#linux: alias meh='echo "¯\_(シ)_/¯" | xclip -selection c && echo "¯\_(シ)_/¯ copied"'

## Gradle wrapper
alias gw='./gradlew'
alias gbuild='./gradlew build'
alias gtest='./gradlew test'
alias gclean='./gradlew clean'
alias gcleanbuild='./gradlew clean build'

## Git
alias g='git'

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
