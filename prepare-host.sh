#!/bin/bash

# Debugging option
#set -x

read -p    ">>> Enter IP address of target host: "                                 IP
read -p    ">>> Enter SSH username with admin privileges (e.g. root): "            USERNAME
read -s -p ">>> Enter password for ansible user: "                                 PASS
printf "\n"
read -p    ">>> Do you want to provide a public SSH key for ansible user? [Y/n]: " SSH_KEY_QA
read -e -p ">>> Enter absolute path to key: "                                      SSH_KEY_PATH
PASS_ENCRYPTED=$(openssl passwd -crypt -salt racoon63 $PASS)
SSH_KEY=$(cat $SSH_KEY_PATH)

printf ">>> Prepare target host: $IP \n"

ssh $USERNAME@$IP <<EOF
$(typeset -f $PASS_ENCRYPTED $SSH_KEY)
adduser --base-dir /home/ --home-dir /home/ansible --groups wheel --password $PASS_ENCRYPTED ansible
echo 'ansible ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers &>/dev/null
mkdir -p /home/ansible/.ssh/
touch /home/ansible/.ssh/authorized_keys
echo $SSH_KEY | tee -a /home/ansible/.ssh/authorized_keys &>/dev/null
chmod 700 /home/ansible/.ssh/
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible
EOF

printf ">>> Done \n"