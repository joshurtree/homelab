#!/bin/sh
chdir /root
mkdir .ssh
cp -r host-ssh/authorized_keys .ssh
chown root:root .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
exec /usr/sbin/sshd -D -e "$@"