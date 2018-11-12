FROM ubuntu:18.04

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
# inspired by https://github.com/docker-library/mysql/blob/223f0be1213bbd8647b841243a3114e8b34022f4/8.0/Dockerfile
RUN groupadd --gid=1000  ansible \
    && useradd --system --shell /bin/bash --create-home --home-dir /home/ansible --gid ansible --uid=1000 ansible

# workdir
RUN mkdir -p /app
WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive apt-get -qy update \
    # preliminaries
    && DEBIAN_FRONTEND=noninteractive apt-get -qy install apt-utils \
    && DEBIAN_FRONTEND=noninteractive apt-get -qy install software-properties-common \
    && DEBIAN_FRONTEND=noninteractive apt-add-repository --yes --update ppa:ansible/ansible \
    && DEBIAN_FRONTEND=noninteractive apt-get -qy install ansible curl git gnupg unzip zip \
    # clean up
    && rm -rf /var/lib/apt/lists/*

USER ansible
