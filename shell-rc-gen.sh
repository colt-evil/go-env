#!/bin/bash


read -e -p "Type profile file path: " -i ~/".custom_profile" profile_file_path

echo $profile_file_path
echo ${#profile_file_path}  

read -e -p "Type default env folder: " -i ~/.env ENV

read -e -p "Type Golang install(GOROOT): " -i $ENV/golang GOROOT

read -e -p "Type Global GOPATH: " -i $ENV/golang_path GOPATH

read -e -p "Type HTTP PROXY: " -i 127.0.0.1:1080 HTTP_PROXY

if [ -f $ENV ]; then
    mkdir $ENV
fi

if [ -f $profile_file_path ]; then
    read -e -p "profile file ${profile_file_path} extists. overwrite it? [Y/N]" -i "N" overwrite
    if [ "N" == "$overwrite" ]; then
        exit
    fi
else
    touch "$profile_file_path"
fi


cat > $profile_file_path <<EOL 
export GOPATH=${go_path}
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

function set_go_path() {
	current_path=$(pwd)
	export GOPATH=$current_path
	export PATH=$PATH:$GOPATH/bin
	echo "Current GOPATH: $GOPATH"
}

function unset_go_path() {
	current_path=$(pwd)
	export GOPATH=$ORG_GOPATH
	export PATH=$ORG_PATH
	echo "Current GOPATH: $GOPATH"
}
EOL

read -e -p "What is your default shell?: 1. bash, 2. zsh :" -i "1" DEFAULT_SHELL

shell_profile=~/.bash_profile
if [ "2" == "DEFAULT_SHELL" ]; then
    shell_profile=~/.zshrc
fi

echo "Writing load script to $shell_profile"

cat >> $shell_profile <<EOL 
    # custom profile
    source $profile_file_path
EOL