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
docker version


