FROM ubuntu:18.04

ENV NOTVISIBLE "in users profile"
ENV ROOTPASSWORD "YOURSECRETPASSWORD"

COPY entrypoint.sh /opt/

RUN apt update -y && \
    apt install -y python3 openssh-server && \
    apt clean -y
RUN mkdir /var/run/sshd
RUN echo 'root:$ROOTPASSWORD' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo "export VISIBLE=now" >> /etc/profile
RUN chmod +x /opt/entrypoint.sh

WORKDIR /

EXPOSE 22

ENTRYPOINT ["/opt/entrypoint.sh"]