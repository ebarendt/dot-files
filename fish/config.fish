# Fish equivalent of zshrc. Linked to ~/.config/fish/config.fish by mise.
fish_add_path -g /usr/local/bin
test -d /opt/homebrew/opt/libpq/bin; and fish_add_path -g /opt/homebrew/opt/libpq/bin
test -d $HOME/.opencode/bin; and fish_add_path -g $HOME/.opencode/bin
fish_add_path -g $HOME/.local/bin

set -gx EDITOR /usr/bin/vim

status is-interactive; or return

set -g fish_greeting
fish_vi_key_bindings

if type -q starship
    starship init fish | source
end

# File system
if type -q eza
    alias ls 'eza -lh --group-directories-first --icons=auto'
    alias lsa 'ls -a'
    alias lt 'eza --tree --level=2 --long --icons --git'
    alias lta 'lt -a'
end

alias glr 'git pull --rebase'
alias gco 'git co'
alias gpr 'git pull --rebase'
alias gpm 'git push origin master'
alias be 'bundle exec'

# fzf key bindings and completion; use rg for file lists when available
if type -q fzf
    fzf --fish | source
    if type -q rg
        set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow'
    end
end

test -f ~/.config/fish/local.fish; and source ~/.config/fish/local.fish

# adds bin/ (dot) and the mise-managed tools to PATH
if type -q mise
    mise activate fish | source
end
