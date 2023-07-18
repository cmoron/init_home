#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Define PATHS
readonly CONF_DIR="${HOME}/conf"
readonly DOTFILES_CFG_DIR="$CONF_DIR/dotfiles"
readonly VIM_CFG_DIR="$CONF_DIR/vimcfg"
readonly LOCAL_HOME="${HOME}/.local"
[[ -z "$XDG_CONFIG_HOME" ]] && CONFIG_HOME="${HOME}/.config" || CONFIG_HOME="$XDG_CONFIG_HOME"

# Function to test a symlink
function test_symlink {
    if [[ -L "$1" && "$(readlink "$1")" == "$2" ]]; then
        echo -e "${GREEN}$1 is correctly linked to $2${NC}"
    else
        echo -e "${RED}Problem with $1, expected link to $2${NC}"
    fi
}

# Test each symlink
test_symlink "${HOME}/.profile" "${DOTFILES_CFG_DIR}/.profile"
test_symlink "${HOME}/.xprofile" "${DOTFILES_CFG_DIR}/.xprofile"
test_symlink "${HOME}/.xinitrc" "${DOTFILES_CFG_DIR}/.xinitrc"
test_symlink "${HOME}/.bash_profile" "${HOME}/.profile"
test_symlink "${HOME}/.bashrc" "${DOTFILES_CFG_DIR}/.bashrc"
test_symlink "${HOME}/.vim" "${VIM_CFG_DIR}/.vim"

test_symlink "${CONFIG_HOME}/git" "${DOTFILES_CFG_DIR}/.config/git"
test_symlink "${CONFIG_HOME}/i3" "${DOTFILES_CFG_DIR}/.config/i3"
test_symlink "${CONFIG_HOME}/i3status" "${DOTFILES_CFG_DIR}/.config/i3status"
test_symlink "${CONFIG_HOME}/kitty" "${DOTFILES_CFG_DIR}/.config/kitty"
test_symlink "${CONFIG_HOME}/wall.jpg" "${DOTFILES_CFG_DIR}/.config/wall.jpg"

test_symlink "${LOCAL_HOME}/bin" "${DOTFILES_CFG_DIR}/.local/bin"
test_symlink "${LOCAL_HOME}/share/fonts" "${DOTFILES_CFG_DIR}/.local/share/fonts"
test_symlink "${LOCAL_HOME}/shell" "${DOTFILES_CFG_DIR}/.local/shell"
