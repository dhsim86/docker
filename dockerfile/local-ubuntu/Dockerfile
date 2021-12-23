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
user dongho
WORKDIR /home/dongho

# set home folder
RUN mkdir apps
RUN mkdir workspace
RUN mkdir tmp
RUN mkdir logs
RUN mkdir scripts

COPY vimrc /home/dongho/.vimrc
