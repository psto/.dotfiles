set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_visual block
set fish_greeting ""

set -gx DEFAULT_USER $USER

# setup vim mode
set -U EDITOR vim

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cn forward-char
    end
end
fish_vi_key_bindings
fish_user_key_bindings

set -gx DOTFILES ~/.dotfiles

# rbnev PATH
set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
status --is-interactive; and rbenv init - fish | source

# fnm for node.js
fnm env --use-on-cd | source

# async git prompt
# set -g async_prompt_functions _pure_prompt_git

# for fzf
set PATH $PATH ~/.fzf/bin
set -gx FZF_DEFAULT_COMMAND 'ag -l --path-to-ignore ~/.agignore --nocolor --hidden -g ""'
# for jethrokuan/fzf plugin
set -gx FZF_FIND_FILE_COMMAND 'ag -l --path-to-ignore ~/.agignore --nocolor --hidden -g ""'
# enbale starship prompt customization for
starship init fish | source

