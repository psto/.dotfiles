function psf --description 'alias psf=ps ax | grep '
  ps aux | grep $argv
end
