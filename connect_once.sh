#!/bin/bash
echo "connect_once.sh new_container_name image_id"

docker run -it -u dongho --name $1 $2 /bin/bash
#docker run -it -u dongho -p 10080:80 -p 443:443 --name local-nginx 5ce2678ddbe4 /bin/bash
