FROM ubuntu:14.04
MAINTAINER Alexander Vynnyk <cosmonaut.ok@zoho.com>

RUN dpkg --add-architecture i386
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server sudo python

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd -m kitchen -s /bin/bash
RUN echo 'kitchen:kitchen' | chpasswd
RUN cp /etc/sudoers /tmp/sudoers
RUN chmod 0660 /tmp/sudoers
RUN echo 'kitchen   ALL=(ALL:ALL) NOPASSWD:ALL' >> /tmp/sudoers
RUN chmod 0440 /tmp/sudoers
RUN mv -f /tmp/sudoers /etc/sudoers
# RUN mkdir /home/kitchen/.ssh/

# ADD id_rsa.pub /home/kitchen/.ssh/authorized_keys
# ADD id_rsa.pub /home/kitchen/.ssh/id_rsa.pub
# ADD id_rsa /home/kitchen/.ssh/id_rsa
# RUN chmod 400 /home/kitchen/.ssh/authorized_keys
# RUN chown kitchen:kitchen /home/kitchen/.ssh/*
# RUN chmod 600 /home/kitchen/.ssh/*

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# EXPOSE 22
# CMD ["/usr/sbin/sshd", "-D"]
