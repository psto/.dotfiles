function ytplay --description 'alias ytplay=youtube-dl -f 18 -o "%(playlist_index)s-%(title)s.%(ext)s"'
  youtube-dl -f 18 -o "%(playlist_index)s-%(title)s.%(ext)s" $argv;
end
