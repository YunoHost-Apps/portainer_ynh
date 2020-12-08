#!/bin/bash

[ "$architecture" == "amd64" ] && image=portainer/portainer-ce:${portainer_version}
[ "$architecture" == "i386" ]  && image=portainer/portainer-ce:linux-386-${portainer_version}
[ "$architecture" == "armhf" ] && image=portainer/portainer-ce:linux-arm-${portainer_version}
[ -z $image ] && ynh_die "Sorry, your ${architecture} architecture is not supported ..."

options="-p $port:9000 -v ${data_path}/data:/data -v /var/run/docker.sock:/var/run/docker.sock"
containeroptions=""

iptables -t filter -N DOCKER

docker run -d --name=$app --restart always $options $image $containeroptions  1>&2
CR=$?

echo $CR
