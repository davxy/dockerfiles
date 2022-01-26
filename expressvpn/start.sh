#!/bin/bash

docker run \
    --env=ACTIVATION_CODE=${EXPRESS_CODE} \
    --env=SERVER=smart \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    --privileged \
    --interactive=true \
    --tty=true \
    --rm \
    --name=expressvpn \
    davxy/expressvpn /bin/bash
