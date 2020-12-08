# Portainer for YunoHost

[![Integration level](https://dash.yunohost.org/integration/portainer.svg)](https://dash.yunohost.org/appci/app/portainer) ![](https://ci-apps.yunohost.org/ci/badges/portainer.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/portainer.maintain.svg)  
[![Install Portainer with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=portainer)

> *This package allows you to install Portainer quickly and simply on a YunoHost server.
If you don't have YunoHost, please consult [the guide](https://yunohost.org/#/install) to learn how to install it.*

## Overview
A web interface for the Docker engine management. It allows you to manage all your Docker resources (containers, images, volumes, networks and more!).

**Shipped version:** 2.0.0

## Screenshots

![](https://mk0portainer4y460ly6.kinstacdn.com/wp-content/uploads/2020/08/01_homescreen.png)

## Demo

* [Official live-demo](https://www.portainer.io/live-demo/)

#### Multi-user support

 * Are LDAP and HTTP auth supported? **No**
 * Can the app be used by multiple users? **No**

#### Supported architectures

* x86-64 - [![Build Status](https://ci-apps.yunohost.org/ci/logs/portainer%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/portainer/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/portainer%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/portainer/)

## Additional information

This app is inside a [Docker image](https://hub.docker.com/r/portainer/portainer/).
*It was generated with [DockerApp Yunohost](https://github.com/aymhce/dockerappmodel_ynh/)*

## Links

 * Report a bug: https://github.com/YunoHost-Apps/portainer/issues
 * App website: [Portainer](https://portainer.io/).
 * Upstream app repository: https://github.com/portainer/portainer
 * YunoHost website: https://yunohost.org/

---

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/portainer_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/portainer_ynh/tree/testing --debug
ou
sudo yunohost app upgrade portainer -u https://github.com/YunoHost-Apps/portainer_ynh/tree/testing --debug
```
