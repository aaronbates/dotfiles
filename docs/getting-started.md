# Getting started

There's a huge amount of features and tools to cover in any sort of usage guide, so rather than attempt to be exhaustive I've highlighted key areas for you to explore below.

**Contents**

1. [Bash](#bash)
2. [Git](#git)
3. [Vim](#vim)
4. [tmux](#tmux)
5. [Other](#other)

## Bash

Use iTerm2 as installed (or Terminal if you really prefer). 

Consult the [`.aliases`](../bash/.aliases) and [`.functions`](../bash/.functions) files, everything is commented. Local config via `~/.extra`.

Some of my favourites:

- `..`
- `la` — list all files, long format
- `cdf` — change working dir to top Finder window location
- `cdl <directory>` — change to directory, then list contents
- `mkd <name>` — make directory and then enter it
- `f <keyword>` — fast, recursive search for file name in directories
- `extract <archive>` — unpack any archive
- `tre <directory>`
- `npmg` — list global npm packages
- `update` — update system and all packages managers

### A better prompt

Auto-completion that doesn't suck. Case insensitivity. No more "Display all 1745 possibilities? (y or n)". Type `cat <uparrow>` to see your previous cats — thanks [`.bash_prompt`](../bash/.bash_prompt) and [`.inputrc`](../bash/.inputrc)!

### `z` is awesome.

The `z` command helps you move around quickly between your frequently used folders:

```bash
$ z dotfiles
$ z blog
```

It learns once installed and you'll have to cd around for a while to "train" it, but it's worth the effort. Also, you can use `open .` to open a Finder window of the directory you land in.

### Take the `trash` out

Use `trash` as a better alternative to `rm`. Files actually go to Trash and can be restored.

## Git

Git is aliased to `g` on the command line and also has a number of useful aliases mapped within it — please consult the [`.gitconfig`](../git/.gitconfig) file, everything is commented. Some examples (you can run these all as just `g [alias]` too):

```bash
$ git l # view abbreviated log of the last 20 commits
$ git s # view "short" status
$ git c # clone a repo and all submodules

$ git ca # commit all changes (verbose)

$ git aliases # list all available aliases
```

Local config is available using `~/.gitconfig.local`

### Shorthands

Another nice feature is "git shorthands" which makes it quicker to fire off commands, for example:

```bash
$ g c gh:aaronbates/dotfiles

# is the same as writing
$ git clone git@github.com:aaronbates/dotfiles.git
```

### hub

Helper commands for Github. See [hub](https://hub.github.com) — not aliased to `git`.

### git-friendly

Workflow tools for git. See [git-friendly](https://github.com/jamiew/git-friendly) — `branch`, `pull`, `push`, `merge`

### useful git tools

- `changelog` — show log in a change log suitable format
- `git delete-merged-branches` — display then delete merged local and remote branches
- `git pr` — checkout a pull request from Github as a local branch
- `git recent` — see latest local git branches nicely formatted
- `git resolve` — mark all conflicts as resolved
- `git unreleased` — show commits since last tag
- [`git open`](https://github.com/paulirish/git-open) — open repo github pages in browser

### Semantic commit messages

Also of use are semantic git commit messages as inspired by [Sparkbox's article](https://seesparkbox.com/foundry/semantic_commit_messages) and [semantic-git-commits](https://github.com/fteem/git-semantic-commits):

1. Use a rigid commit message format.
2. Prefix commit messages with a type (feat, chore, fix, etc.)
3. Provide a summary in present tense.

Format: `git [type] "commit-message-here"`

Available types: `chore`, `docs`, `feat`, `fix`, `localize`, `refactor`, `style`, `test`

Examples:

```
chore: add build script
docs: explain how feature works
feat: add new component
fix: remove broken confirmation message
localize: translate help to Italian
refactor: share logic between x and y
style: convert tabs to spaces
test: ensure a retains b
```

Usage:

- `git c-chore "message"` = `git commit -m 'chore: commit-message-here'`
- `git c-docs "message"` = `git commit -m 'docs: commit-message-here'`
- `git c-feat "message"` = `git commit -m 'feat: commit-message-here'`
- `git c-fix "message"` = `git commit -m 'fix: commit-message-here'`
- `git c-localize "message"` = `git commit -m 'localize: commit-message-here'`
- `git c-refactor "message"` = `git commit -m 'refactor: commit-message-here'`
- `git c-style "message"` = `git commit -m 'style: commit-message-here'`
- `git c-test "message"` = `git commit -m 'test: commit-message-here'`

Also if you run any of these aliases without a message you will be prompted to enter a commit message using your text editor, for example:

`git c-feat` = `git commit -m 'feat: ' -e`

## Vim

Nice settings from [`.vimrc`](../vim/.vimrc), check the comments.

- Aliased to `v` on the command line
- Backups, swaps and undo
- [`vim-pathogen`](https://github.com/tpope/vim-pathogen) to manage plugins
- [`vim-sensible`](https://github.com/tpope/vim-sensible) for sensible defaults
- [`nerdtree`](https://github.com/scrooloose/nerdtree) — tree explorer, toggle with `,d` (find with `,f`)
- [`ctrlp.vim`](https://github.com/ctrlpvim/ctrlp.vim) — fuzzy finder, run using `,t` (buffer find with `,b`)
- Local config using `~/.vimrc.local`

## tmux

Settings from [`.tmux.conf`](../tmux/.tmux.conf), see comments.

- Prefix `CTRL+a` rather than `CTRL+b`
- Pane switching with prefix `h`, `j`, `k`, `l`
- Split windows with prefix `"` and `%`
- New window with prefix `c`
- Custom status bar
- [`reattach-to-user-namespace`](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard) for macOS clipboard access
- Local config using `~/.tmux.conf.local`

## Other

- [`vtop`](https://github.com/MrRio/vtop) — activity monitor for the command line
- `weather` — weather from [wttr.in](http://wttr.in)
- [`wifi-password`](https://github.com/rauchg/wifi-password) — grab local wifi password from OS X Keychain

### A word on Unix style permissions

Permissions are specified for three categories of users:

- **User:** the owner of the file
- **Group:** the members of the group associated with the file
- **All:** everyone

Per category, the following permissions can be granted:

- **r (read):** the users in the category are allowed to read the file
- **w (write):** the users in the category are allowed to change the file
- **x (execute):** the users in the category are allowed to run the file

That means that permissions can be represented by 9 *bits* (3 categories with 3 permissions each):

            | User    | Group   | All   
----------- | ------- | ------- | -------
Permissions | r, w, x | r, w, x | r, w, x
Bit.        | 8, 7, 6 | 5, 4, 3 | 2, 1, 0

The permissions of a single category of users are stored in 3 bits:

Bits | Permissions | Octal digit
---- | ----------- | -----------
000  | –––         | 0
001  | ––x         | 1
010  | –w–         | 2
011  | –wx         | 3
100  | r––         | 4
101  | r–x         | 5
110  | rw–         | 6
111  | rwx         | 7

This means octal numbers are a compact representation of all permissions, you only need 3 digits, one digit per category of users.

Two examples:

1. **755** = 111,101,101: I can change, read and execute; everyone else can only read and execute.
2. **640** = 110,100,000: I can read and write; group members can read; everyone can’t access at all.
