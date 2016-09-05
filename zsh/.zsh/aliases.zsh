# Directory Info
alias ll="ls -lFh"
alias la="ls -lAFh"  # List all files (inlcuding hidden)
alias lh="ls -ld .*" # List hidden files only
alias lr="ls -tRFh"  # List recursively

# zsh
alias zshconfig="st ~/.zsh"
alias localrc="if [[ -a ~/.localrc ]]; then ${EDITOR} ~/.localrc; fi"
alias ohmyzsh="st ~/.oh-my-zsh"
alias reload!='. ~/.zshrc'

alias cls='clear'
alias j="jump"

## Hidden files in Finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

## Gradle
alias gw='./gradlew'
alias gbuild='./gradlew build'
alias gtest='./gradlew test'
alias gclean='./gradlew clean'
alias gcleanbuild='./gradlew clean build'
alias gradleconfig="open ~/.gradle/gradle.properties"

## My most used command
alias meh='echo "¯\_(シ)_/¯" | pbcopy && echo "¯\_(シ)_/¯ copied"'
#linux: alias meh='echo "¯\_(シ)_/¯" | xclip -selection c && echo "¯\_(シ)_/¯ copied"'
