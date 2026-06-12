#!/usr/bin/env bash

# Installs oh-my-zsh + powerlevel10k + plugins + Nerd Font.
# Only needed on machines where you use iTerm2 (see zsh/.zsh/config.zsh).
# Idempotent: re-running skips anything already installed.

set -euo pipefail

ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH_DIR/custom}"

# oh-my-zsh
if [ ! -d "$ZSH_DIR" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh already installed, skipping."
fi

# powerlevel10k theme
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  echo "Cloning powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  echo "powerlevel10k already cloned, skipping."
fi

# zsh-autosuggestions
AUTOSUGG_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
if [ ! -d "$AUTOSUGG_DIR" ]; then
  echo "Cloning zsh-autosuggestions..."
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGG_DIR"
else
  echo "zsh-autosuggestions already cloned, skipping."
fi

# zsh-syntax-highlighting
SYNTAX_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
if [ ! -d "$SYNTAX_DIR" ]; then
  echo "Cloning zsh-syntax-highlighting..."
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_DIR"
else
  echo "zsh-syntax-highlighting already cloned, skipping."
fi

# JetBrains Mono Nerd Font (provides glyphs powerlevel10k uses)
if command -v brew >/dev/null 2>&1; then
  if ! brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1; then
    echo "Installing JetBrains Mono Nerd Font..."
    brew install --cask font-jetbrains-mono-nerd-font
  else
    echo "JetBrains Mono Nerd Font already installed, skipping."
  fi
else
  echo "Homebrew not found — install it first, then re-run this script."
  exit 1
fi

cat <<'EOF'

Done. Next steps:
  1. In iTerm2 → Profiles → Text → Font, select "JetBrainsMono Nerd Font".
  2. Open a new iTerm2 tab/window (or run `exec zsh`) so the shell picks up
     oh-my-zsh — the `p10k` command is only available after that.
  3. Run `p10k configure` to generate ~/.p10k.zsh with your preferred prompt style.
EOF
