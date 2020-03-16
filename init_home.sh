#!/usr/bin/env bash

set -o errexit

# =====================================
# Define constants
# =====================================
readonly BIN_DIR="${HOME}/bin"
readonly CONF_DIR="${HOME}/conf"
readonly SRC_DIR="${HOME}/dev"
readonly DOC_DIR="${HOME}/doc"
readonly TOOLS_DIR="${HOME}/tools"
readonly VIM_CFG_DIR="${CONF_DIR}/vimcfg"
readonly BASH_CFG_DIR="${CONF_DIR}/bashcfg"
readonly GIT_CFG_DIR="${CONF_DIR}/gitcfg"
readonly FIREFOX_CFG_DIR="${CONF_DIR}/firefoxcfg"

readonly GITHUB_REPOS_URL="https://github.com/cmoron/"

CURRENT_PATH="$PWD"

# =====================================
# Initialize home dir
# =====================================
[[ ! -e "$BIN_DIR" ]] && mkdir "$BIN_DIR"
[[ ! -e "$CONF_DIR" ]] && mkdir "$CONF_DIR"
[[ ! -e "$SRC_DIR" ]] && mkdir "$SRC_DIR"
[[ ! -e "$DOC_DIR" ]] && mkdir "$DOC_DIR"
[[ ! -e "$TOOLS_DIR" ]] && mkdir "$TOOLS_DIR"

# =====================================
# Git clone tools conf from github
# =====================================
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

echo "Getting bash configuration files."
if [[ -e "$BASH_CFG_DIR" ]]; then
    cd "$BASH_CFG_DIR"
    git pull
    cd "$CURRENT_PATH"
else
    git clone "${GITHUB_REPOS_URL}bashcfg.git" "$BASH_CFG_DIR"
fi

echo "Getting git configuration files."
if [[ -e "$GIT_CFG_DIR" ]]; then
    cd "$GIT_CFG_DIR"
    git pull
    cd "$CURRENT_PATH"
else
    git clone "${GITHUB_REPOS_URL}gitcfg.git" "$GIT_CFG_DIR"
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
ln -sf "${VIM_CFG_DIR}/vimrc" "${HOME}/.vimrc"
ln -sf "${VIM_CFG_DIR}/vim" "${HOME}/.vim"
ln -sf "${BASH_CFG_DIR}/bashrc" "${HOME}/.bashrc"
ln -sf "${GIT_CFG_DIR}/gitconfig" "${HOME}/.gitconfig"

cd "$CURRENT_PATH"
