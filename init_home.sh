#!/usr/bin/env bash

# Initializes a fresh home dir with personal configuration files.

set -o errexit

# Define constants
readonly DIRS_TO_CREATE=(
    "${HOME}/conf"
    "${HOME}/src"
    "${HOME}/dl"
    "${HOME}/docs"
    "${HOME}/pics"
    "${HOME}/tools"
)

readonly CONF_REPOS=(
    "dotfiles"
    "vimcfg"
    "firefoxcfg"
)

readonly CONF_DIR="${HOME}/conf"
readonly DOTFILES_CFG_DIR="$CONF_DIR/dotfiles"
readonly VIM_CFG_DIR="$CONF_DIR/vimcfg"

readonly GITHUB_REPOS_URL="https://github.com/cmoron/"

[[ -z "$XDG_CONFIG_HOME" ]] && CONFIG_HOME="${HOME}/.config" || CONFIG_HOME="$XDG_CONFIG_HOME"
LOCAL_HOME="${HOME}/.local"

# Initialize home dir
for dir in "${DIRS_TO_CREATE[@]}"; do
    [[ ! -e "$dir" ]] && mkdir "$dir"
done

# Git clone tools conf from github
for repo in "${CONF_REPOS[@]}"; do
    echo "Getting $repo configuration files."
    repo_dir="${CONF_DIR}/${repo}"
    if [[ -e "$repo_dir" ]]; then
        (cd "$repo_dir" && git pull) || { echo "Failed to pull $repo"; exit 1; }
        [[ -f "$repo_dir/.gitmodules" ]] && (cd "$repo_dir" && git submodule update --recursive)
    else
        git clone "${GITHUB_REPOS_URL}${repo}.git" "$repo_dir" || { echo "Failed to clone $repo"; exit 1; }
        [[ -f "$repo_dir/.gitmodules" ]] && (cd "$repo_dir" && git submodule init && git submodule update --recursive)
    fi
done

# Creating symbolc links for configuration files
echo "Creating configuration files."
[[ ! -e "$CONFIG_HOME" ]] && mkdir -p "$CONFIG_HOME"
[[ ! -e "$LOCAL_HOME" ]] && mkdir -p "$LOCAL_HOME"
[[ ! -e "$LOCAL_HOME/share" ]] && mkdir -p "$LOCAL_HOME/share"

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
ln -sf "${DOTFILES_CFG_DIR}/.local/shell" "${LOCAL_HOME}/shell"

trap 'echo "Exiting due to error"; exit 1' ERR
trap 'echo "Script completed successfully"; exit 0' EXIT
