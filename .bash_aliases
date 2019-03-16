# shortcuts for folders
alias downloads='cd ~/Downloads'
alias work='cd ~/workspace'
alias stojanow='cd ~/workspace/stojanow.com'
alias episteme='cd ~/Dropbox/wiki/episteme'
alias proton='cd ~/snap/protonVPN'
alias protonus='cd ~/snap/protonVPN/ && openvpn us-free-01.protonvpn.com.tcp.ovpn'
alias pomodoro='notify-send "start 🍅" && sleep 25m && mpv --no-video ~/Music/open-ended.mp3 && notify-start "break time 😌" && sleep 5m && notify-send "🚨 end break 🚨" && mpv --no-video ~/Music/open-ended.mp3'

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
alias gk='gitk --all&'
alias gx='gitx --all'

# Easily search running processes
alias 'ps?'='ps ax | grep '

# youtube-dl aliases
# download youtube video as mp3
alias ytmp3='youtube-dl --extract-audio --audio-format mp3  --audio-quality  0' # youtube_link_here
# download video
alias yt='youtube-dl -f 18' # youtube_link_here
# download playlist and preserve list order
alias ytplay='youtube-dl -f 18 -o "%(playlist_index)s-%(title)s.%(ext)s"'
# download videos from a file (one link per line in file).
alias ytfile='youtube-dl -c --title -f 18 --batch-file' # /path/to/file

alias trash='rm -rf ~/.local/share/Trash/*'

# alias for mpv
alias mpvsp='mpv --save-position-on-quit'

# tools
alias journal='cd ~/Dropbox/journal/ && vim $(date +%d.%m.%Y).md'
