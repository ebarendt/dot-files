# dot-files

Managed with [mise](https://mise.jdx.dev). `mise/config.toml` declares the tools,
system packages (Homebrew on macOS, pacman on Arch) and dotfile links.

```shell
git clone <this repo> ~/src/dot-files
~/src/dot-files/bin/dot setup --dry-run   # preview
~/src/dot-files/bin/dot setup             # apply
```

`dot setup` refuses to overwrite existing files; move them aside (or run
`mise dotfiles apply --force`) the first time. After that mise puts `bin/` on
your PATH (via `[env]`), so you can run `dot` directly in any shell with mise
activated. Other commands: `dot status`, `dot diff`, `dot outdated`.

# SMB shares (Linux)

`dot mounts` adds the diskstation `home` and `public` shares to `/etc/fstab`
(from `linux/fstab-smb`) as systemd automounts at `~/ds` and `~/public`. It uses
sudo, and prompts once for the share credentials, which are stored in
`/etc/samba/credentials.d/diskstation` and never in this repo. Safe to re-run;
`dot mounts --dry-run` previews.

# Keybindings (macOS)

http://cobus.io/osx/2017/02/09/OSX_Home_End_Keys.html

```shell
mkdir -p ~/Library/KeyBindings
cp ~/src/dot-files/DefaultKeyBinding.dict ~/Library/KeyBindings
# then reboot
```
