FROM ubuntu:16.04

MAINTAINER Mithun Cheriyath <mithun@openkerala.com>

# Mainly to perform unattended installation of debian packages
ENV DEBIAN_FRONTEND noninteractive

# To ensure we have en_US.UTF-8 locale 
RUN locale-gen en_US.UTF-8

# Installation of common dependencies
RUN apt-get update && apt-get install -y \
    curl \
    lsb-release \
    openssh-server \
    sudo \
    vim 

# Setup Vagrant User Credentials
RUN if ! getent passwd vagrant; then useradd -d /home/vagrant -m -s /bin/bash vagrant; fi \
    && echo vagrant:vagrant | chpasswd \
    && echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /etc/sudoers.d \
    && echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vagrant \
    && chmod 0440 /etc/sudoers.d/vagrant


# Create your own SSH keys and add the private key to your vagrant
RUN mkdir -p /home/vagrant/.ssh \
    && chmod 0700 /home/vagrant/.ssh \
    && wget --no-check-certificate \
      https://raw.githubusercontent.com/openkerala/vagrant-docker-baseimages/master/keys/vagrant.pub \
      -O /home/vagrant/.ssh/authorized_keys \
    && chmod 0600 /home/vagrant/.ssh/authorized_keys \
    && chown -R vagrant /home/vagrant/.ssh

# Vagrant Cachier
RUN rm /etc/apt/apt.conf.d/docker-clean

# SSHD in the foreground
CMD /usr/sbin/sshd -D \
    -o UseDNS=no\
    -o UsePAM=no\
    -o PasswordAuthentication=yes\
    -o UsePrivilegeSeparation=no\
    -o PidFile=/tmp/sshd.pid
