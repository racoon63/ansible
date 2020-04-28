#!/usr/bin/env bash

PUBKEYS=~/.ssh/*.pub

for KEY in $PUBKEYS
do
    cat $KEY >> authorized_keys
done
