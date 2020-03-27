#!/usr/bin/env bash

# =====================================
# Initializes a fresh home dir with
# personal configuration files.
# =====================================

set -o errexit

# =====================================
# Define constants
# =====================================
readonly CONF_DIR="${HOME}/conf"
readonly DEV_DIR="${HOME}/dev"
readonly DL_DIR="${HOME}/dl"
readonly DOX_DIR="${HOME}/dox"
readonly PIX_DIR="${HOME}/pix"
readonly TOOLS_DIR="${HOME}/tools"

readonly VIM_CFG_DIR="${CONF_DIR}/vimcfg"
readonly FIREFOX_CFG_DIR="${CONF_DIR}/firefoxcfg"
readonly DOTFILES_CFG_DIR="${CONF_DIR}/dotfiles"

readonly GITHUB_REPOS_URL="https://github.com/cmoron/"

CURRENT_PATH="$PWD"

[[ -z "$XDG_CONFIG_HOME" ]] && CONFIG_HOME="${HOME}/.config" || CONFIG_HOME="$XDG_CONFIG_HOME"
LOCAL_HOME="${HOME}/.local"

# =====================================
# Initialize home dir
# =====================================
[[ ! -e "$CONF_DIR" ]] && mkdir "$CONF_DIR"
[[ ! -e "$CONF_DIR" ]] && mkdir "$CONF_DIR"
[[ ! -e "$DEV_DIR" ]] && mkdir "$DEV_DIR"
[[ ! -e "$DL_DIR" ]] && mkdir "$DL_DIR"
[[ ! -e "$DOX_DIR" ]] && mkdir "$DOX_DIR"
[[ ! -e "$PIX_DIR" ]] && mkdir "$PIX_DIR"
[[ ! -e "$TOOLS_DIR" ]] && mkdir "$TOOLS_DIR"
[[ ! -e "$CONFIG_HOME" ]] && mkdir "$CONFIG_HOME"

# =====================================
# Git clone tools conf from github
# =====================================
echo "Getting dotfiles."
if [[ -e "$DOTFILES_CFG_DIR" ]]; then
    cd "$DOTFILES_CFG_DIR"
    git pull
    cd "$CURRENT_PATH"
else
    git clone "${GITHUB_REPOS_URL}dotfiles.git" "$DOTFILES_CFG_DIR"
fi

echo "Getting vim configuration files."
if [[ -e "$VIM_CFG_DIR" ]]; then
    cd "$VIM_CFG_DIR"
    git pull
    git submodule update
    cd "$CURRENT_PATH"
else
    git clone "${GITHUB_REPOS_URL}vimcfg.git" "$VIM_CFG_DIR"
    cd "$VIM_CFG_DIR"
    git submodule init
    git submodule update
    cd "$CURRENT_PATH"
fi

echo "Getting firefox configuration files."
if [[ -e "$FIREFOX_CFG_DIR" ]]; then
    cd "$FIREFOX_CFG_DIR"
    git pull
    cd "$CURRENT_PATH"
else
    git clone "${GITHUB_REPOS_URL}firefoxcfg.git" "$FIREFOX_CFG_DIR"
fi


echo "Creating configuration files."

ln -sf "${DOTFILES_CFG_DIR}/.profile" "${HOME}/.profile"
ln -sf "${DOTFILES_CFG_DIR}/.xprofile" "${HOME}/.xprofile"
ln -sf "${DOTFILES_CFG_DIR}/.xinitrc" "${HOME}/.xinitrc"
ln -sf "${HOME}/.profile" "${HOME}/.bash_profile"
ln -sf "${DOTFILES_CFG_DIR}/.bashrc" "${HOME}/.bashrc"
ln -sf "${VIM_CFG_DIR}/.vim" "${HOME}/.vim"

ln -sf "${DOTFILES_CFG_DIR}/.config/git" "${CONFIG_HOME}/git"
ln -sf "${DOTFILES_CFG_DIR}/.config/i3" "${CONFIG_HOME}/i3"
ln -sf "${DOTFILES_CFG_DIR}/.config/i3status" "${CONFIG_HOME}/i3status"
ln -sf "${DOTFILES_CFG_DIR}/.config/kitty" "${CONFIG_HOME}/kitty"
ln -sf "${DOTFILES_CFG_DIR}/.config/wall.jpg" "${CONFIG_HOME}/wall.jpg"

ln -sf "${DOTFILES_CFG_DIR}/.local/bin" "${LOCAL_HOME}/bin"
ln -sf "${DOTFILES_CFG_DIR}/.local/share/fonts" "${LOCAL_HOME}/share/fonts"

cd "$CURRENT_PATH"
