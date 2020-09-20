#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# Set dotfilesdir var if not declared.
if [ -z ${dotfilesdir+x} ]; then
  dotfilesdir="$(dirname "$(pwd)")"
fi;

botintro "Sourcing directories and files to handle."

# Declare array of directories we want to symlink.
declare -a dotfilesdirarray=(
  "$dotfilesdir/bin"
  "$dotfilesdir/.mackup"
)

# Declare array of directories we want to symlink files from.
declare -a dotfilesfilearray=(
  "$dotfilesdir/ack"
  "$dotfilesdir/asdf"
  "$dotfilesdir/bash"
  "$dotfilesdir/curl"
  "$dotfilesdir/editor"
  "$dotfilesdir/git"
  "$dotfilesdir/mackup"
  "$dotfilesdir/node"
  "$dotfilesdir/ruby"
  "$dotfilesdir/screen"
  "$dotfilesdir/shell"
  "$dotfilesdir/tmux"
  "$dotfilesdir/vim"
  "$dotfilesdir/wget"
)

success "Directories and files sourced."

# Flag files as loaded
filesloaded=true
