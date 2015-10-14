*Modular collection of scripts and snippets for my system's configuration*

# What's included

### Bash aliases

#### Gradle wrapper
- **gw:** ./gradlew
- **gbuild:** ./gradlew build
- **gclean:** ./gradlew clean
- **gcleanbuild:** ./gradlew clean build
- **gtest:** ./gradlew test

#### OS X:
- **showFiles:** Show hidden files in Finder
- **hideFiles:** Hide hidden files in Finder again
- **meh:** `¯\_(シ)_/¯`

### Git aliases
- **git fire**: [reset hard and remove untracked files](http://gifs.gifbin.com/25yuswsw28295.gif)
- **git bclean**: delete merged branches except for *"develop"*, *"master"* and *"sonar"* (a special one of mine)
- **git ci**: commit
- **git co**: checkout
- **git br**: branch
- **git amend**: commit --amend --no-edit
- **git cleanup**: git fetch --prune and then bclean
- **git nuke branch_name**: remove branch from local and remote

# Installation

### Bash configuration
Execute the following command to clone the repo and copy the default .bash_profile to your home directory:
```
$ git clone https://github.com/Sloy/scripts.git ~/scripts/ && \
cat ~/scripts/bash/.bash_profile >> ~/.bash_profile
```

Or do it however you prefer.

### To be continued...
