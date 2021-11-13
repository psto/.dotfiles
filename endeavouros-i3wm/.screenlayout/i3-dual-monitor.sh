#!/bin/sh
# generated with arandr
# location: ~/.screenlayout/
# include in your ~/.config/i3/config file: exec --no-startup-id ~/.screenlayout/i3-dual-monitors.sh
# if using lightdm and lightdm-gtk-greeter-settings to fix xfce4 login resolution
# cp script to /etc/lightdm/ and make it executable
# change [Seat:*] display-setup-script=/etc/lightdm/i3-dual-monitor.sh
xrandr --output eDP1 --mode 1366x768 --pos 0x672 --rotate normal --output DP1 --off --output HDMI1 --primary --mode 2560x1440 --pos 1366x0 --rotate normal --output HDMI2 --off --output VIRTUAL1 --off
