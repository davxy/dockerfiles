# Run expressvpn and transmission in a container

FROM davxy/expressvpn:latest

# Install packages
RUN apt-get update && apt-get install -y \
    transmission-daemon

# Remove cache
RUN rm -rf /var/lib/apt/lists/*

COPY transmission.sh /tmp/transmission.sh

RUN ln -s /var/lib/transmission-daemon/downloads /downloads

CMD ["/bin/bash", "/tmp/transmission.sh"]
