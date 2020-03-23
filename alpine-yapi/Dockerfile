FROM alpine:latest
MAINTAINER tyrionblack kldscs@gmail.com

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  #修改阿里云源+更新apk 
      && apk update && apk --no-cache upgrade \ 
  #修改本地时间
      && echo "Asia/Shanghai" > /etc/timezone \
      && apk add --no-cache tzdata \
      && TZ=Asia/Shanghai \
      && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  #安装 nodejs npm 及pm2管理node服务 
      && apk add --no-cache nodejs npm git \
      && npm install pm2 -g \
  #安装 yapi
      && npm install -g yapi-cli --registry https://registry.npm.taobao.org
      
#ENV TZ="Asia/Shanghai" HOME="/home"
#WORKDIR ${HOME}
#COPY config.json /home/yapi/vendors
#对应 mongo 27017
#EXPOSE 37017 
#ENTRYPOINT ["node"]


