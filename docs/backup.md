# Backup

Full list of directories and files backed up during setup as defined by `$dotfilesdirarray`, `$dotfilesfilearray` and custom code in [`setup/files.sh`](../setup/files.sh).

Any matching directory or file will be copied to `~/backup/dotfiles-backup`.

## Directories 

From `$dotfilesdirarray`

- `~/bin`
- `~/.mackup`

## Files

From directories declared in `$dotfilesfilearray`

- `~/.aliases`
- `~/.bash_profile`
- `~/.bash_prompt`
- `~/.bashrc`
- `~/.exports`
- `~/.functions`
- `~/.inputrc`
- `~/.path`
- `~/.curlrc`
- `~/.editorconfig`
- `~/.gitattributes`
- `~/.gitconfig`
- `~/.gitignore`
- `~/.mackup.cfg`
- `~/.npmrc`
- `~/.exports`
- `~/.gemrc`
- `~/.exports`
- `~/.screenerc`
- `~/.dircolors`
- `~/.hushlogin`
- `~/.tmux.conf`
- `~/.vimrc`
- `~/.wgetrc`

## Custom backup

### Directories

- `~/.gnupg`
- `~/.nano`
- `~/.ssh`

### Files

- `~/.bash_history`
- `~/.extra`
- `~/.extra.fish`
- `~/.gitconfig.local`
- `~/.nanorc`
- `~/.netrc`
- `~/.z`