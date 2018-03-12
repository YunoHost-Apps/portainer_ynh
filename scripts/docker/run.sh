#!/bin/bash

[ "$architecture" == "amd64" ] && image=portainer/portainer:1.16.2
[ "$architecture" == "i386" ]  && image=portainer/portainer:linux-386-1.16.2
[ "$architecture" == "armhf" ] && image=portainer/portainer:linux-arm-1.16.2
[ -z $image ] && ynh_die "Sorry, your $architecture architecture is not supported ..."

options="-p $port:9000 -v $data_path/data:/data -v /var/run/docker.sock:/var/run/docker.sock"

docker run -d --name=$app --restart always $options $image 1>&2
CR=$?

echo $CR
