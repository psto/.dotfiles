fish_vi_key_bindings
set fish_greeting

set -gx DEFAULT_USER $USER

# setup vim mode
set -U EDITOR vim
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

# rbnev PATH
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null 2>&1

# for fzf
set PATH $PATH ~/.fzf/bin

# enbale starship prompt customization for
starship init fish | source
