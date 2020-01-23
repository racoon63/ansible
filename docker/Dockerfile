FROM centos:latest
ENV ssh_pub_key ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBGbz/QXrss+uvB0KJaMb3/vBICel0jpdLWMWjIRpTj5 p.lubach@kk-n.de Thinkpad 20170523
RUN yum makecache fast && \
    yum update -y && \
    yum install -y openssh-server sudo python && \
    yum clean all
RUN adduser --base-dir /home/ --home-dir /home/ansible --groups wheel --password ansible ansible
RUN mkdir -p /home/ansible/.ssh/
RUN echo ${ssh_pub_key} > /home/ansible/.ssh/authorized_keys
RUN echo 'ansible ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers.d/ansible
RUN chmod 700 /home/ansible/.ssh/ && \
    chmod 600 /home/ansible/.ssh/authorized_keys && \
    chown -R ansible:ansible /home/ansible && \
    chmod 440 /etc/sudoers.d/ansible
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
EXPOSE 22/tcp
ENTRYPOINT ["/usr/sbin/sshd", "-D"]