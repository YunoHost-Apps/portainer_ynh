#!/bin/bash

image=portainer/portainer:1.14.2
[ "$architecture" == "i386" ]  && image=portainer/portainer:linux-386-1.14.2
[ "$architecture" == "armhf" ] && image=portainer/portainer:linux-arm-1.14.2

options="-p YNH_PORT:9000 -v YNH_DATA/data:/data"

other_options="--add-host yunohost:YNH_HOST"
[ "$incontainer" == "0" ] && other_options="--link YNH_ID:yunohost"

docker run -d --name=YNH_APP --restart always $options $other_options $image >/dev/null 2>&1
CR=$?

echo $CR
