#!/bin/sh
# export ZDOTDIR=$HOME/.config/zsh
# export DOTFILES=$HOME/.dotfiles

HISTFILE=~/.zsh_history
setopt appendhistory        # append history (no overwriting)
#setopt sharehistory         # share history across terminals
setopt incappendhistory     # immediately append to the history file, not just when a term is killed
setopt HIST_FIND_NO_DUPS    # show command once while stepping though history
setopt HIST_IGNORE_ALL_DUPS # don't write duplicates to the history file

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
setopt globdots     # show hidden files
setopt auto_cd      # automatically change into a directory without "cd"
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP
# fix "zsh: no matches found" https://github.com/ohmyzsh/ohmyzsh/issues/31
unsetopt nomatch

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "Aloxaf/fzf-tab" # must be before zsh-autosuggestions & fast-syntax-highlighting
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#668ac4"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Hooks
add-zsh-hook chpwd do-ls
add-zsh-hook chpwd precmd

# Key-bindings
bindkey -s '^f' 'zi^M'
bindkey -s '^e' 'nvim $(fzf)^M'
bindkey -s '^z' 'zi^M'
bindkey "^n" up-line-or-beginning-search # Up
bindkey "^p" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
bindkey -r "^u"
bindkey -r "^d"

# FZF 
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"

export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.config/git/gitignore_global --nocolor --hidden -g ""'
export FZF_CTRL_T_COMMAND='ag -l --path-to-ignore ~/.config/git/gitignore_global --nocolor --hidden -g ""'
# FZF dracula theme
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
# export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# Speedy keys
xset r rate 210 40

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave-beta"

# bat theme
export BAT_THEME="Dracula"

# eval "$(starship init zsh)"

# thefuck init
eval $(thefuck --alias fu)

# mcfly init
eval "$(mcfly init zsh)"

# broot init
source /home/piotr/.config/broot/launcher/bash/br
