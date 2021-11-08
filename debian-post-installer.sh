#!/bin/sh

# sudo chmod +x ~/ubuntu-post-installer.sh
# sudo bash ubuntu-post-installer.sh 

# update & upgrade #
sudo apt-get update
sudo apt-get upgrade -y

# add custom sources and PPA's #
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo add-apt-repository -y ppa:neovim-ppa/unstable

# update & upgrade #
sudo apt-get update
sudo apt-get upgrade -y

# install PPA's #
sudo apt install -y bat
sudo apt install -y cmatrix
sudo apt install -y exa
sudo apt install -y ffmpeg 
sudo apt install -y fish
sudo apt install -y flatpak
sudo apt install -y git
sudo apt install -y htop
sudo apt install -y httpie
sudo apt install -y kitty
sudo apt install -y neofetch
sudo apt install -y mpv
sudo apt install -y neovim
sudo apt install -y preload
sudo apt install -y tlp
sudo apt install -y ranger
sudo apt install -y silversearcher-ag
sudo apt install -y synaptic
sudo apt install -y tmux
sudo apt install -y unrar
sudo apt install -y zathura

# REMOVE some unneeded apps #
sudo apt-get remove gnome-games gnome-games-common empathy

# INSTALL new apps #
sudo apt install smbfs nautilus-open-terminal mc openvpn geany smplayer minitube ubuntu-restricted-extras

# INSTALL dev dependencies #
sudo apt-get install python-dev python-pip python3-dev python3-pip

# Flatpak packages #
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub net.ankiweb.Anki
# sudo flatpak install -y flathub org.chromium.Chromium
sudo flatpak install -y flathub com.github.Eloston.UngoogledChromium
sudo flatpak install -y flathub org.flameshot.Flameshot
sudo flatpak install -y flathub io.freetubeapp.FreeTube
sudo flatpak install -y flathub org.gimp.GIMP
sudo flatpak install -y flathub rest.insomnia.Insomnia
sudo flatpak install -y flathub org.keepassxc.KeePassXC
sudo flatpak install -y flathub org.libreoffice.LibreOffice
sudo flatpak install -y flathub com.getmailspring.Mailspring
sudo flatpak install -y flathub md.obsidian.Obsidian
sudo flatpak install -y flathub com.github.alainm23.planner
sudo flatpak install -y flathub org.qbittorrent.qBittorrent
sudo flatpak install -y flathub org.signal.Signal
sudo flatpak install -y flathub org.videolan.VLC
sudo flatpak install -y flathub com.visualstudio.code
sudo flatpak install -y flathub com.vscodium.codium
sudo flatpak install -y flathub us.zoom.Zoom

# get espanso .deb #
wget https://github.com/federico-terzi/espanso/releases/download/v0.7.3/espanso-debian-amd64.deb
sudo apt install ./espanso-debian-amd64.deb
# install brave beta channel #
sudo apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-beta-archive-keyring.gpg https://brave-browser-apt-beta.s3.brave.com/brave-browser-beta-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-beta-archive-keyring.gpg arch=amd64] https://brave-browser-apt-beta.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-beta.list
sudo apt update
sudo apt install brave-browser-beta

# INSTALL deb files from directory #
# sudo dpkg -i /home/yourname/directory/with/deb/files/*.deb

# other #
# ffsend
# gallery-dl
# ProtonVPN
# npm install -g tldr
# npm install -g how-2
# sudo -H pip install --upgrade youtube-dl
