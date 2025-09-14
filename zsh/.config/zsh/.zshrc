#!/bin/sh
# History options
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY       # append history (no overwriting)
setopt EXTENDED_HISTORY     # record command start time
setopt HIST_FIND_NO_DUPS    # show command once while stepping though history
setopt HIST_IGNORE_DUPS     # don't record an event that was just recorded again
setopt HIST_IGNORE_SPACE    # don't store commands prefixed with a space
setopt HIST_NO_STORE        # don't store history commands
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks from each command line
setopt HIST_SAVE_NO_DUPS    # don't write a duplicate event to the history file
setopt HIST_VERIFY          # don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY   # immediately append to the history file
setopt INC_APPEND_HISTORY_TIME # record command duration
setopt SHARE_HISTORY        # share history across terminals
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

# Completions
fpath=("${ZDOTDIR}"/completion $fpath) # add completions path

# Speed up zsh compinit by only checking cache once a day.
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# Load extra completion modules and options
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
# zsh_add_plugin "zsh-users/zsh-completions"
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#668ac4"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Hooks
add-zsh-hook chpwd status-ls
add-zsh-hook -Uz chpwd osc7 # OSC-7 escape sequence for foot terminal

# Key-bindings
bindkey -s '^x' ' __zoxide_zi^M'
bindkey -a '^[[3~' delete-char # bind delete key
bindkey "^n" up-line-or-beginning-search # Up
bindkey "^p" down-line-or-beginning-search # Down
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
bindkey '^f' autosuggest-accept
bindkey -r "^u"
bindkey -r "^d"
bindkey -r '^G'  # unbind ^G for fzf-git.sh
bindkey "^Y" modified-fzf-history-widget

# FZF
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fnm
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"

# Completion styling
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

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

# z
eval "$(zoxide init --cmd cd zsh)"
eval "$(fasd --init auto)"
unalias sd

# atuin
eval "$(atuin init zsh)"

# starship prompt
eval "$(starship init zsh)"

# fzf-git
source "$HOME/.local/bin/fzf-git.sh"
