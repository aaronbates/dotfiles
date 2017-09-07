#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

bot "Create required directories."

# Declare array of directories.
declare -a createdirarray=(
  "$HOME/Applications"
  "$HOME/Work"
  "$HOME/projects"
  "$HOME/code"
  "$HOME/.tmp"
  "$HOME/.ssh"
  "$HOME/.ssh/control"
)

action "Creating directories"
# Send array to make_directories function.
make_directories ${createdirarray[@]}

if $dirsuccess; then
  success "Directories created."
else
  error "Errors when creating directories, please check and resolve."
  cancelled "\e[1mCannot proceed. Exit.\e[0m"
  exit -1
fi;

