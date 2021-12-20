#!/bin/bash
echo "connect.sh docker_container_name"

docker exec -it $1 /bin/bash
