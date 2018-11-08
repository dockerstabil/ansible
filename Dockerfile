FROM ubuntu:18.04

# workdir
RUN mkdir -p /app
WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive apt-get -qy update \
    # preliminaries
    && DEBIAN_FRONTEND=noninteractive apt-get -qy install apt-utils software-properties-common \
    && DEBIAN_FRONTEND=noninteractive apt-add-repository --yes --update ppa:ansible/ansible \
    && DEBIAN_FRONTEND=noninteractive apt-get -qy install ansible curl git gnupg unzip zip \
    # clean up
    && rm -rf /var/lib/apt/lists/*
