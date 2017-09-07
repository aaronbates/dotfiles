#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# Load dirs and files if not already loaded.
if [ -z ${filesloaded+x} ]; then
  source ./files.sh
  echo -en "\n"
fi;

# Set dotfilesdir var if not declared.
if [ -z ${dotfilesdir+x} ]; then
  dotfilesdir="$(dirname "$(pwd)")"
fi;

# Set defaultdotfilesdir var if not declared.
if [ -z ${defaultdotfilesdir+x} ]; then
  defaultdotfilesdir="$HOME/dotfiles"
fi;

botintro "Unlink all symlinked directories and files"

action "Unlinking linked directories."
# Unlink symlinked directories
for i in "${dotfilesdirarray[@]}"; do
  # Unlink, targetting directory links from $dotfilesdir to $HOME
  unlink_symlinks "$i" "$dotfilesdir" "$HOME"
done;

action "Unlinking linked files."
# Unlink files in symliked directories
for i in "${dotfilesfilearray[@]}"; do
  declare -a tmparr=()

  # Properly store the results of find on these directories in an array
  # We want to handle .*, *.cfg, *.conf and NOT .DS_Store, .git, .osx, .macos and no *.sh files
  while IFS=  read -r -d $'\0'; do
    tmparr+=("$REPLY")
  done < <(find "$i" -type f -maxdepth 1 \( -name ".*" -o -name "*.cfg" -o -name "*.conf" \) -a -not -name .DS_Store -not -name .git -not -name .osx -not -name .macos -not -name "*.sh" -print0)

  for j in "${tmparr[@]}"; do
    # Unlink, targetting links from $i (parent folder of dotfile group) to $HOME
    unlink_symlinks "$j" "$i" "$HOME"
  done;
done;

action "Unlink custom linked files."
# Unlink git-friendly symlinks
unlink_symlinks "$dotfilesdir/bin/git-friendly/branch" "$dotfilesdir/bin/git-friendly" "$dotfilesdir/bin"
unlink_symlinks "$dotfilesdir/bin/git-friendly/merge" "$dotfilesdir/bin/git-friendly" "$dotfilesdir/bin"
unlink_symlinks "$dotfilesdir/bin/git-friendly/pull" "$dotfilesdir/bin/git-friendly" "$dotfilesdir/bin"
unlink_symlinks "$dotfilesdir/bin/git-friendly/push" "$dotfilesdir/bin/git-friendly" "$dotfilesdir/bin"

# Unlink "$HOME/dotfiles" if required.
# Check if "$HOME/dotfiles" exists
if [ -e "$defaultdotfilesdir" ]; then
  # Check if this is where our files are stores
  if [[ "$dotfilesdir" -ef "$defaultdotfilesdir" ]]; then
    # Check if symlink in place
    if [ -L "$defaultdotfilesdir" ]; then
      action "Unlinking '$HOME/dotfiles'"
      unlink "$defaultdotfilesdir"
    fi;
  fi;
fi;

echo -en "\n"
success "Processed unlinking.\n"
