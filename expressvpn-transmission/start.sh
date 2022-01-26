#!/bin/bash

docker run \
    --env=ACTIVATION_CODE=${EXPRESS_CODE} \
    --env=SERVER=smart \
    --env=T_USERNAME=${TRANSMISSION_USER} \
    --env=T_PASSWORD=${TRANSMISSION_PASS} \
    --env=T_ALLOWED='192.168.1.*' \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    --privileged \
    --tty=true \
    --rm \
    -p 9091:9091 \
    --volume=/mnt/data/downloads/transmission:/downloads \
    --name=expressvpn-transmission \
    davxy/expressvpn-transmission
