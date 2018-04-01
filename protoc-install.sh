#!/bin/bash
ENV_CONFIG=~/.custom_env/001-global.sh
if [ ! -f $ENV_CONFIG ]; then
    echo "custon env files not found. please run shell-rc-gen.sh to create them."
    exit
fi

source $ENV_CONFIG


INSTALL_PATH=$ENV/protoc
VERSION=3.5.1
if [ ! -d $INSTALL_PATH ]; then
    mkdir $INSTALL_PATH
else
    read "reinstall? $INSTALL_PATH exists. reinstall? [y/n]"
    if [ "\$reinstall" = "n" ]; then
        exit 0
    fi
    rm -rf $INSTALL_PATH/*
fi
cd $INSTALL_PATH
if [ ! -f protoc-$VERSION-linux-x86_64.zip ];then
wget https://github.com/google/protobuf/releases/download/v$VERSION/protoc-$VERSION-linux-x86_64.zip
fi
unzip protoc-$VERSION-linux-x86_64.zip
#rm protoc-$VERSION-linux-x86_64.zip

ENV_FILE=~/.custom_env/004-protoc.sh
cat <<EOF >$ENV_FILE
export PATH=\$PATH:$INSTALL_PATH/bin
EOF
source $ENV_FILE
echo "install complete!"