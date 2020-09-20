#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# --------------------
# Migration (optional)
# --------------------

migrationapproved=false;

botintro "\e[1mMIGRATION\e[0m"

ask_for_confirmation "\nWould you like to migrate your existing system?";
if answer_is_yes; then
  ok "This takes a few steps:"

  botintro "NOTE: This is not exhaustive, it will migrate some important directories and files to ~/migration and \e[1manything in that directory will be overwritten\e[0m -- please read the docs, code and refer to your own system first."

  ask_for_confirmation "\nAre you sure you want to proceed?";
  if answer_is_yes; then
    migrationapproved=true;
  fi;
fi;

if ! $migrationapproved; then
  cancelled "\e[1mMigration not approved. Exiting.\e[0m"
  exit -1
fi;

botintro "Running migration tasks."
action "Creating directories."

migrationdir="$HOME/migration"

# Create migration directories.
mkdir -p "$migrationdir"
mkdir -p "$migrationdir/home/"
mkdir -p "$migrationdir/Library/Application Support/"
mkdir -p "$migrationdir/Library/Preferences/"
mkdir -p "$migrationdir/rootLibrary/Preferences/SystemConfiguration/"

success "Directories created."

# Export lists of installed apps from brew, brew cask, npm and yarn.
action "Exporting installed apps (brew/npm/yarn)"
brew leaves > "$migrationdir/brew-list.txt" # all top-level brew installs
brew cask list > "$migrationdir/cask-list.txt"
npm list -g --depth=0 > "$migrationdir/npm-g-list.txt"
yarn global list --depth=0 > "$migrationdir/yarn-g-list.txt"

ok "See $migrationdir for exported apps .txt files."

# You can compare brew-list to what's in `brew.sh`
# comm <(sort brew-list.txt) <(sort brew.sh-cleaned-up)

action "Copying files to $migrationdir"
echo -e "\nPress \e[1mENTER\e[0m to continue."
read -n 1

# Copy files from major directories.
cp -Rp "$HOME/Desktop" "$migrationdir"
cp -Rp "$HOME/Documents" "$migrationdir"
cp -Rp "$HOME/Downloads" "$migrationdir"
cp -Rp "$HOME/code" "$migrationdir"
cp -Rp "$HOME/projects" "$migrationdir"
cp -Rp "$HOME/Work" "$migrationdir"

# Suggest to user other files to handle.
warn "Consider how to migrate your Applications."
warn "Consider how to migrate your Backup."
warn "Consider how to migrate your Games."
warn "Consider how to migrate your Movies."
warn "Consider how to migrate your Music."
warn "Consider how to migrate your Photos."
warn "Consider how to migrate your Pictures."

success "Files copied."

echo -e "\nPress \e[1mENTER\e[0m to continue."
read -n 1

# Copy key settings.
action "Copying settings."
# Wi-fi settings
cp -Rp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist "$migrationdir/rootLibrary/Preferences/SystemConfiguration/"
# Automator
cp -Rp "$HOME/Library/Services" "$migrationdir/Library/"

success "Settings copied."

# Copy installed fonts.
action "Copying fonts."
cp -Rp "$HOME/Library/Fonts" "$migrationdir/Library/"

success "Fonts copied."

# Final suggestions.
warn "\nAlso consider:"
warn "- Finder settings."
warn "- Random git branches and untracked files."
warn "- Chrome tabs"
warn "- Usage logs."
warn "- Software licenses."

echo -en "\n"
success "\e[1mMigration completed to $HOME/migration\e[0m"

