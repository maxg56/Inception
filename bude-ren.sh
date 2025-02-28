#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <image_name> <dockerfile_directory>"
    exit 1
fi

docker build -t "$1" "$2"
if [ $? -eq 0 ]; then
   docker run --rm -p 2345:443 --env-file srcs/.env "$1" 
else
    echo "Docker build failed!"
fi
