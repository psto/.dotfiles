# ALIASES

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# manage packages
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update'

# git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '

# use neovim
alias vim='nvim'
alias v='nvim'
# open neovim config
alias vimconfig='vim ~/.config/nvim/init.vim'

# ag searcher colors
alias ag="ag --color-path 35 --color-match '1;35' --color-line-number 32"

# use python3 by default
alias python=python3

# fuck alias
eval "$(thefuck --alias f)"

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

# SHORTCUTS
alias cdd='cd ~/Documents'
alias cddo='cd ~/Downloads'
alias cdm='cda ~/Music'
alias cdv='cd ~/Videos'
alias cdw='cd ~/workspace'
alias stojanow='cd ~/workspace/stojanow.com'
alias episteme='cd ~/workspace/episteme'

# protonvpn-cli
alias p='sudo protonvpn'
# ranger 
alias r='ranger'
# translate-shell
alias t='trans'
