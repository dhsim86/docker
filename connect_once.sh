#!/bin/bash
echo "connect_once.sh new_container_name image_id"

docker run -it -u dongho --name local-00-ubuntu $1 /bin/bash
