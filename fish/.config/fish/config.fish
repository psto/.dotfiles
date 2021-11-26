set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_visual block
set fish_greeting ""

set -gx DEFAULT_USER $USER

# setup vim mode
set -U EDITOR vim
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
fish_vi_key_bindings

set -gx DOTFILES ~/.dotfiles

# rbnev PATH
status --is-interactive; and source (rbenv init -|psub)

# nvm
set --universal nvm_default_version v16.13.0

# async git prompt
set -g async_prompt_functions _pure_prompt_git

# for fzf
set PATH $PATH ~/.fzf/bin
# thefuck
thefuck --alias | source
# enbale starship prompt customization for
# starship init fish | source

