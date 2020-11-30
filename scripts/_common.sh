#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="curl"

#=================================================
# PERSONAL HELPERS
#=================================================

# test in container
dockerapp_ynh_incontainer () {
        if [ -f /.dockerenv ]; then
                echo "0"
        else
                echo "1"
        fi
}

# docker driver setter
dockerapp_ynh_driversetter () {
	echo -e "{\n\t\"debug\": false,\n\t\"storage-driver\": \"$1\"\n}\n" > /etc/docker/daemon.json
	systemctl stop docker >/dev/null 2>&1
	rm -rf /var/lib/docker
	mkdir -p /var/lib/docker
	systemctl start docker >/dev/null 2>&1
	sleep 30
	echo $(sh _dockertest.sh)
}

# check or do docker install
dockerapp_ynh_checkinstalldocker () {
	ret=$(sh _dockertest.sh)
	incontainer=$(dockerapp_ynh_incontainer)
        if [ $ret == 127 ]
	then
		# install
		curl -sSL https://get.docker.com | sh
		systemctl enable docker
		curl -L https://github.com/docker/compose/releases/download/${version}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

		#for d in overlay2 overlay devicemapper aufs vfs
		#do
		#	echo "apply $d driver and test it"
		#	[ "$(dockerapp_ynh_driversetter $d)" == "0" ] && echo "$d driver will be used" 1>&2 && break
		#done

		# retest
		ret=$(sh _dockertest.sh)
	fi

	if [ $ret != 0 ]
	then
		ynh_die "Sorry ! Your Docker deamon don't work ... Please check your system logs."
	fi

}

# find replace
dockerapp_ynh_findreplace () {
	for file in $(grep -rl "$2" "$1" 2>/dev/null)
	do
		ynh_replace_string "$2" "$3" "$file"
	done
}

dockerapp_ynh_findreplacepath () {
	dockerapp_ynh_findreplace ../conf/. "$1" "$2"
}

# find replace all variables
dockerapp_ynh_findreplaceallvaribles () {
	dockerapp_ynh_findreplacepath "YNH_APP" "$app"
        dockerapp_ynh_findreplacepath "YNH_DATA" "$data_path"
        dockerapp_ynh_findreplacepath "YNH_PORT" "$port"
        dockerapp_ynh_findreplacepath "YNH_PATH" "$path_url"
	bash docker/_specificvariablesapp.sh
}

# copy conf app
dockerapp_ynh_copyconf () {
	mkdir -p $data_path
	cp -rf ../conf/app $data_path
}

# docker run
dockerapp_ynh_run () {
	export architecture=$(dpkg --print-architecture)
	export incontainer=$(dockerapp_ynh_incontainer)
	# ret=$(bash docker/run.sh)
	# if [ "$ret" != "0" ]
	# then
	# 	# fix after yunohost restore iptables issue
	# 	[ "$ret" == "125" ] && docker inspect $app | grep "Error" | grep -q "iptables failed" && systemctl restart docker && return 0
	# 	ynh_die "Sorry ! App cannot start with docker. Please check docker logs."
	# fi
	[ "$architecture" == "amd64" ] && image=portainer/portainer-ce:${portainer_version}
	[ "$architecture" == "i386" ]  && image=portainer/portainer-ce:linux-386-${portainer_version}
	[ "$architecture" == "armhf" ] && image=portainer/portainer-ce:linux-arm-${portainer_version}
	[ -z $image ] && ynh_die "Sorry, your ${architecture} architecture is not supported ..."

	options="-p $port:9000 -v ${data_path}/data:/data -v /var/run/docker.sock:/var/run/docker.sock"
	containeroptions=""

	# iptables -t filter -N DOCKER

	docker run -d --name=$app --restart always $options $image $containeroptions
}

# docker rm
dockerapp_ynh_rm () {
	docker rm -f $app
}

# Regenerate SSOwat conf
dockerapp_ynh_reloadservices () {
	yunohost app ssowatconf
}
