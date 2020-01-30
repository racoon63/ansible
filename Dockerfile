FROM ubuntu:18.04

WORKDIR /ansible

RUN apt-get update
RUN apt-get install -y python3 python3-pip sshpass
RUN pip3 install ansible

ENTRYPOINT [ "/bin/bash" ]