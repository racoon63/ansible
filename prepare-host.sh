#!/bin/bash

# Debugging option
#set -x

KEYS=("id_dsa.pub" "id_ecdsa.pub" "id_ed25519.pub" "id_rsa.pub")
KEYDIR="$HOME/.ssh"

read -p    ">>> Enter IP address of target host: " IP
read -p    ">>> Enter SSH username with admin privileges (e.g. root): " USERNAME
read -s -p ">>> Enter password for ansible user: " PASS
printf "\n"
read -p    ">>> Do you want to provide your public SSH key for ansible user? [Y/n]: " SSH_KEY_QA

for KEY in "${KEYS[@]}"
do
    if [ -e $KEYDIR/$KEY ]
    then
        SSH_KEY_PATH="$KEYDIR/$KEY"
        break
    fi
done

SSH_KEY=$(cat $SSH_KEY_PATH)
PASS_ENCRYPTED=$(openssl passwd -crypt -salt racoon63 $PASS)

printf ">>> Prepare target host: $IP \n"

ssh $USERNAME@$IP <<EOF &>/dev/null
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