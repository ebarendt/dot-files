# dot-files

Managed with [mise](https://mise.jdx.dev). `mise/config.toml` declares the tools,
system packages (Homebrew on macOS, pacman on Arch) and dotfile links.

You only need git and curl. If mise is missing, `dot setup` installs it to
`~/.local/bin` with the official installer (https://mise.run); update it later
with `mise self-update`.

```shell
git clone <this repo> ~/src/dot-files
~/src/dot-files/bin/dot setup --dry-run   # preview
~/src/dot-files/bin/dot setup             # apply
```

`dot setup` refuses to overwrite existing files; move them aside (or run
`mise dotfiles apply --force`) the first time. The exception is the stock niri
and noctalia configs a fresh CachyOS install copies from `/etc/skel`: setup
removes those itself, as long as they still match `/etc/skel`. After that mise
puts `bin/` on your PATH (via `[env]`), so you can run `dot` directly in any
shell with mise activated. Other commands: `dot status`, `dot diff`,
`dot outdated`.

On a new Linux (CachyOS) machine, after `dot setup` (details below):

```shell
dot hibernate          # then test: systemctl hibernate
dot fingerprint
dot docker             # then log out and back in
fprintd-enroll         # then check: fprintd-verify
dot mounts             # optional: diskstation SMB shares
```

# SMB shares (Linux)

`dot mounts` adds the diskstation `home` and `public` shares to `/etc/fstab`
(from `linux/fstab-smb`) as systemd automounts at `~/ds` and `~/public`. It uses
sudo, and prompts once for the share credentials, which are stored in
`/etc/samba/credentials.d/diskstation` and never in this repo. Safe to re-run;
`dot mounts --dry-run` previews.

# Hibernate (Linux)

`dot hibernate` makes closing the lid suspend, then hibernate after 30 minutes
(`linux/systemd/`). Hibernation needs swap on disk, so it adds a btrfs `@swap`
subvolume at `/swap` with a swapfile a little larger than RAM; zram stays the
higher-priority swap. It uses sudo, is safe to re-run, and `--dry-run` previews.
Test with `systemctl hibernate` before relying on it.

# Docker (Linux)

`dot setup` installs docker, compose and buildx. `dot docker` (sudo) enables
`docker.socket`, so the daemon starts on first use, and adds you to the `docker`
group; log out and back in for the group to apply. Safe to re-run, and
`--dry-run` previews. The group is effectively root on the machine.

# Fingerprint (Linux)

CachyOS already allows fingerprint for `sudo`, and `noctalia/config.toml` turns
on fingerprint unlock for the lock screen. `dot fingerprint` (sudo) installs
`linux/pam.d/polkit-1`, so polkit prompts take a fingerprint too; that's what
1Password's "Unlock using system authentication" uses. Fingerprints aren't
stored here, so run `fprintd-enroll` on each machine, then `fprintd-verify`. If
enroll reports
"Finger was already enrolled", the Goodix sensor still holds prints from an
earlier install: stop fprintd and wipe them with libfprint's
`FPrint.Device.clear_storage_sync()` (as root, via python3-gobject), then
re-enroll.

# Keybindings (macOS)

http://cobus.io/osx/2017/02/09/OSX_Home_End_Keys.html

```shell
mkdir -p ~/Library/KeyBindings
cp ~/src/dot-files/DefaultKeyBinding.dict ~/Library/KeyBindings
# then reboot
```
