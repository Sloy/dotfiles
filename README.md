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

### 5. Raycast scripts

Add `~/dotfiles/raycast` as a Script Commands directory in Raycast → Settings → Extensions → Script Commands.

Some scripts require secrets in `~/.localrc`:

```sh
export QA_PASSWORD="..."
```

## CLI helpers

Both are aliased by `install.sh` via `aliases.zsh` and need [fzf](https://github.com/junegunn/fzf).

- `and` — Android/adb helpers: animation scales, screenshots, font scale, touch pointer, TalkBack, nav bar, clipboard paste, emulator clock. Run bare to pick interactively, or go straight there: `and screenshot now`, `and font-size 1.15`, `and animations off`. `and --help` lists everything.
- `papa` — record or verify Paparazzi screenshot tests without typing the full Gradle module path.
