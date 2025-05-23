#!/usr/bin/env bash
#             _   _     _      _
#  __ _  ___ | |_| |__ | | ___| |_ _   _
# / _` |/ _ \| __| '_ \| |/ _ \ __| | | |
#| (_| | (_) | |_| |_) | |  __/ |_| |_| |
# \__, |\___/ \__|_.__/|_|\___|\__|\__,_|
# |___/
#       https://www.youtube.com/user/gotbletu
#       https://twitter.com/gotbletu
#       https://plus.google.com/+gotbletu
#       https://github.com/gotbletu
#       gotbletu@gmail.com

# info: rofi-surfraw-bookmarks is a script to open your saved surfraw bookmarks with the rofi launcher
# requirements: rofi surfraw
# playlist: rofi      https://www.youtube.com/playlist?list=PLqv94xWU9zZ0LVP1SEFQsLEYjZC_SUB3m
#           surfraw   https://www.youtube.com/playlist?list=PLqv94xWU9zZ2e-lDbmBpdASA6A6JF4Nyz

# set your browser (uncomment if needed, some GUI does not detect browser variable)
# BROWSER=firefox

surfraw "$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | sed '/^#/d' | sed '/^\//d' | sort -n | rofi -config ~/.config/rofi/tokyo_night_transparent.rasi \
 -dmenu -mesg ">>> Edit to add new bookmarks at ~/.config/surfraw/bookmarks" -i -p "rofi-surfraw-bookmarks: ")"
