#!/usr/bin/env bash

# =====================================
# Define constants
# =====================================
readonly BIN_DIR="${HOME}/bin"
readonly CONF_DIR="${HOME}/conf"
readonly SRC_DIR="${HOME}/src"
readonly DOC_DIR="${HOME}/doc"
readonly TOOLS_DIR="${HOME}/tools"

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
git clone https://github.com/cmoron/vimcfg.git "$CONF_DIR/vimcfg"
git clone https://github.com/cmoron/bashcfg.git "$CONF_DIR/bashcfg"
