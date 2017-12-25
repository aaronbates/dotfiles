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
  npm install --global create-react-app
  npm install --global caniuse-cmd
  npm install --global doctoc
  npm install --global git-open
  npm install --global git-recent
  npm install --global gulp-cli
  npm install --global gzip-size-cli
  npm install --global http-server
  npm install --global imageoptim-cli
  npm install --global imgur-uploader-cli
  npm install --global is-up-cli
  npm install --global moro
  npm install --global npm-check
  npm install --global npm-home
  npm install --global npm-name-cli
  npm install --global pageres-cli
  npm install --global prettier
  npm install --global remote-share-cli
  npm install --global serve
  npm install --global speed-test
  npm install --global stylelint
  npm install --global surge
  npm install --global svgo
  npm install --global trash-cli
  npm install --global viewport-list-cli
  npm install --global vtop

  # fin.
else
  echo "WARNING: n not found.";
fi;
