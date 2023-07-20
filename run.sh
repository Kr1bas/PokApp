#!/bin/zsh

flutter build web
docker image rm pokapp
docker build -t pokapp .
docker container rm pokapp-web
docker run --name pokapp-web -p 8080:80 pokapp