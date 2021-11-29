#!/bin/bash
xdg-open "$(rg --no-messages --files ~/Music ~/Series ~/Films ~/Documents ~/pdf \
    ~/Dropbox/ ~/Downloads \
    -g "!{*.srt,*.rar,*.txt,*.zip,*.nfo}" | rofi -threads 0 \
    -theme-str "#window { width: 900;}" \
    -dmenu -sort -sorting-method fzf -i -p "find")"
