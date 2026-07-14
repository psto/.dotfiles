# Sudo / doas
alias sudo='doas'
alias sudoedit='doas nvim -u NONE'
alias doasedit='doas nvim -u NONE'

# Edit history file
alias hed='nvim + "$HISTFILE"'

# Neovim
alias nvimrc='nvim ~/.config/nvim/'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Pacman / Mirror
alias mirror="doas reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="doas reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="doas reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="doas reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
alias mirrorf="doas reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist"

# Paru / Pacman helpers
alias p="pacnews --lookup --sort asc && paru"
alias rmparu='DPC="$HOME/.cache/paru/clone"; output=$(dua "$DPC" 2>/dev/null); [ -n "$output" ] && { echo "$output"; trashy put "$DPC"/*; } || echo "No cache"'
alias pacmani="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro doas pacman -S"
alias parui="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S"
alias pacmanrm="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro doas pacman -Rns"
alias parurm="paru -Qq | fzf --multi --preview 'paru -Qi {1}' | xargs -ro paru -Rns"
alias prm="yes | paru -Scc && rmparu"
alias archlinux-fix-keys="doas pacman-key --init && doas pacman-key --populate archlinux && doas pacman-key --refresh-keys"

# System

# confirm before overwriting something
alias cp="cp -riv"
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -pv'

# Trashy
alias rmt="trashy put"
alias rml="trashy list"
alias rmr="trashy restore"
alias rme="trashy empty --all"

# easier to read disk
alias free='free -m'
alias df='df -h'
alias du='du -sh'
alias ncdu='ncdu --color dark'

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# Easily search running processes
alias psf='ps -Ao comm,pcpu,pmem,pid --sort=-pcpu | grep '

# Colorize grep output (good for log files)
alias grep='grep --color=auto'

# GPG
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

# WiFi signal strength
alias wifisignal='watch -n1 nmcli device wifi'

# ADB
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# Wget with XDG hsts file
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

# ls / eza
alias ls='ls -F --color=auto'
alias l='eza -l --icons'
alias la='eza -a --icons'
alias ll='eza -al --group-directories-first'
alias lt='eza -al --sort=modified'
alias lz='eza -alFr --color=always --sort=size | grep -v /'
alias lgs='eza --long --git --icons'

# Git
alias g='lazygit'
alias lg='lazygit'
alias gs="git status -sb ."
alias gst="git status -sb"
alias ga="git add"
alias gap="git add --patch"
alias gb="git branch"
alias gba="git branch --all"
alias gbd="git branch -D"
alias gc="git commit"
alias gco="git checkout"
alias gcb="git branch | fzf | xargs git checkout"
alias gcl="git clone"
alias gcp="git cherry-pick"
alias gd="git diff -w"
alias gdw="git diff-words"
alias gds="git diff --staged"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpl="git pull"
alias gpr="git pull --rebase"
alias gr="git restore"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gri="git rebase -i --committer-date-is-author-date"
alias grf="git reflog --date=iso"
# "git lg" alias for pretty git log — set with: git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias gl="git lg"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gw="git worktree"
alias gwa="git worktree add"
alias gwl="git worktree list"
alias gwr="git worktree remove"
alias gh-create-private='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'
alias gh-create-public='gh repo create --public --source=. --remote=origin && git push -u --all && gh browse'

# jj
alias jjd="jj diff -a"
alias jjdd='jj diff --stat'
alias jjrg="rg --no-require-git"
alias jjs="jj status"

# FZF
alias e='fzf -m --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all --print0 --preview "bat --theme Dracula --color=always {}" | xargs -0 -o $EDITOR'

# find and copy full path
alias cppath="fd . | fzf | xargs -0 realpath | wl-copy"
# recent files copy path
alias cprecent="fd . -t f --changed-within 1d | fzf | wl-copy"

alias open="xdg-open"
alias c='clear'

# CLI tools
alias x="xplr"
alias na="navi --print"
alias n="navi"
alias drag='dragon-drop "$(fzf)"'
alias mpvsp='mpv --save-position-on-quit'
alias asr="atuin scripts run"
alias fabric="fabric-ai"
alias ncuu="ncu -ug | tail -2 | xargs -I '{}' sh -c 'echo \"executing: {}\" && {}'"

# Weather
alias wttr="curl wttr.in/$HOMETOWN"

# i2pd webconsole
alias i2pds="curl --silent http://localhost:7070 | htmlq --text .content | sed -n '1,5p; 27,28p;' | glow"

# yt-dlp
alias ytd="yt-dlp -S res,ext:mp4:m4a --recode mp4"
alias ytd-subs='yt-dlp --write-auto-sub --sub-lang "en.*" --convert-subs=srt --skip-download $video_url'

# Translate
alias trpl="trans :pl"
alias tren="trans pl:en"

# Taskwarrior
alias t="task"
alias ta="task add"
alias tday="task list due:today"
alias tdel="task delete"
alias tdone="task completed end:today"
alias tnext="task next"
alias tpurge="task-purge"
alias tsoon="task due.before:today+2d list"
alias tsum="task summary"
alias tt="taskwarrior-tui"
alias ttop="task top"
alias tsync="task sync"
alias twait="task waiting"
alias twgsync='tw_gtasks_sync -p personal -l "TODO"'

# Transmission
alias tsm="transmission-remote"

# GTasks
alias gt="gtasks"
alias gtv="gtasks tasks -l TODO view"
alias gtd="gtasks tasks -l TODO done "
alias gta="gtasks tasks -l TODO add"
alias gtrm="gtasks tasks -l TODO rm"

# upgrade / cache
alias upgrade-all="paru; ncuu; uv tool upgrade --all; cargo install-update -a"
alias cacherm="uv cache clean; npm cache clean --force; cargo cache --autoclean; go clean -cache; prm"

# Fasd
alias m='f -e mpv'
alias o='a -e xdg-open'

# Zenta
alias breath='zenta now --quick'
alias breathe='zenta now'
alias reflect='zenta reflect'

# Notmuch
alias notmuchrm="notmuch search --format=text0 --output=files tag:trash | xargs -0 --no-run-if-empty rm -v"

# Alert for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# use python3 by default
alias python=python3
