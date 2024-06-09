#!/bin/bash

if [ ! -x "$(command -v docker)" ]
then
    echo ""
    echo "Please install docker, follow instructions for your Distribution: https://docs.docker.com/engine/install"
    echo ""
    return 1
fi
docker build --progress=plain -t debian ./
docker run -it --rm -p 80:80 debian
