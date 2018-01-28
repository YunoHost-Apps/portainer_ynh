#!/bin/bash

image=portainer/portainer:1.16.1
[ "$architecture" == "i386" ]  && image=portainer/portainer:linux-386-1.16.1
[ "$architecture" == "armhf" ] && image=portainer/portainer:linux-arm-1.16.1

options="-p $port:9000 -v $data_path/data:/data -v /var/run/docker.sock:/var/run/docker.sock"

docker run -d --name=$app --restart always $options $image >/dev/null 2>&1

CR=$?

echo $CR
