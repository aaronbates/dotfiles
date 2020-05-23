#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# Set install flag to false
brewinstall=false

bot "Install Homebrew and all required apps."

ask_for_confirmation "\nReady to install apps? (get a coffee, this takes a while)";

# Flag install to go if user approves
if answer_is_yes; then
  ok
  brewinstall=true
else
  cancelled "Homebrew and applications not installed."
fi;

if $brewinstall; then
  # Prevent sleep.
  caffeinate &

  action "Installing Homebrew"
  # Check if brew installed, install if not.
  if ! hash brew 2>/dev/null; then
    # note: if your /usr/local is locked down (like at Google), you can do this to place everything in ~/.homebrew
    # mkdir "$HOME/.homebrew" && curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C $HOME/.homebrew
    # then add this to your path: export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    print_result $? 'Install Homebrew.'
  else
    success "Homebrew already installed."
  fi;

  running "brew update + brew upgrade"
  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade

  # CORE

  running "Installing apps"
  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  brew install coreutils

  # Install some other useful utilities like `sponge`.
  brew install moreutils
  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  brew install findutils
  # Install GNU `sed`, overwriting the built-in `sed`.
  brew install gnu-sed --with-default-names

  # Install Bash 4.
  # Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
  # running `chsh`.
  brew install bash
  brew install bash-completion2

  # Switch to using brew-installed bash as default shell
  if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
    echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
    chsh -s /usr/local/bin/bash;
  fi;

  # zsh
  brew install zsh
  brew install zsh-completion

  # Install `wget` with IRI support.
  brew install wget --with-iri

  # Install GnuPG to enable PGP-signing commits.
  brew install gnupg

  # Install more recent versions of some native macOS tools.
  brew install perl
  brew install vim --with-override-system-vi
  brew install grep
  brew install nano
  brew install openssh
  brew install screen

  # Key tools.
  brew install git
  brew install tmux
  brew install z

  # OTHER USEFUL UTILS
  brew install ack
  brew install advancecomp
  brew install brew-cask-completion
  brew install cloc
  brew install cmake
  brew install diff-so-fancy
  brew install fzf
  brew install gibo && gibo -l
  brew install gifsicle
  brew install git-delta
  brew install git-extras
  brew install git-lfs
  brew install grc
  brew install httpie
  brew install hub
  brew install icdiff
  brew install imagemagick --with-webp
  brew install jhead
  brew install jp2a
  brew install jpegoptim
  brew install jq
  brew install libgit2
  brew install mas
  brew install mtr
  brew install ngrep
  brew install nmap
  brew install optipng
  brew install p7zip
  brew install pidof
  brew install pigz
  brew install pngcrush
  brew install pngquant
  brew install pv
  brew install readline
  brew install reattach-to-user-namespace
  brew install rename
  brew install roundup
  brew install spaceman-diff
  brew install spark
  brew install speedtest-cli
  brew install ssh-copy-id
  brew install terminal-notifier
  brew install the_silver_searcher
  brew install trash-cli
  brew install tree
  brew install ttygif
  brew install unrar
  brew install vbindiff
  brew install wifi-password
  brew install youtube-dl
  brew install zopfli

  # BACKUP
  brew install mackup

  # DEVELOPMENT
  brew install asdf
  brew install n
  brew install yarn
  brew install go
  brew install homebrew/php/php56 --with-gmp
  brew install pyenv
  brew install pyenv-virtualenv
  brew install rbenv
  brew install ruby-build
  brew install rbenv-gemset

  # DATABASES
  brew install postgresql
  #brew install elasticsearch
  #brew install mariadb
  brew install mongodb
  brew install mysql@5.7
  brew install redis

  # DEVOPS
  brew install awscli
  brew install heroku
  brew install nginx
  brew install puma/puma/puma-dev
  brew install docker
  # brew install docker-compose
  # brew install docker-machine
  # brew install xhyve
  # brew install docker-machine-driver-xhyve
  # brew install boot2docker

  # NET UTILS
  brew tap ZloeSabo/homebrew-nettools

  brew install httplab
  brew install wuzz

  # pngout
  brew tap jonof/kenutils

  brew install/pngout

  # WEBFONT TOOLS
  running "Installing webfont tools"

  brew tap bramstein/webfonttools

  brew install sfnt2woff
  brew install sfnt2woff-zopfli
  brew install woff2

  # FONTS
  running "Installing fonts"

  brew tap caskroom/fonts

  brew cask install font-domine
  brew cask install font-droid-sans
  brew cask install font-droid-sans-mono
  brew cask install font-fira-code
  brew cask install font-fira-sans
  brew cask install font-fontawesome
  brew cask install font-inconsolata
  brew cask install font-lato
  brew cask install font-open-sans
  brew cask install font-roboto
  brew cask install font-source-code-pro
  brew cask install font-source-sans-pro
  brew cask install font-ubuntu

  running "Installing cask apps"

  # APPLICATIONS
  brew tap caskroom/cask
  brew tap caskroom/versions

  # Security
  brew cask install dashlane
  brew cask install keybase
  brew cask install gpgtools
  brew cask install tunnelblick

  # General
  brew cask install caffeine
  brew cask install discord
  brew cask install diskwave
  brew cask install dropbox
  brew cask install firefox
  brew cask install google-chrome
  brew cask install grammarly
  brew cask install iterm2
  brew cask install licecap
  brew cask install macdown
  brew cask install oversight
  brew cask install rocket
  brew cask install slack
  brew cask install slite
  brew cask install spectacle
  brew cask install spotify
  brew cask install vlc
  brew cask install zoomus

  # Design
  brew cask install abstract
  brew cask install fontbase
  brew cask install framer
  brew cask install iconjar
  brew cask install sketch
  brew cask install zeplin

  # Development
  brew cask install dash
  brew cask install google-chrome-canary
  brew cask install graphiql
  brew cask install imagealpha
  brew cask install imageoptim
  brew cask install ngrok
  brew cask install sequel-pro
  # brew cask install sublime-text
  brew cask install visual-studio-code

  # DevOps
  brew cask install aws-vault
  brew cask install sequel-pro

  # VM
  # brew cask install virtualbox
  # brew cask install vagrant

  # Quicklook
  brew cask install qlcolorcode
  brew cask install qlstephen
  brew cask install qlmarkdown
  brew cask install quicklook-json
  brew cask install qlprettypatch
  brew cask install quicklook-csv
  # brew cask install betterzipql
  # brew cask install qlimagesize
  brew cask install webpquicklook
  brew cask install suspicious-package
  brew cask install quicklookase
  brew cask install qlvideo

  # Install Mac App Store Applications.
  # requires: brew install mas
  mas install 1254981365 # Contrast
  mas install 1234952668 # FlagTimes
  mas install 1225570693 # Ulysses
  # TODO: install pixelsnap

  running "brew cleanup"
  # Remove outdated versions from the cellar.
  brew cleanup

  # turn off prevent sleep.
  killall caffeinate
fi;
