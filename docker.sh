#!/bin/bash
# Date: Oct 09, 2019
# Author: cplus.shen
# Description: Docker utilities
# Usage: ./docker { create | exec | start | stop | rm } CONTAIN_NAME
#        ./docker status
#        ./docker clean
#        ./docker pull
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
# Naming:
#     IMAGE:   name:version
#     NAMES:   project name
#     Example, IMAGE: ubuntu:latest, NAME: project-name-container-number
#

if [ x$OS == "x" ]; then
    OS=ubuntu
fi

case "$1" in
    create)
    docker run --name $2 -d -t ${OS}:latest /bin/bash
    ;;

    ssh)
    docker run -d -P --name $2 cplus/openssh-server:0.1
    ;;

    ssh-u16)
    if [ $# -ne 3 ]; then
      echo "Usage: $0 ssh-u16 <CONTAINER_NAME> <SSH_PORT>"
      exit 1
    fi
    docker run -d -P --name $2 -p $3:22 cplus/openssh-server-ubuntu-16:0.1
    ;;

    exec)
    docker exec -ti $2 /bin/bash
    ;;

    attach)
    docker attach $2 # name
    ;;

    start)
    docker start $2
    ;;

    stop)
    docker stop $2
    ;;

    rm)
    echo "remove container $2"
    read
    docker rm $2
    ;;

    status)
    docker ps
    ;;

    install)
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo newgrp - docker
    sudo usermod -aG docker $USER
    sudo usermod -aG docker root
    sudo gpasswd -a $USER docker
    sudo gpasswd -a root docker
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

    build-image)
    docker build -t $2 .
    ;;

    *)
    echo -e "Usage: $0 { create | exec | start | stop | attach | rm } CONTAIN_NAME\n\
       $0 status\n\
       $0 install\n\
       $0 clean\n\
       $0 pull"
    ;;

esac
