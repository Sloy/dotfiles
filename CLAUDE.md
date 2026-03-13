# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS (zsh). It symlinks configuration files into `$HOME` and includes shell aliases/functions, git config, Homebrew packages, and macOS defaults.

## Installation

```bash
./install.sh          # symlinks dotfiles into $HOME
./homebrew/install.sh # installs Homebrew + Brewfile packages
./macos/set-defaults.sh # applies macOS system defaults
```

## Structure

- `zsh/.zshrc` — entry point; sources `config.zsh`, `paths.zsh`, `aliases.zsh`
- `zsh/.zsh/aliases.zsh` — all shell aliases and functions (Android, Gradle, ffmpeg, etc.)
- `zsh/.zsh/config.zsh` — shell environment: editor, fzf, nvm, Homebrew, sdkman, proxy
- `zsh/.zsh/paths.zsh` — `$PATH` and `$ANDROID_HOME` / `$GRADLE_USER_HOME`
- `proxy/prox.sh` — `prox` function for toggling HTTP proxy on Android emulators via adb
- `git/.gitconfig` — git aliases, diff-so-fancy pager, credential helper
- `homebrew/Brewfile` — managed packages (bat, fzf, diff-so-fancy, jq, etc.)

## Machine-specific config

Add machine-specific overrides to `~/.localrc` — it is sourced automatically if it exists.

## Key git aliases (from `.gitconfig`)

| Alias | Description |
|---|---|
| `g sw` | `git switch` |
| `g wip` / `g unwip` | quick WIP commit / soft reset |
| `g pushr` | push current branch to origin and track |
| `g roomba` | delete local branches whose remote is gone |
| `g rebmaster` | pull master and rebase current branch on top |
| `g fixup <ref>` | amend an older commit interactively |
| `g pr` | push branch and open a GitHub PR |
| `g brf` | fuzzy-find local branches with fzf |

## Key shell functions (from `aliases.zsh`)

- `androidAnimations{On,Off,Fast,Slow}` — toggle Android emulator animation scales via adb
- `androidScreenshot` — capture screenshot from all connected devices to `~/Downloads`
- `androidTalkBackToggle` — toggle TalkBack accessibility service
- `ffcompress <file>` — compress video with ffmpeg (libx264, crf 28, strips audio)
- `prox <config> [-i]` / `prox none` — enable/disable Charles proxy on Android emulator; `-i` installs SSL cert
- `taskTree <task>` — display Gradle task dependency tree
