#!/bin/bash
echo "build.sh docker_image_name:tag_name docker_file_directory"

docker build -t $1 $2
