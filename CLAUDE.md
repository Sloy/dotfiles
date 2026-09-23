# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS (zsh). It symlinks configuration files into `$HOME` and includes shell aliases/functions, git config, Homebrew packages, and macOS defaults.

## Installation

```bash
./install.sh           # symlinks dotfiles into $HOME
./homebrew/install.sh  # installs Homebrew + Brewfile packages
./macos/set-defaults.sh # applies macOS system defaults
./zsh/install-omz.sh   # (optional) oh-my-zsh + powerlevel10k + plugins + Nerd Font (only run on machines where you use iTerm2)
```

## Structure

- `zsh/.zshrc` — entry point; sources `config.zsh`, `paths.zsh`, `aliases.zsh`
- `zsh/.zsh/aliases.zsh` — all shell aliases and functions (Gradle, ffmpeg, git worktrees, etc.)
- `zsh/.zsh/config.zsh` — shell environment: editor, fzf, nvm, Homebrew, sdkman, proxy
- `zsh/.zsh/paths.zsh` — `$PATH` and `$ANDROID_HOME` / `$GRADLE_USER_HOME`
- `proxy/prox.sh` — `prox` function for toggling HTTP proxy on Android emulators via adb
- `git/.gitconfig` — git aliases, diff-so-fancy pager, credential helper
- `homebrew/Brewfile` — managed packages (bat, fzf, diff-so-fancy, jq, etc.)
- `and/` — `and` CLI: fzf-driven front end for the adb chores (see below)
- `paparazzi/papa.sh` — `papa` CLI: fzf-driven record/verify for Paparazzi screenshot tests
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

- `ffcompress <file>` — compress video with ffmpeg (libx264, crf 28, strips audio)
- `prox <config> [-i]` / `prox none` — enable/disable Charles proxy on Android emulator; `-i` installs SSL cert
- `taskTree <task>` — display Gradle task dependency tree

## `and` — Android CLI (`and/`)

`alias and="$HOME/dotfiles/and/and.sh"`. Replaces the old `androidXxx` aliases. Run `and` bare for an fzf menu of commands, then a second fzf prompt for that command's argument; every run prints a banner with the equivalent one-liner so the prompt can be skipped next time.

| Command | Arguments |
|---|---|
| `and animations` | `off` (0.0) · `fast` (0.5) · `on` (1.0) · `slow` (5.0) · any raw scale |
| `and screenshot` | `now` · `<seconds>` to count down first |
| `and touch-pointer` | `on` · `off` |
| `and font-size` | `0.85` · `1` · `1.15` · `1.30` · any raw scale |
| `and talkback` | `toggle` · `on` · `off` |
| `and navigation` | `gestures` · `buttons` |
| `and paste` | — (types the macOS clipboard into the focused field) |
| `and fix-date` | — (needs a rootable image; fails on Play Store AVDs) |

Layout:

- `and/and.sh` — dispatcher: fzf menu when bare, otherwise maps the subcommand name (loose spellings like `fontSize`, `nav`, `tb` included) to `commands/<name>.sh` and `exec`s it
- `and/lib/common.sh` — colours, `FZF_STYLE`, `pick`, `banner`, `die`; sets `$AND_ROOT`/`$AND_LIB`/`$AND_COMMANDS`
- `and/lib/device.sh` — `resolve_device` sets `"${ADB[@]}"` to an adb call pinned to one device: 0 devices errors, 1 is used silently, 2+ get an fzf picker
- `and/commands/*.sh` — one file per subcommand, each runnable standalone

To add a command: drop a script in `commands/`, add it to `COMMANDS` and `canonical()` in `and.sh`. Commands that act on a single device call `resolve_device`; `screenshot` deliberately skips it and loops over every device instead.

`pick` and `resolve_device` must be called directly, never inside `$(...)` — `die` and the fzf prompt both need the caller's shell and tty.

## Raycast scripts (`raycast/`)

Script commands symlinked to `~/.raycast-scripts`. Add that path in Raycast → Settings → Extensions → Script Commands.

| Script | Description |
|---|---|
| `talkback-toggle.sh` | Toggle TalkBack accessibility service on connected Android device |
| `qa-password.sh` | Paste QA test password on connected Android device via adb |

Scripts use a hardcoded `adb` path (`~/Library/Android/sdk/platform-tools/adb`). `qa-password.sh` reads `$QA_PASSWORD` from `~/.localrc` — set it there before use. No symlink needed; point Raycast directly at `~/dotfiles/raycast`.
