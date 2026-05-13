#!/bin/bash
# install.sh — 将 trae/ 配置文件链接到 macOS/Linux 上的 TRAE 配置目录

set -e

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SRC_KEYBINDINGS="$DOTFILES_DIR/trae/keybindings.json"
SRC_SETTINGS="$DOTFILES_DIR/trae/settings.json"

if [[ "$(uname)" == "Darwin" ]]; then
    TARGET_DIR="$HOME/Library/Application Support/Trae CN/User"
elif [[ "$(uname)" == "Linux" ]]; then
    TARGET_DIR="$HOME/.config/Trae CN/User"
else
    echo "Unsupported OS"
    exit 1
fi

TARGET_KEYBINDINGS="$TARGET_DIR/keybindings.json"
TARGET_SETTINGS="$TARGET_DIR/settings.json"

link_file() {
    local name="$1"
    local src="$2"
    local dst="$3"

    if [[ ! -d "$(dirname "$dst")" ]]; then
        echo "  [skip] directory not found: $(dirname "$dst")"
        return
    fi

    if [[ -f "$dst" && ! -L "$dst" ]]; then
        echo "  [backup] $dst -> $dst.bak"
        mv "$dst" "$dst.bak"
    fi

    ln -sf "$src" "$dst"
    echo "  [linked] $dst"
}

echo "==> Linking TRAE config files ..."
link_file "Keybindings" "$SRC_KEYBINDINGS" "$TARGET_KEYBINDINGS"
link_file "Settings" "$SRC_SETTINGS" "$TARGET_SETTINGS"

echo ""
echo "Done! Restart TRAE if it is already open."