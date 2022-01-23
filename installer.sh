#!/bin/bash

sudo apt update
sudo apt upgrade -y

# basic
sudo apt install -y \
                    git \
                    htop \
                    vim \
                    ranger \
                    neofetch \
                    tmux

# net 
sudo apt install -y \
                    curl \
                    wget \
                    ssh \
                    telnet \
                    net-tools \
                    nmap

# c dev
sudo apt install -y \
                    build-essential \
                    clang \
                    valgrind \
                    libssl-dev

# ffmpeg + libs
sudo apt install -y \
                    ffmpeg \
                    libavcodec-dev \
                    libavformat-dev \
                    libswscale-dev

# gstreamer + libs
sudo apt install -y \
                    libgstreamer1.0-dev \
                    libgstreamer-plugins-base1.0-dev \
                    libgstreamer-plugins-bad1.0-dev \
                    gstreamer1.0-plugins-base \
                    gstreamer1.0-plugins-good \
                    gstreamer1.0-plugins-bad \
                    gstreamer1.0-plugins-ugly \
                    gstreamer1.0-libav \
                    gstreamer1.0-doc \
                    gstreamer1.0-tools \
                    gstreamer1.0-x \
                    gstreamer1.0-alsa \
                    gstreamer1.0-gl \
                    gstreamer1.0-gtk3 \
                    gstreamer1.0-qt5 \
                    gstreamer1.0-pulseaudio

# docker
if ! command -v docker &> /dev/null; then
    sudo apt install -y \
                    docker \
                    docker.io \
                    docker-compose
    sudo groupadd docker
    sudo gpasswd -a "$USER" docker
    newgrp docker
else
    echo "docker already installed"
fi

# vscode
if ! command -v code &> /dev/null; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code
else
    echo "code already installed"
fi

# kubectl
if ! command -v kubectl &> /dev/null; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
else
    echo "kubectl already installed"
fi

# skaffold
if ! command -v skaffold &> /dev/null; then
    curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
    sudo install skaffold /usr/local/bin/
else
    echo "skaffold already installed"
fi

# rust
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo "rust already installed"
fi

# configuring vim
printf "syntax on
set number
set ruler
set incsearch
set smartcase
set ignorecase
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set autoindent
set mouse=a
set wrap
set nobackup
set noswapfile\n" > ~/.vimrc

# vlc
sudo apt install -y snap
sudo snap install vlc