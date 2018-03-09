#!/bin/bash
sudo apt install git subversion supervisor shadowsocks polipo lrzsz unzip curl wget tmux dnsmasq vim curl wget zsh autoconf
sudo apt install mysql-server redis-server memcached nginx

sudo systemctl enable mysql
sudo systemctl enable redis-server
sudo systemctl enable memcached

git config --global core.editor "vim"

git clone https://github.com/colt-evil/vim.git ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc


sudo apt -y install build-essential
sudo apt -y install libxml2-dev libcurl4-openssl-dev pkg-config libssl-dev libsslcommon2-dev libbz2-dev libjpeg-dev libpng12-dev libfreetype6-dev libmcrypt-dev libmemcached-dev
