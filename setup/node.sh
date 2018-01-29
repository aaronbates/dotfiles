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

  packages=(
    create-react-app
    caniuse-cmd
    doctoc
    git-open
    git-recent
    gulp-cli
    gzip-size-cli
    http-server
    imageoptim-cli
    imgur-uploader-cli
    is-up-cli
    lighthouse
    moro
    npm-check
    npm-home
    npm-name-cli
    pageres-cli
    prettier
    remote-share-cli
    serve
    source-map-explorer
    speed-test
    stylelint
    surge
    svgo
    trash-cli
    viewport-list-cli
    vtop
  )

  action "Installing Node global packages."
  # Install global Node packages.
  for package in ${packages[@]}; do
    npm install --global $package
  done

  # fin.
else
  echo "WARNING: n not found.";
fi;
