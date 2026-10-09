# dot-files

Managed with [mise](https://mise.jdx.dev). `mise/config.toml` declares the tools,
system packages (Homebrew on macOS, pacman on Arch) and dotfile links.

```shell
git clone <this repo> ~/src/dot-files
MISE_GLOBAL_CONFIG_FILE=~/src/dot-files/mise/config.toml mise dotfiles diff   # preview
MISE_GLOBAL_CONFIG_FILE=~/src/dot-files/mise/config.toml mise bootstrap       # apply
```

After the first apply, `~/.config/mise/config.toml` links back to this repo.

# Keybindings (macOS)

http://cobus.io/osx/2017/02/09/OSX_Home_End_Keys.html

```shell
mkdir -p ~/Library/KeyBindings
cp ~/src/dot-files/DefaultKeyBinding.dict ~/Library/KeyBindings
# then reboot
```
