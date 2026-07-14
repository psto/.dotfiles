# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History
export HISTSIZE=1000000
export HISTFILESIZE=2000000
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='ls:ll:la:l:lt:lz:lt:cd:pwd:exit:clear:c:..:tree:df:du:free'
export LESSHISTFILE=-

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar # enable ** pattern

# Disable ctrl-s to freeze terminal
stty stop undef

# Prevent redirection (>) from truncating existing files
set -o noclobber

# Environment
export EDITOR="nvim"
export BROWSER="brave-beta"
export DOTFILES="$HOME/.dotfiles"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export BAT_THEME="Dracula"

# local bin
export PATH="$HOME/.local/bin":$PATH

# npm
export PATH="$XDG_DATA_HOME/npm/bin:$PATH"

# fnm for node.js
eval "$(fnm env --use-on-cd)"

# Ruby / rbenv
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
export PATH="$RBENV_ROOT/plugins/ruby-build/bin:$PATH"
export GEM_HOME="$XDG_DATA_HOME/gems"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gems"
export PATH="$GEM_HOME/bin:$PATH"

# cargo
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"

# go
export GOPATH="$HOME/.local/share/go"
export PATH="$GOPATH/bin:$PATH"

# deno
export PATH="$XDG_DATA_HOME/deno/bin:$PATH"

# bun
export BUN_INSTALL="$XDG_DATA_HOME/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# FZF
export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-file ~/.config/git/gitignore"
export FZF_DEFAULT_OPTS="--highlight-line --info=inline-right --ansi --layout=reverse --border=none --color=bg+:#283457 --color=bg:#16161e --color=border:#27a1b9 --color=fg:#c0caf5 --color=gutter:#16161e --color=header:#ff9e64 --color=hl+:#2ac3de --color=hl:#2ac3de --color=info:#545c7e --color=marker:#ff007c --color=pointer:#ff007c --color=prompt:#2ac3de --color=query:#c0caf5:regular --color=scrollbar:#27a1b9 --color=separator:#ff9e64 --color=spinner:#ff007c"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {}' --no-height --preview-window=65% --bind 'ctrl-o:execute(xdg-open {})' --bind 'ctrl-e:execute(nvim {})' --bind 'ctrl-a:select-all' --bind 'ctrl-c:deselect-all'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--bind 'enter:accept-or-print-query' --header 'enter select' --prompt ' History > '"

# fzf completions and key-bindings
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Zoxide
eval "$(zoxide init bash)"

# Atuin
eval "$(atuin init bash)"

# Fasd
eval "$(fasd --init posix)"
unalias sd 2>/dev/null

# fzf-git
[ -f "$HOME/.local/bin/fzf-git.sh" ] && source "$HOME/.local/bin/fzf-git.sh"

# Starship prompt
eval "$(starship init bash)"

# Colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# ls with colors
alias ls='ls -F --color=auto'

# Functions

# mkdir && cd
function mkcd() { mkdir -p "$1" && cd "$1"; }

# go up N directories
function up() {
  local n="${1:-1}"
  local path=""
  for ((i=0; i<n; i++)); do
    path="../$path"
  done
  cd "$path"
}

# move the latest downloaded file to current path
function mv-download() {
  local fname fpath
  fname="$(ls -t ~/downloads | head -1)"
  fpath="$HOME/downloads/$fname"
  mv "$fpath" .
  echo "Moved $fname to $(pwd)"
}

# copy the latest downloaded file to current path
function cp-download() {
  local fname fpath
  fname="$(ls -t ~/downloads | head -1)"
  fpath="$HOME/downloads/$fname"
  cp -a "$fpath" .
  echo "Copied $fname to $(pwd)"
}

# open the latest downloaded file
function open-download() {
  local fname fpath
  fname="$(ls -t ~/downloads | head -1)"
  fpath="$HOME/downloads/$fname"
  xdg-open "$fpath"
}

# fzf cd
function fcd() {
  local dir
  while true; do
    dir="$(ls -a1F | grep '[/@]$' | grep -v '^\./$' | sed 's/@$//' | fzf --height 40% --reverse --no-multi --preview 'pwd' --preview-window=up,1,border-none --no-info)"
    [[ -z "$dir" ]] && break
    [[ -d "$dir" ]] && cd "$dir"
  done
}

# show git status or ls on directory change
function status-ls() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git status -sb
  else
    eza
  fi
}

# ripgrep-all with fzf
function rga-fzf() {
  local RG_PREFIX="rga --hidden --files-with-matches"
  local file
  file="$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
      fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
          --phony -q "$1" \
          --bind "change:reload:$RG_PREFIX {q}" \
          --preview-window="70%:wrap"
  )" && echo "opening $file" && launch "$file"
}

# preview SVG drawings with chafa
function preview-drawings() {
  fd --type f --extension svg --exclude 'Archives/Other/Excalidraw/' | \
    fzf --preview 'chafa -f sixels {}' \
        --preview-window 'down:90%' \
        --bind 'enter:execute(imv {}),ctrl-/:change-preview-window(down,90%,border-horizontal|hidden|right)'
}

# review changed files on this branch
function review_changes() {
  local base_branch="${1:-}"
  if [ -z "$base_branch" ]; then
    base_branch="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')"
    [ -z "$base_branch" ] && base_branch="main"
  fi
  git diff --name-only "$base_branch"...HEAD | \
    fzf --preview "git diff $base_branch...HEAD -- {} | delta --width \$FZF_PREVIEW_COLUMNS" \
        --bind "enter:execute($EDITOR {})"
}

# show staged and unstaged file changes
function changed_files() {
  git status --short | awk '{print $2}' | \
    fzf --preview "git diff --cached -- {} | delta --width \$FZF_PREVIEW_COLUMNS && git diff -- {} | delta --width \$FZF_PREVIEW_COLUMNS" \
        --bind "enter:execute($EDITOR {})"
}

# Show diff for argument PR number
function pr_diff() {
  gh pr diff "$1" | delta
}

# Show PR files for argument PR number
function pr_files() {
  gh pr diff "$1" --name-only | \
    fzf --bind "enter:execute($EDITOR {})"
}

# Automatically pipe llm output to rendermd.py when run interactively
function llmr() {
  if [[ -t 1 ]]; then
    command llm "$@" | rendermd.py
  else
    command llm "$@"
  fi
}

# turn string into kebab case
function kebab() {
  echo "$*" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | tee >(wl-copy -n)
}

# Search for content & copy path
function rgpath() {
  rg -l "$@" | fzf | xargs -0 realpath | wl-copy
}

# Get all URLs from HTML
function get-urls() {
  if [ -z "$1" ]; then
    echo "Usage: get-urls <url>"
    return 1
  fi
  curl -sL "$1" | htmlq --attribute href a
}

# cheat.sh
function cheat() { curl "http://cheat.sh/$1"; }

# OSC-7 escape sequence for foot terminal (spawn new terminal in same CWD)
function osc7() {
  local input="$PWD"
  local uri=""
  local i c hex
  for ((i=0; i<${#input}; i++)); do
    c="${input:$i:1}"
    case "$c" in
      [-_.~a-zA-Z0-9/]) uri+="$c" ;;
      *) printf -v hex '%02X' "'$c"; uri+="%$hex" ;;
    esac
  done
  printf "\e]7;file://%s%s\e\\" "${HOSTNAME}" "${uri}"
}

# Select a task and set a due time for today
function ttime() {
  local task_id=$(task status:pending export | jq -r '.[] | "\(.id) [\(.project)] \(.description)"' | fzf --reverse --header "Set time for today (HH:MM)")
  if [[ -n "$task_id" ]]; then
    echo -n "Enter time (e.g., 14:00): "
    read -r task_time
    local today=$(date +%Y-%m-%d)
    local id="${task_id%% *}"
    task "$id" modify due:"${today}T${task_time}"
  fi
}

# Annotate a task
function tann() {
  local task_id=$(task status:pending export | jq -r '.[] | "\(.id) \(.description)"' | fzf --reverse --header "Add note/annotation")
  if [[ -n "$task_id" ]]; then
    echo -n "Annotation: "
    read -r note
    task ${task_id%% *} annotate "$note"
  fi
}

# Log to both Taskwarrior and Timewarrior simultaneously
function tt_log() {
  if [[ $# -lt 3 ]]; then
    echo "Usage: tt_log \"Task Description\" START_TIME END_TIME"
    echo "Example: tt_log \"work on project X\" 08:00 16:00"
    return 1
  fi
  local desc="$1"
  local start_time="$2"
  local end_time="$3"
  local today=$(date +%Y-%m-%d)
  echo "Logging to Taskwarrior..."
  task log "${desc}" entry:"${today}T${start_time}:00" end:"${today}T${end_time}:00"
  echo "Logging to Timewarrior..."
  timew track "${start_time}" - "${end_time}" "${desc}"
}

# Fix the end time of a task in both Taskwarrior and Timewarrior
function tt_fix() {
  if [[ $# -lt 2 ]]; then
    echo "Usage:   tt_fix <task_id> <correct_end_time>"
    echo "Example: tt_fix 141 21:00"
    return 1
  fi
  local task_id="$1"
  local end_input="$2"
  local full_end_iso=""
  local desc=$(task _get "${task_id}.description" 2>/dev/null)
  local entry_raw=$(task _get "${task_id}.entry" 2>/dev/null)
  if [[ -z "$desc" ]]; then
    echo "Error: Task $task_id not found."
    return 1
  fi
  if [[ "$end_input" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T ]]; then
    full_end_iso="$end_input"
  else
    local start_date="${entry_raw%%T*}"
    full_end_iso="${start_date}T${end_input}:00"
  fi
  echo "Stopping & completing Taskwarrior task $task_id at $full_end_iso..."
  task "${task_id}" modify status:completed end:"${full_end_iso}"
  echo "Adjusting Timewarrior tracking..."
  if timew | grep -q "Tracking"; then
    timew stop "${full_end_iso}"
  else
    local timew_id=$(timew summary :ids | grep "${desc}" | tail -1 | awk '{print $1}')
    if [[ -n "$timew_id" ]]; then
      echo "Adjusting interval ${timew_id} matching '$desc'..."
      timew modify end "${timew_id}" "${full_end_iso}"
    else
      echo "Warning: Could not find a matching Timewarrior interval. Adjusting @1 as fallback."
      timew modify end @1 "${full_end_iso}"
    fi
  fi
}

# Hooks & prompt command

# chpwd hook — show git status or ls on directory change, and emit OSC-7
__bash_last_dir=""
__bash_chpwd() {
  if [[ "$PWD" != "$__bash_last_dir" ]]; then
    __bash_last_dir="$PWD"
    status-ls
    osc7
  fi
}

# immediate history sharing + chpwd hook
PROMPT_COMMAND="__bash_chpwd; history -n; history -w; history -c; history -r"

# Keybindings
# vi mode
set -o vi

# Ctrl+L to clear screen in vi insert mode
bind -m vi-insert "\C-l":clear-screen

# History search
bind '"\C-n": history-search-backward'
bind '"\C-p": history-search-forward'
bind '"\C-k": history-search-backward'
bind '"\C-j": history-search-forward'

# Delete key
bind '"\e[3~": delete-char'

# Ctrl+X — zoxide zi (interactive cd)
bind '"\C-x": " __zoxide_zi\C-m"'

# Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
