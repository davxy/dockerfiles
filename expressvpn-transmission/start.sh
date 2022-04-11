#!/bin/bash

docker run \
    --name=expressvpn-transmission \
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
    --volume=/mnt/data/transmission/config:/transmission/config \
    --volume=/mnt/data/transmission/complete:/transmission/complete \
    --volume=/mnt/data/transmission/incomplete:/transmission/incomplete \
    davxy/expressvpn-transmission
