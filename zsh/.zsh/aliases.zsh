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

# terminal tricks
alias cls='clear'
alias j="jump"
alias cpdir="cp -R"

## Hidden files in Finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

## Gradle
alias gw='./gradlew'
alias gwstop='./gradlew --stop'
alias gradleconfig="open ~/.gradle/gradle.properties"
function taskTree() {
  # https://github.com/dorongold/gradle-task-tree
  if [ "$1" != "" ]
  then
    echo "Generating tree for task: $1"
    gw "$1" taskTree --no-repeat -q > taskTree.txt && open taskTree.txt
    echo "Done!"
  else
    echo "You must provide a task as argument"
  fi
}

## Application shortcuts
alias stree='git rev-parse --show-toplevel | xargs open -a SourceTree' # Prefer installing the command tools instead
alias androidstudio="open -a /Applications/Android\ Studio.app"

## My most used command
alias meh='echo "¯\_(シ)_/¯" | pbcopy && echo "¯\_(シ)_/¯ copied"'
#linux: alias meh='echo "¯\_(シ)_/¯" | xclip -selection c && echo "¯\_(シ)_/¯ copied"'

## Dotfiles self-awareness (aka skynet)
alias dotfiles='atom ~/dotfiles && cd ~/dotfiles'
