# Image
FROM ubuntu:20.04

# apt-get update and timezone setting
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install tzdata
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# install essentials
RUN apt-get install -y sudo
RUN apt-get install -y git
RUN apt-get install -y tzdata

RUN apt-get install -y build-essential
RUN apt-get install -y maven
RUN apt-get install -y vim
RUN apt-get install -y wget

# add user
RUN adduser --disabled-password --gecos '' dongho
RUN adduser dongho sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# change user
USER dongho

# set home folder
RUN mkdir /home/dongho/apps
RUN mkdir /home/dongho/workspace
RUN mkdir /home/dongho/tmp
RUN mkdir /home/dongho/logs
RUN mkdir /home/dongho/scripts

COPY vimrc /home/dongho/.vimrc

# crond
USER root

RUN apt-get install -y cron

COPY cron-nginx /etc/cron.d
RUN chmod 0644 /etc/cron.d/cron-nginx
RUN crontab /etc/cron.d/cron-nginx

RUN touch /var/log/cron.log

# nginx
USER dongho

COPY nginx_install.sh /home/dongho/tmp
RUN sudo chmod +x /home/dongho/tmp/nginx_install.sh
COPY nginx_install.tar.xz /home/dongho/tmp
COPY nginx.conf /home/dongho/tmp

RUN mkdir -p /home/dongho/logs/nginx
RUN mkdir -p /home/dongho/logs/nginx/root-web
RUN touch /home/dongho/logs/nginx/root-web/access.log

WORKDIR /home/dongho/tmp
RUN ./nginx_install.sh

RUN rm -rf /home/dongho/apps/nginx/logs
RUN ln -s /home/dongho/logs/nginx /home/dongho/apps/nginx/logs
RUN cp /home/dongho/tmp/nginx.conf /home/dongho/apps/nginx/conf
RUN rm -rf /home/dongho/tmp/*

COPY nginx.logrotate /home/dongho/apps/nginx/conf

USER root
RUN chown root:root /home/dongho/apps/nginx/conf/nginx.logrotate
RUN chmod 444 /home/dongho/apps/nginx/conf/nginx.logrotate 

WORKDIR /home/dongho
CMD /home/dongho/apps/nginx/sbin/nginx
