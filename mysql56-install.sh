#!/bin/bash
sudo apt install libaio1
mkdir ~/Downloads/mysql-5.6
cd ~/Downloads/mysql-5.6
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.6/libmysqlclient-dev_5.6.39-1ubuntu14.04_amd64.deb
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.6/libmysqld-dev_5.6.39-1ubuntu14.04_amd64.deb
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.6/mysql-client_5.6.39-1ubuntu14.04_amd64.deb
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.6/mysql-common_5.6.39-1ubuntu14.04_amd64.deb
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.6/mysql-server_5.6.39-1ubuntu14.04_amd64.deb
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.6/libmysqlclient18_5.6.39-1ubuntu14.04_amd64.deb
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.6/mysql-community-server_5.6.39-1ubuntu14.04_amd64.deb
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.6/mysql-community-client_5.6.39-1ubuntu14.04_amd64.deb
sudo dpkg -i *.deb