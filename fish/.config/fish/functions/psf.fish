function psf --description 'ps -C $argv -o comm,%cpu,%mem,pid --sort=-%cpu'
    ps -C $argv -o comm,%cpu,%mem,pid --sort=-%cpu
end
