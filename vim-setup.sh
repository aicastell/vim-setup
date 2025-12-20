#!/usr/bin/env bash

set -euo pipefail

# ============================================================================
# Vim setup installer
# Installs .vimrc and pathogen bundles in a clean, reproducible way
# ============================================================================

VIMRC_TARGET="$HOME/.vimrc"
VIMDIR_TARGET="$HOME/.vim"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ----------------------------------------------------------------------------
# Backup existing configuration
# ----------------------------------------------------------------------------

if [ -f "$VIMRC_TARGET" ]; then
    echo "[INFO] Existing .vimrc found → backing up to .vimrc.old"
    mv "$VIMRC_TARGET" "$HOME/.vimrc.old"
fi

if [ -d "$VIMDIR_TARGET" ]; then
    echo "[INFO] Existing .vim directory found → backing up to .vim.old"
    mv "$VIMDIR_TARGET" "$HOME/.vim.old"
fi

# ----------------------------------------------------------------------------
# Install .vimrc
# ----------------------------------------------------------------------------

echo "[INFO] Installing .vimrc"
ln -s "$SCRIPT_DIR/vimrc" "$VIMRC_TARGET"

# ----------------------------------------------------------------------------
# Create .vim directory structure
# ----------------------------------------------------------------------------

echo "[INFO] Creating .vim directory structure"
mkdir -p "$VIMDIR_TARGET/autoload"
mkdir -p "$VIMDIR_TARGET/bundle"

# ----------------------------------------------------------------------------
# Install pathogen
# ----------------------------------------------------------------------------

echo "[INFO] Installing pathogen"
curl -LSso "$VIMDIR_TARGET/autoload/pathogen.vim" \
    https://tpo.pe/pathogen.vim

# ----------------------------------------------------------------------------
# Install bundles
# ----------------------------------------------------------------------------

declare -A PLUGINS=(
    [codedark]="https://github.com/tomasiser/vim-code-dark.git"
    [emmet-vim]="https://github.com/mattn/emmet-vim.git"
    [indentLine]="https://github.com/Yggdroot/indentLine.git"
    [nerdtree]="https://github.com/preservim/nerdtree.git"
    [vim-airline]="https://github.com/vim-airline/vim-airline.git"
    [vim-code-monokai]="https://github.com/tomasr/molokai.git"
    [vim-gitgutter]="https://github.com/airblade/vim-gitgutter.git"
)

for plugin in "${!PLUGINS[@]}"; do
    echo "[INFO] Installing $plugin"
    git clone --depth=1 "${PLUGINS[$plugin]}" "$VIMDIR_TARGET/bundle/$plugin"
done

# ----------------------------------------------------------------------------
# Post-install message
# ----------------------------------------------------------------------------

echo ""
echo "[SUCCESS] Vim setup installed successfully."
echo "Restart Vim to apply changes."

