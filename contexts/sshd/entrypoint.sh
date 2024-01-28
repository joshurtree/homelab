#!/bin/sh
chdir /root
cp -r host_ssh/authorized_keys .ssh/
chown root:root .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
exec /usr/sbin/sshd -D -e "$@"