#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  echo 'deb http://www.emdebian.org/debian/ unstable main' >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y emdebian-archive-keyring && \
  apt-get install -y build-essential && \
  apt-get install -y openssh-server && \
  apt-get install -y gcc-arm-linux-gnueabihf debootstrap u-boot-tools device-tree-compiler binutils-arm-linux-gnueabi libncurses5-dev fakeroot u-boot-tools zlib1g-dev libncurses5-dev && \
  apt-get install -y sudo python software-properties-common && \
  apt-get install -y curl git man unzip emacs23-nox wget mc && \
  rm -rf /var/lib/apt/lists/*

# Add files.
# ADD ~/.bashrc /root/.bashrc
# ADD ~/.gitconfig /root/.gitconfig
# ADD ~/.scripts /root/.scripts

# Configure
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd -m vagrant -s /bin/bash
RUN echo 'vagrant:vagrant' | chpasswd
RUN cp /etc/sudoers /tmp/sudoers
RUN chmod 0660 /tmp/sudoers
RUN echo 'vagrant   ALL=(ALL:ALL) NOPASSWD:ALL' >> /tmp/sudoers
RUN chmod 0440 /tmp/sudoers
RUN mv -f /tmp/sudoers /etc/sudoers
RUN mkdir /home/vagrant/.ssh/

# ADD id_rsa.pub /home/vagrant/.ssh/authorized_keys
# ADD id_rsa.pub /home/vagrant/.ssh/id_rsa.pub
# ADD id_rsa /home/vagrant/.ssh/id_rsa
# RUN chmod 400 /home/vagrant/.ssh/authorized_keys
# RUN chown vagrant:vagrant /home/vagrant/.ssh/*
# RUN chmod 600 /home/vagrant/.ssh/*

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

EXPOSE 22

# get kernel code
RUN git clone -b sunxi-3.4 https://github.com/linux-sunxi/linux-sunxi ~/linux-sunxi
RUN wget "https://raymii.org/s/inc/downloads/olinux/a10/kernel_config_raymii" -O ~/linux-sunxi/.config

# Define default command.
CMD ["/usr/sbin/sshd", "-D"]

