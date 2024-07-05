#!/bin/sh
HISTFILE=~/.zsh_history
setopt appendhistory        # append history (no overwriting)
#setopt sharehistory         # share history across terminals
setopt incappendhistory     # immediately append to the history file, not just when a term is killed
setopt HIST_FIND_NO_DUPS    # show command once while stepping though history
# turn off HIST_IGNORE_ALL_DUPS if using ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
# setopt HIST_IGNORE_ALL_DUPS # don't write duplicates to the history file

# some useful options (man zshoptions)
setopt clobber
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
setopt globdots     # show hidden files
setopt auto_cd      # automatically change into a directory without "cd"
setopt noclobber    # prevent redirection (>) to truncate existing files
setopt appendcreate # enable append redirection (>>) on files that don't exist
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

unsetopt BEEP # beeping is annoying
unsetopt nomatch # fix "zsh: no matches found" https://github.com/ohmyzsh/ohmyzsh/issues/31

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
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
add-zsh-hook -Uz chpwd osc7 # OSC-7 escape sequence for foot terminal

# Key-bindings
bindkey -s '^f' 'zi^M'
bindkey -s '^z' 'zi^M'
bindkey -a '^[[3~' delete-char # bind delete key
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

# Speed up zsh compinit by only checking cache once a day.
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-file ~/.config/git/gitignore"
# FZF dracula theme
export FZF_DEFAULT_OPTS="--color=fg:#cfc9c2,hl:#ff9e64 --color=fg+:#cfc9c2,bg+:#24283b,hl+:#ff9e64 --color=info:#7aa2f7,prompt:#2ac3de,pointer:#2ac3de --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
export FZF_DEFAULT_OPTS="--highlight-line --info=inline-right --ansi --layout=reverse --border=none --color=bg+:#283457 --color=bg:#16161e --color=border:#27a1b9 --color=fg:#c0caf5 --color=gutter:#16161e --color=header:#ff9e64 --color=hl+:#2ac3de --color=hl:#2ac3de --color=info:#545c7e --color=marker:#ff007c --color=pointer:#ff007c --color=prompt:#2ac3de --color=query:#c0caf5:regular --color=scrollbar:#27a1b9 --color=separator:#ff9e64 --color=spinner:#ff007c"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {}' --no-height --preview-window=65%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# Speedy keys
xset r rate 210 40

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="kitty"

# bat theme
export BAT_THEME="base16"

# z
eval "$(zoxide init zsh)"

# atuin
eval "$(atuin init zsh)"

# broot init
source /home/piotr/.config/broot/launcher/bash/br
