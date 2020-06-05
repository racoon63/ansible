#!/bin/bash

echo "########################################"
echo ""
echo "     Your IP: $(hostname -I)"
echo ""
echo "     Your user: root"
echo ""
echo "     Your password: $ROOTPASSWORD"
echo ""
echo "########################################"

/usr/sbin/sshd -D