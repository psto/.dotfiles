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

# open new journal file with today's date as name
alias journal='cd ~/Dropbox/journal/ && vim $(date +%d.%m.%Y).md'

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

# terminal pomodoro timer
alias pomodoro='notify-send "start 🍅" && sleep 5 && mpv --no-video ~/Music/open-ended.mp3 && notify-send "break time 😌" && sleep 1 && notify-send "🚨 end break 🚨" && mpv --no-video ~/Music/open-ended.mp3'

# connect to proton VPN
alias protonus='cd ~/snap/protonVPN/ && openvpn us-free-01.protonvpn.com.tcp.ovpn'

# SHORTCUTS
alias downloads='cd ~/Downloads'
alias work='cd ~/workspace'
