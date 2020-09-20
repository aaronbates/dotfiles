# Migration guide

There are times when you need to move a configured setup to a new machine — to prevent data loss in this circumstance there is an optional migration script available to help.

```bash
$ cd ~/dotfiles/setup && ./migrate.sh
```

This task performs the following steps:

## Step 1: Create directories

- `~/migration`
- `~/migration/home`
- `~/migration/Library/Application Support`
- `~/migration/Library/Preferences`
- `~/migration/rootLibrary/Preferences/SystemConfiguration`

## Step 2: Export lists from package managers

Exports list of installed applications from Homebrew, Homebrew Cask, npm and Yarn to `~/migration`:

- `brew leaves > "~/migration/brew-list.txt"`
- `brew cask list > "~/migration/cask-list.txt"`
- `npm list -g --depth=0 > "~/migration/npm-g-list.txt"`
- `yarn global list --depth=0 > "~/migration/yarn-g-list.txt"`

## Step 3: Copy files to `~/migration`

- Copy `~/Desktop` to `~/migration/Desktop`
- Copy `~/Documents` to `~/migration/Documents`
- Copy `~/Downloads` to `~/migration/Downloads`
- Copy `~/code` to `~/migration/code`
- Copy `~/projects` to `~/migration/projects`
- Copy `~/Work` to `~/migration/Work`

Then remind the user to copy other data such as Applications, Games, Movies, Music, Photos and so on.

## Step 4: Copy other data to `~/migration`

- Copy wi-fi settings
- Copy automator settings
- Copy installed fonts

Then finally suggest a list of other data and settings the user should consider migrating (git branches, tabs, logs, licenses, etc.)
