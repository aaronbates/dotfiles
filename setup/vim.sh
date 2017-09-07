#!/usr/bin/env bash

# Setup vim and packages
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# Set dotfilesdir var if it doesn't exist.
if [ -z ${dotfilesdir+x} ]; then
  dotfilesdir="$(dirname "$(pwd)")"
fi;

# Check if vim is installed.
if vim n 2>/dev/null; then
  botintro "Setting up vim and packages."

  # Declare array of vim directories to create.
  declare -a createvimdirarray=(
    "$HOME/.vim"
    "$HOME/.vim/autoload"
    "$HOME/.vim/bundle"
    "$HOME/.vim/colors"
    "$HOME/.vim/swaps"
    "$HOME/.vim/backups"
    "$HOME/.vim/undo"
  )

  action "Creating vim directories"
  # Send array to make_directories function.
  make_directories ${createvimdirarray[@]}

  if $dirsuccess; then
    success "vim directories created."
  else
    error "Errors when creating vim directories, please check and resolve."
    cancelled "\e[1mCannot proceed. Exit.\e[0m"
    exit -1
  fi;

  # Install pathogen: https://github.com/tpope/vim-pathogen
  action "Installing pathogen."
  curl -LSso "$HOME/.vim/autoload/pathogen.vim" "https://tpo.pe/pathogen.vim"

  # Install bundle plugins (using pathogen)
  cd "$HOME/.vim/bundle"
  git clone git://github.com/altercation/vim-colors-solarized.git # solarized
  git clone git://github.com/tpope/vim-sensible.git # vim sensible
  git clone git://github.com/scrooloose/nerdtree.git # nerdtree
  git clone git://github.com/ctrlpvim/ctrlp.vim.git # ctrlp
  cd "$dotfilesdir"

  # fin.
else
  echo "WARNING: vim not found.";
fi;
