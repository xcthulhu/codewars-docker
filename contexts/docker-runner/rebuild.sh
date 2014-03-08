#!/bin/bash
if [ "$1" == "--hard" ]; then 
    docker kill controller && docker rm controller
elif [ "$1" == "--all" ]; then 
    docker ps -a | grep noderunner | awk '{print $1}' | xargs docker kill
    docker ps -a | grep noderunner | awk '{print $1}' | xargs docker rm
    docker kill controller && docker rm controller
else
    docker stop controller && docker rm controller
fi
docker rmi codewars:runner
docker build -t="codewars:runner" -rm .
docker run -i -d -p 80:2222 -name="controller" codewars:runner
