# dotfiles

## Installation

### 1. Dotfiles & shell environment

Symlinks config files and sets up the zsh environment.

```sh
./install.sh
```

### 2. Homebrew & apps

Installs Homebrew and all packages/casks defined in the Brewfile.

```sh
./homebrew/install.sh
```

### 3. macOS defaults

Walks through macOS system settings interactively, asking for confirmation on each one.

```sh
./macos/set-defaults.sh
```

### 4. Java (via sdkman)

Installs sdkman (if not present) and Java.

```sh
./java/install.sh
```
