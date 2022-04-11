# Run expressvpn and transmission in a container

FROM davxy/expressvpn:latest

# Install packages
RUN apt-get update && apt-get install -y \
    transmission-daemon

# Remove cache
RUN rm -rf /var/lib/apt/lists/*

# Copy the entry script
COPY transmission.sh /transmission/transmission.sh

CMD ["/transmission/transmission.sh"]
