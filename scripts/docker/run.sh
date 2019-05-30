#!/bin/bash

#[ "$architecture" == "amd64" ] && image=portainer/portainer:1.20.1
#[ "$architecture" == "i386" ]  && image=portainer/portainer:linux-386-1.20.1
#[ "$architecture" == "armhf" ] && image=portainer/portainer:linux-arm-1.20.1
#[ -z $image ] && ynh_die "Sorry, your $architecture architecture is not supported ..."

image=portainer/portainer

options="-p $port:9000 -v $data_path/data:/data -v /var/run/docker.sock:/var/run/docker.sock"
containeroptions="--no-auth"

iptables -t filter -N DOCKER 

docker run -d --name=$app --restart always $options $image $containeroptions 1>&2
CR=$?

echo $CR
