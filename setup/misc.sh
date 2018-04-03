#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

action "Setting up .nanorc"
# Install better nanorc config.
# https://github.com/scopatz/nanorc
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

action "Setting chmod for ~/.ssh"
chmod 700 "$HOME/.ssh"
print_result $? "Set chmod 700 on ~/.ssh"

action "Setting chmod for ~/.gnupg"
mkdir "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"

# Install the Solarized Dark theme for Terminal
action "Installing Solarized Dark for Terminal"
open "${dotfilesdir}/terminal/Solarized Dark xterm-256color.terminal"

# Install the Solarized Dark High Contrast theme for iTerm2
action "Installing Solarized Dark High Contrast for iTerm2"
open "${dotfilesdir}/iterm2/Solarized Dark High Contrast.itermcolors"

success "Final touches in place."
