# Based on image used by Parity for Substrate, Polkadot and Cumulus CI.
# https://github.com/paritytech/scripts/tree/master/dockerfiles/ci-linux
FROM paritytech/ci-linux:production

# Update apt repo
RUN apt-get update

# Add some additional tool
RUN apt-get install --no-install-recommends --no-install-suggests -y \
    wget \
    vim

# Wipe apt cache
RUN rm -rf /var/lib/apt/lists/*

# Copy utility scripts
COPY scripts/* /builds

CMD ["/bin/bash"]
