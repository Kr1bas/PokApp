#!/bin/zsh

flutter build web
rm -rf ./archive
mkdir archive
cp -R ./build/web ./archive/src
cp -R ./kube-manifest ./archive/kube-manifest
cp ./Dockerfile ./archive
