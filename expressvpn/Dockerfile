# Run expressvpn in a container

FROM debian:stable-slim

# Upgrade system
RUN apt-get update && \
    apt-get dist-upgrade -y

# Install packages
RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    expect \
    iproute2 \
    curl

# Remove cache
RUN rm -rf /var/lib/apt/lists/*

# Download and install expressvpn
ARG APP=expressvpn_2.6.3.3-1_amd64.deb
RUN wget -q "https://download.expressvpn.xyz/clients/linux/${APP}" -O /tmp/${APP} && \
    dpkg -i /tmp/${APP} && \
    rm -rf /tmp/*.deb && \
    apt-get purge -y --auto-remove wget

# Setup application entrypoint and activation script
COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpn_activate.sh /tmp/expressvpn_activate.sh

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
