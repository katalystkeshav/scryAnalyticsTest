#!/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

docker --version | grep 'Docker version' &> /dev/null
if [ $? == 0 ] 
then
    echo "docker is already installed"
    docker --version
else
    echo "docker is not installed"
    echo "installing docker 18"
    wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce_18.06.3~ce~3-0~debian_amd64.deb
    dpkg -i docker-ce*.deb
    usermod -aG docker $USER
    echo "docker is intalled now"
    docker --version
    rm -f docker-ce*.deb
fi

docker ps -a | grep 'nginx-latest' &> /dev/null
if [ $? == 0 ] 
then
    echo "nginx-latest container is already present"
else
    echo "nginx-latest container is not present"
    docker pull nginx:latest
    docker run -d -it -p 8000:80 --name nginx-latest nginx:latest
fi

if [ $1 == "start" ]
then
   echo "starting nginx container"
   docker start nginx-latest
   brave-browser --no-sandbox --new-window http://localhost:8000 
elif [ $1 == "stop" ]
then
   echo "stopping nginx container"
   docker stop nginx-latest
else
   echo "argument not found"
fi