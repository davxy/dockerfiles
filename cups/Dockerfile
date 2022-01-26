FROM debian:stable-slim

# Upgrade system
RUN apt-get update && \
    apt-get dist-upgrade -y

# Install packages
RUN apt-get install --no-install-recommends --no-install-suggests -y \
        cups-daemon \
        cups-bsd \
        cups-filters \
        hplip

# Remove cache
RUN rm -rf /var/lib/apt/lists/*

# Add user and disable sudo password checking
RUN useradd \
  --groups=sudo,lp,lpadmin \
  print

# Change admin password
RUN echo "print:print" | chpasswd

# Configure the service's to be reachable
RUN /usr/sbin/cupsd \
  && while [ ! -f /var/run/cups/cupsd.pid ]; do sleep 1; done \
  && cupsctl --remote-admin --remote-any --share-printers \
  && kill $(cat /var/run/cups/cupsd.pid)

# Patch the default configuration file to only enable encryption if requested
RUN sed -e '0,/^</s//DefaultEncryption IfRequested\nServerAlias *\n&/' -i /etc/cups/cupsd.conf

VOLUME /var/log/cups /var/spool/cups /var/cache/cups

# Default command (start cups daemon)
CMD ["/usr/sbin/cupsd", "-f"]
