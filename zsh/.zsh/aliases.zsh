#Git
alias g="git"

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
alias gwdependencies='./gradlew :app:dependencies --configuration debugCompileClasspath -q | st'
alias gradleconfig="open ~/.gradle/gradle.properties"
function taskTree() {
  # https://github.com/dorongold/gradle-task-tree
  if [ "$1" != "" ]
  then
    echo "Generating tree for task: $1"
    gw "$1" taskTree --no-repeat -q | st
    echo "Done!"
  else
    echo "You must provide a task as argument"
  fi
}

# npm
alias npmr='npm run'

## Application shortcuts
alias stree='git rev-parse --show-toplevel | xargs open -a SourceTree' # Prefer installing the command tools instead
alias androidstudio="open -a /Applications/Android\ Studio.app"

## My most used command
alias meh='echo "¯\_(シ)_/¯" | pbcopy && echo "¯\_(シ)_/¯ copied"'
#linux: alias meh='echo "¯\_(シ)_/¯" | xclip -selection c && echo "¯\_(シ)_/¯ copied"'

## Dotfiles self-awareness (aka skynet)
alias dotfiles='code ~/dotfiles && cd ~/dotfiles'

# Fzf + bat https://remysharp.com/2018/08/23/cli-improved
alias preview="fzf --preview 'bat --color \"always\" {}'"

function androidAnimationsOn() {
  adb shell settings put global window_animation_scale 1.0
  adb shell settings put global transition_animation_scale 1.0
  adb shell settings put global animator_duration_scale 1.0
  echo "Done!"
}

function androidAnimationsOff() {
  adb shell settings put global window_animation_scale 0.0
  adb shell settings put global transition_animation_scale 0.0
  adb shell settings put global animator_duration_scale 0.0
  echo "Done!"
}

function androidAnimationsSlow() {
  adb shell settings put global window_animation_scale 5.0
  adb shell settings put global transition_animation_scale 5.0
  adb shell settings put global animator_duration_scale 5.0
  echo "Done!"
}

alias androidTouchPointerShow="adb shell content insert --uri content://settings/system --bind name:s:show_touches --bind value:i:1"
alias androidTouchPointerHide="adb shell content insert --uri content://settings/system --bind name:s:show_touches --bind value:i:0"
alias androidPaste="adb shell input text $(pbpaste)"
alias androidFontSize1="adb shell settings put system font_scale 1.0"
alias androidFontSize085="adb shell settings put system font_scale 0.85"
alias androidFontSize115="adb shell settings put system font_scale 1.15"
alias androidFontSize130="adb shell settings put system font_scale 1.30"
alias androidFixEmulatorDate="adb shell su root date $(date +%m%d%H%M%Y.%S)"

alias deleteEmptyDirectories="find . -type d -empty -delete"
