FROM centos:latest
RUN yum makecache fast && \
    yum update -y && \
    yum install -y openssh-server sudo python && \
    yum clean all
RUN adduser --base-dir /home/ --home-dir /home/ansible --groups wheel --password ansible ansible
RUN mkdir -p /home/ansible/.ssh/
COPY --chown=ansible authorized_keys /home/ansible/.ssh/
COPY --chown=root sudoers /etc/
RUN chmod 700 /home/ansible/.ssh/ && \
    chmod 600 /home/ansible/.ssh/authorized_keys && \
    chown -R ansible:ansible /home/ansible
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
EXPOSE 22/tcp
ENTRYPOINT ["/usr/sbin/sshd", "-D"]