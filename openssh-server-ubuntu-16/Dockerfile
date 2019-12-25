# Origin: https://docs.docker.com/engine/examples/running_ssh_service/
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN apt-get install -y iproute2
RUN apt-get install -y net-tools
RUN apt-get install -y vim
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y python
RUN apt-get install -y git
RUN apt-get install -y sudo
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN useradd -ms /bin/bash ubuntu

USER ubuntu
WORKDIR /home/ubuntu

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/.*PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
