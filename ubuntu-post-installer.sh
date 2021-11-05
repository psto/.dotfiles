#!/bin/sh

# sudo chmod +x ~/ubuntu-post-installer.sh
# sudo bash ubuntu-post-installer.sh 

# update & upgrade #
sudo apt-get update
sudo apt-get upgrade -y

# add custom sources and PPA's #
sudo apt-add-repository ppa:fish-shell/release-3

# update & upgrade #
sudo apt-get update
sudo apt-get upgrade -y

# install PPA's
sudo apt-get install -y kitty
sudo apt-get install -y fish
sudo apt-get install -y htop
sudo apt-get install -y neofetch
sudo apt-get install -y zathura

# REMOVE some unneeded apps #
sudo apt-get remove gnome-games gnome-games-common empathy

# INSTALL new apps #
sudo apt-get install smbfs nautilus-open-terminal vim mc openvpn geany smplayer minitube firefox-mozilla-build thunderbird-mozilla-build ubuntu-restricted-extras

# INSTALL deb files from directory #
sudo dpkg -i /home/yourname/directory/with/deb/files/*.deb

# Install snap packages
sudo snap install signal-desktop
sudo snap install vlc
sudo snap install keepassxc
sudo snap install httpie
sudo snap install insomnia
sudo snap install gimp
sudo snap install flameshot
sudo snap install ffsend
sudo snap install brave
sudo snap install chromium
sudo snap install anki-woodrow
sudo snap install espanso --classic
sudo snap install code --classic
sudo snap install --edge nvim --classic

# Flatpak packages
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.github.alainm23.planner
sudo flatpak install flathub io.freetubeapp.FreeTube
