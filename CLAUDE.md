# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS (zsh). It symlinks configuration files into `$HOME` and includes shell aliases/functions, git config, Homebrew packages, and macOS defaults.

## Installation

```bash
./install.sh           # symlinks dotfiles into $HOME and installs `a` into ~/.a
./homebrew/install.sh  # installs Homebrew + Brewfile packages
./macos/set-defaults.sh # applies macOS system defaults
./zsh/install-omz.sh   # (optional) oh-my-zsh + powerlevel10k + plugins + Nerd Font (only run on machines where you use iTerm2)
```

## Structure

- `zsh/.zshrc` — entry point; sources `config.zsh`, `paths.zsh`, `aliases.zsh`; loads [worktrunk](https://worktrunk.dev) (`wt`) shell integration if installed
- `zsh/.zsh/aliases.zsh` — all shell aliases and functions (Gradle, ffmpeg, git worktrees, etc.)
- `zsh/.zsh/config.zsh` — shell environment: editor, fzf, nvm, Homebrew, sdkman, proxy
- `zsh/.zsh/paths.zsh` — `$PATH` (including `~/.local/bin` for the `android` CLI) and `$ANDROID_HOME` / `$GRADLE_USER_HOME`
- `proxy/prox.sh` — `prox` function for toggling HTTP proxy on Android emulators via adb
- `git/.gitconfig` — git aliases, diff-so-fancy pager, credential helper
- `homebrew/Brewfile` — managed packages (bat, fzf, diff-so-fancy, jq, etc.)
- `paparazzi/papa.sh` — `papa` CLI: fzf-driven record/verify for Paparazzi screenshot tests. Runs `:kspDebugKotlin --rerun-tasks` first as a workaround: the current Gradle setup doesn't detect changed code and skips the task otherwise
- `raycast/` — Raycast script commands; point Raycast to `~/dotfiles/raycast` in Settings → Extensions → Script Commands

## Machine-specific config

Add machine-specific overrides to `~/.localrc` — it is sourced automatically if it exists.

## Oh-my-zsh (iTerm2 only)

`config.zsh` loads oh-my-zsh + powerlevel10k only when `$TERM_PROGRAM == iTerm.app` and `~/.oh-my-zsh` exists. Warp ships its own prompt so OMZ stays out of its way. To enable on a new machine, run `./zsh/install-omz.sh` (installs OMZ, p10k, `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `font-jetbrains-mono-nerd-font`), then run `p10k configure`.

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

- `ffcompress <file>` — compress video with ffmpeg (libx264, crf 28, strips audio); `ffcompress last` uses the newest file in `~/Downloads`
- `prox <config> [-i]` / `prox none` — enable/disable Charles proxy on Android emulator; `-i` installs SSL cert
- `taskTree <task>` — display Gradle task dependency tree

## `a` — Android CLI

The adb helpers (formerly `and/`) live in their own repo, [Sloy/a](https://github.com/Sloy/a), checked out at `~/.a`. `install.sh` runs its installer with `A_NO_MODIFY_RC=1`, and `aliases.zsh` sources `~/.a/init.sh` instead of editing `~/.zshrc`. Work on it in `~/ShadowMosses/a`, not here.

## Raycast scripts (`raycast/`)

Script commands symlinked to `~/.raycast-scripts`. Add that path in Raycast → Settings → Extensions → Script Commands.

| Script | Description |
|---|---|
| `talkback-toggle.sh` | Toggle TalkBack accessibility service on connected Android device |
| `qa-password.sh` | Paste QA test password on connected Android device via adb |

Scripts use a hardcoded `adb` path (`~/Library/Android/sdk/platform-tools/adb`). `qa-password.sh` reads `$QA_PASSWORD` from `~/.localrc` — set it there before use. No symlink needed; point Raycast directly at `~/dotfiles/raycast`.
