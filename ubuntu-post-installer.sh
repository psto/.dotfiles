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
sudo apt-get install -y bat
sudo apt-get install -y cmatrix
sudo apt-get install -y exa
sudo apt-get install -y ffmpeg 
sudo apt-get install -y fish
sudo apt-get install -y git
sudo apt-get install -y htop
sudo apt-get install -y httpie
sudo apt-get install -y kitty
sudo apt-get install -y neofetch
sudo apt-get install -y mpv
sudo apt-get install -y preload
sudo apt-get install -y tlp
sudo apt-get install -y ranger
sudo apt-get install -y silversearcher-ag
sudo apt-get install -y synaptic
sudo apt-get install -y tmux
sudo apt-get install -y unrar
sudo apt-get install -y zathura

# REMOVE some unneeded apps #
sudo apt-get remove gnome-games gnome-games-common empathy

# INSTALL new apps #
sudo apt-get install smbfs nautilus-open-terminal vim mc openvpn geany smplayer minitube firefox-mozilla-build thunderbird-mozilla-build ubuntu-restricted-extras

# INSTALL deb files from directory #
sudo dpkg -i /home/yourname/directory/with/deb/files/*.deb

# Install snap packages
sudo snap install anki-woodrow
sudo snap install brave
sudo snap install chromium
sudo snap install code --classic
sudo snap install espanso --classic
sudo snap install flameshot
sudo snap install ffsend
sudo snap install gallery-dl
sudo snap install gimp
sudo snap install insomnia
sudo snap install keepassxc
sudo snap install mailspring
sudo snap install --edge nvim --classic
sudo snap install signal-desktop
sudo snap install vlc

# Flatpak packages
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.github.alainm23.planner
sudo flatpak install flathub io.freetubeapp.FreeTube
sudo flatpak install flathub md.obsidian.Obsidian
