#!/usr/bin/env bash

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in "$HOME/."{exports,path,bash_prompt,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Generic colouriser.
GRC=`which grc`;
if [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
  alias colourify="$GRC -es --colour=auto";
  alias configure='colourify ./configure';
  for app in {diff,make,gcc,g++,ping,traceroute}; do
    alias "$app"='colourify '$app;
  done;
fi;

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it.
shopt -s histappend

# Save multi-line commands as one command.
shopt -s cmdhist

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Autocorrect on directory names to match a glob.
shopt -s dirspell 2> /dev/null

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands.
if hash brew 2>/dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# homebrew completion
if hash brew 2>/dev/null && [ -f /usr/local/etc/bash_completion.d/brew ]; then
  source "$(brew --prefix)/etc/bash_completion.d/brew"
fi;

# homebrew cask completion
if hash brew 2>/dev/null && [ -f /usr/local/etc/bash_completion.d/brew-cask ]; then
  source "$(brew --prefix)/etc/bash_completion.d/brew-cask"
fi;

# Enable tab completion for `g` by marking it as an alias for `git`.
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# hub completion
if hash hub 2>/dev/null && [ -f /usr/local/etc/bash_completion.d/hub.bash_completion.sh ]; then
  source "$(brew --prefix)/etc/bash_completion.d/hub.bash_completion.sh";
fi;

# gibo completion
if hash gibo 2>/dev/null && [ -f /usr/local/etc/bash_completion.d/gibo-completion.bash ]; then
  source "$(brew --prefix)/etc/bash_completion.d/gibo-completion.bash";
fi;

# awscli completion
if hash awscli 2>/dev/null && [ -f /usr/local/bin/aws_completer ]; then
  complete -C '/usr/local/bin/aws_completer' aws
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards.
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" $HOME/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`.
# You could just use `-g` instead, but I like being explicit.
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps.
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTerm2 iTunes SystemUIServer Terminal Twitter" killall;

# z beats cd most of the time. `brew install z`
zpath="$(brew --prefix)/etc/profile.d/z.sh"
[ -s $zpath ] && source $zpath

# Enable history expansion with space.
# e.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# pyevnv
if hash pyenv 2>/dev/null; then
  eval "$(pyenv init -)";
fi

if hash pyenv-virtualenv-init 2>/dev/null; then
  eval "$(pyenv virtualenv-init -)";
fi

# rbenv
if hash rbenv 2>/dev/null; then
  eval "$(rbenv init -)";
fi
