#!/bin/sh
#---------------------------------------------------------------- 
# Shell Name：alpine_openrc_docker.sh
# Description：WSL+alpine, 用于启动docker, 在win休眠or重启之后
# Author：bobby
# E-mail: bobby4kit@outlook.com
# Time：2022-09-20 16:01 CST
# Copyright © 2022 bobby4kit. All rights reserved.
#----------------------------------------------------------------*/

#UPDATE repo
sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
apk update

#Fixed localtime
#apk add --no-cache tzdata
#cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#ADD openrc docker
apk add --no-cache openrc docker

#START openrc
openrc
touch /run/openrc/softlevel
rc-status

#Run docker
service docker restart
#wait for docker status
sleep 2
docker version


