#!/usr/bin/bash

cp /etc/resolv.conf /tmp/resolv.conf
su -c 'umount /etc/resolv.conf'
cp /tmp/resolv.conf /etc/resolv.conf
service expressvpn restart
/usr/bin/expect /tmp/expressvpn_activate.sh
expressvpn connect $SERVER
exec "$@"
