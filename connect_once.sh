#!/bin/bash
echo "connect_once.sh new_container_name image_id"

docker run -it -u dongho --name $1 $2 /bin/bash
