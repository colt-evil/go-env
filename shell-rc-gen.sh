#!/bin/bash


read -e -p "Type profile file path: " -i ~/".custom_profile" profile_file_path

read -e -p "Type default env folder: " -i ~/.env ENV

read -e -p "Type Golang install(GOROOT): " -i $ENV/golang GOROOT

read -e -p "Type Global GOPATH: " -i $ENV/golang_path GOPATH

read -e -p "Type HTTP PROXY: " -i 127.0.0.1:1080 HTTP_PROXY

if [ -f $ENV ]; then
    mkdir $ENV
fi

# custom env file folder
CUSTOM_ENV=~/.custom_env

if [ ! -d $CUSTOM_ENV ]; then
	mkdir $CUSTOM_ENV
fi

# global settings
cat <<EOL >$CUSTOM_ENV/001-global.sh
export LANG=en_US.UTF-8
export ENV=$ENV
EOL

# proxy settings
cat <<EOL >$CUSTOM_ENV/002-proxy.sh 
function proxy_on() {
	export http_proxy=${HTTP_PROXY}
	export https_proxy=${HTTP_PROXY}
	curl myip.ipip.net
}

function proxy_status {
	curl myip.ipip.net
}

function proxy_off() {
	export http_proxy=
	export https_proxy=
	curl myip.ipip.net
}
EOL

# golang functions
cat <<EOL >$CUSTOM_ENV/003-golang.sh 
export GOROOT=${GOROOT}
export GOPATH=${GOPATH}
export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin
ORG_GOPATH=\$GOPATH
ORG_PATH=\$PATH

function go_path_set() {
	current_path=\$1
	if [ -z "\$current_path" ]; then
		current_path=\$(pwd)
	fi
    read "add_global?Include Global GOPATH? [y/n]: " 
    if [ "\$add_global" = "n" ]; then
        export GOPATH=\$current_path
    else
        export GOPATH=\$GOPATH:\$current_path
    fi
	export PATH=\$PATH:\$GOPATH/bin
	echo "Current GOPATH: \$GOPATH"
}

function go_path_unset() {
	export GOPATH=\$ORG_GOPATH
	export PATH=\$ORG_PATH
	echo "Current GOPATH: \$GOPATH"
}

function go_path_create() {
	read -e -p "please enter path: " go_path
	if [ -d \$go_path ]; then 
		echo "\$go_path exists, should we continue?[y/n]"
		read continue
		if [ "N" == \$continue ]; then
			exit
		fi 
	fi
	if [ !-d \$go_path/src ]; then
		mkdir -p \$go_path/src
	fi
	go_path_set \$go_path
	echo "GOPATH \$go_path created"
}
EOL

cat <<EOL >$CUSTOM_ENV/004-func.sh 
function rpass() {
    length=$1
    if [ -z "$length" ]; then
        length=32
    fi
    < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$length};echo;
}
EOL

read -e -p "What is your default shell?: 1. bash, 2. zsh : " DEFAULT_SHELL

shell_profile=~/.bash_profile
if [ "2" == "$DEFAULT_SHELL" ]; then
    shell_profile=~/.zshrc
fi


grep -F "CUSTOM ENV AUTOLOAD" $shell_profile > /dev/null
not_found=$?
if [ $not_found -eq 1 ]; then
cat >> $shell_profile <<EOL 
# CUSTOM ENV AUTOLOAD START
function load_custom_env() {
	for f in $CUSTOM_ENV/*; do source \$f; done
}
load_custom_env
# CUSTOM ENV AUTOLOAD END
EOL
	echo "add load script to $shell_profile"
else
	echo "load script already in $shell_profile, auto ignore"
fi
