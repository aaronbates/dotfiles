# Mac OS X Setup Guide

These are the steps I like to take on a fresh Mac install to prep it before [installing my dotfiles](https://github.com/aaronbates/dotfiles):

## General

1. Log in, run `Software Update`, apply, restart.
2. Create an Admin user for your use, *disable the guest account*.
3. Log into your new personal Admin user (**only use this now**)
4. Source external HDD, set-up `Time Machine`.

## Preferences

`Apple Icon > System Preferences`:

1. Configure `Trackpad`.
2. Set `Keyboard > Key Repeat > Fast` to `Fast`.
3. Set `Keyboard > Delay Until Repeat` to `Short`.
4. `Sharing` set computer name.

## Security

`Apple Icon > System Preferences > Security & Privacy`:

1. Set `General > Require a password after sleep…` to `Immediately`
2. In `Advanced` set `Require an administrator password...` to ticked.
3. In `Firewall` turn Firewall on.
4. Enable `File Vault`.
5. Set a Firmware password from `macOS Recovery` (⌘-R)

At this point you should be good to go.
