#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh
export DOTFILES=$HOME/.dotfiles
source "$HOME/.config/zsh/.zshrc"

wayland_vars () {
  export MOZ_ENABLE_WAYLAND=1
  export XDG_SESSION_TYPE=wayland
}

############### sway #################
if [[ -z $DISPLAY ]]  &&  [[ "$(tty)" == "/dev/tty2" ]]; then
  wayland_vars 
  export XDG_CURRENT_DESKTOP=sway
  exec sway 
fi

############### hyprland #################
if [[ -z $DISPLAY ]]  &&  [[ "$(tty)" == "/dev/tty3" ]]; then
  wayland_vars 
  export XDG_CURRENT_DESKTOP=Hyprland
  exec wrappedhl
fi
