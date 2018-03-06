#!/bin/bash
wget https://github.com/nathco/Office-Code-Pro/archive/master.zip -P ~/Downloads
cd ~/Downloads
unzip master.zip
sudo mkdir /usr/share/fonts/office-code-pro
sudo cp Office-Code-Pro-master/Fonts/Office Code Pro/TTF/* /usr/share/fonts/office-code-pro
echo 'done'
