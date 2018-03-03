#!/bin/bash


read -e -p "Type profile file path: " -i ~/".custom_profile" profile_file_path

read -e -p "Type default env folder: " -i ~/.env ENV

read -e -p "Type Golang install(GOROOT): " -i $ENV/golang GOROOT

read -e -p "Type Global GOPATH: " -i $ENV/golang_path GOPATH

read -e -p "Type HTTP PROXY: " -i 127.0.0.1:1080 HTTP_PROXY

if [ -f $ENV ]; then
    mkdir $ENV
fi

if [ -f $profile_file_path ]; then
    read -e -p "profile file ${profile_file_path} extists. overwrite it? [y/n]: " overwrite
    if [ "n" == "$overwrite" ]; then
        exit
    fi
else
    touch "$profile_file_path"
fi


cat > $profile_file_path <<EOL 
export GOPATH=${GOPATH}
export PATH=\$PATH:{$GOROOT}/bin:\$GOPATH/bin
export LANG=en_US.UTF-8
ORG_GOPATH=\$GOPATH
ORG_PATH=\$PATH

function enable_proxy() {
	export http_proxy=${http_proxy}
	export https_proxy=${http_proxy}
	curl myip.ipip.net
}

function disable_proxy() {
	export http_proxy=
	export https_proxy=
	curl myip.ipip.net
}

function go_path_set() {
	current_path=\$1
	if [ -z "\$current_path" ]; then
		current_path=\$(pwd)
	fi
	export GOPATH=\$current_path
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

read -e -p "What is your default shell?: 1. bash, 2. zsh : " DEFAULT_SHELL

shell_profile=~/.bash_profile
if [ "2" == "DEFAULT_SHELL" ]; then
    shell_profile=~/.zshrc
fi


grep -F "source $profile_file_path" $shell_profile > /dev/null
not_found=$?
if [ $not_found -eq 1 ]; then
cat >> $shell_profile <<EOL 
	# custom profile
	source $profile_file_path
EOL
	echo "add load script to $shell_profile"
else
	echo "load script already in $shell_profile, auto ignore"
fi

