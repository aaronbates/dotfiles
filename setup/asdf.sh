#!/usr/bin/env bash

# Setup asdf and install global versions
# Requires: asdf and asdf-nodejs
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# Check if asdf is installed.
if hash asdf 2>/dev/null; then
  botintro "Setup asdf and global versions"

  # node
  action "asdf: setting up Node"

  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

  # install
  action "asdf: installing global versions"

  asdf install

  # fin.
else
  echo "WARNING: asdf not found."
fi;
