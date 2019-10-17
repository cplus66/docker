#!/bin/bash -x
# Date: Oct 09, 2019
# Author: cplus.shen
# Description: Docker utilities
# Usage: ./docker { create | exec | start | stop | rm } CONTAIN_NAME
#        ./docker status
#        ./docker install
# OS:
#     ubuntu:latest 18.04 bionic
#                   16.04 xenial
#     centos:latest centos8
#                   centos7
#     debian:latest buster 10 10.1
#                   stretch 9 9.11
#                   jessie  8 8.11
#            

if [ x$OS == "x" ]; then
    OS=ubuntu
fi

case "$1" in
    create)
    docker run --name $2 -d -t ${OS}:latest /bin/bash
    ;;

    exec)
    docker exec -ti $2 /bin/bash
    ;;

    start)
    docker start $2
    ;;

    stop)
    docker stop $2
    ;;

    status)
    docker ps
    ;;

    rm)
    echo "remove container $2"
    read
    docker rm $2
    ;;

    install)
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install docker-ce
    ;;

    clean)
    docker system prune
    ;;

    pull)
    docker pull centos:latest
    docker pull centos:centos8
    docker pull centos:centos7
    docker pull ubuntu:latest
    docker pull ubuntu:18.04
    docker pull ubuntu:16.04
    docker pull ubuntu:14.04
    ;;

    *)
    docker ps
    ;;

esac
