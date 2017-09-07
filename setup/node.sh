#!/usr/bin/env bash

# Setup Node and install global packages
# Requires: n
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# Check if n is installed.
if hash n 2>/dev/null; then
  botintro "Installing latest and LTS versions of Node."

  # Install latest distro.
  n latest;

  # Install LTS distro.
  n lts;

  action "Updating npm."
  # Update npm for LTS.
  npm install npm -g;

  # Declare array of Node directories.
  declare -a createnodedirarray=(
    "$HOME/.node-global-modules"
  )

  action "Creating Node directories"
  # make Node dirs
  make_directories ${createnodedirarray[@]}

  if $dirsuccess; then
    success "Node directories created."
  else
    error "Errors when creating Node directories, please check and resolve."
    cancelled "\e[1mCannot proceed. Exit.\e[0m"
    exit -1
  fi;

  action "Installing Node global packages."
  # Install global Node packages.
  npm install -g create-react-app
  npm install -g doctoc
  npm install -g git-open
  npm install -g git-recent
  npm install -g grunt-cli
  npm install -g gulp-cli
  npm install -g npm-check
  npm install -g trash-cli
  npm install -g vtop

  # fin.
else
  echo "WARNING: n not found.";
fi;
