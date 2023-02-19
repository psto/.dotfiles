# ALIASES
alias sudo='doas'
alias sudoedit='doas $EDITOR'
alias doasedit='doas $EDITOR'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# manage packages
alias agi='doas apt-get install'
alias agr='doas apt-get remove'
alias agu='doas apt-get update'

# git aliases
alias g='lazygit'
alias gs="git status -sb"
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
alias gp="git push"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
# "git lg" alias for pretty git log - set and forget
# git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias gl="git lg"
alias gcan="git commit --amend --no-edit"

# use neovim
alias vim='nvim'
alias v='nvim'

# use trash-put instead of rm
alias rm='trash-put'

# open vifm
alias vf='vifm'

# ag searcher colors
alias ag="ag --color-path 35 --color-match '1;35' --color-line-number 32"

# use python3 by default
alias python=python3

# for fzf
export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.agignore --nocolor --hidden -g ""'
export FZF_CTRL_T_COMMAND='ag -l --path-to-ignore ~/.agignore --nocolor --hidden -g ""'

# fuck alias
eval $(thefuck --alias fu)

# open new journal file with today's date as name
alias journal='cd ~/Dropbox/journal/ && vim $(date +%d.%m.%Y).md'

# Easily search running processes
alias 'psf'='ps ax | grep '

# youtube-dl aliases
# download youtube video as mp3
alias ytmp3='youtube-dl --extract-audio --audio-format mp3  --audio-quality  0' # youtube_link_here
# download video
alias yt='youtube-dl -f 18' # youtube_link_here
# download playlist and preserve list order
alias ytplay='youtube-dl -f 18 -o "%(playlist_index)s-%(title)s.%(ext)s"'
# download videos from a file (one link per line in file).
alias ytfile='youtube-dl -c --title -f 18 --batch-file' # /path/to/file

# play audio with mpv and remember last played position
alias mpvsp='mpv --save-position-on-quit'

# make offline mirror of a site using `wget`
alias wgets='wget --mirror --convert-links --adjust-extension --page-requisites --no-parent'

# terminal pomodoro timer
alias pomodoro='notify-send "start 🍅" && sleep 5 && mpv --no-video ~/Music/open-ended.mp3 && notify-send "break time 😌" && sleep 1 && notify-send "🚨 end break 🚨" && mpv --no-video ~/Music/open-ended.mp3'

# protonvpn-cli
alias p='doas protonvpn'
# protonvpn-cli disconnect
alias pd="protonvpn-cli d"

# ranger 
alias r='ranger'
# translate-shell
alias t='trans'
