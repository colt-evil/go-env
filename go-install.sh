#!/bin/bash
echo "Your GOROOT is set to : $GOROOT . continue? [y/n]"
read go
if [ $go != "y" ]; then
    exit 1
fi
SRC=~/Downloads
gobin=$SRC/gobin.tar.gz
if [ ! -f $gobin ]; then 
    wget http://mirrors.ustc.edu.cn/golang/go1.10.linux-amd64.tar.gz -O $SRC/gobin.tar.gz
fi
cd $SRC
if [ ! -d $SRC/go ]; then
    tar zxf gobin.tar.gz -C $SRC
fi
if [ ! -d $GOROOT ]; then
    mkdir -p $GOROOT
fi
cp -r $SRC/go/* $GOROOT/
if [ ! -d $GOPATH ]; then
    mkdir -p $GOPATH
fi
go env
