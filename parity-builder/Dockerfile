FROM paritytech/ci-linux:production

RUN apt-get update

RUN apt-get install --no-install-recommends --no-install-suggests -y \
    wget \
    vim

RUN rm -rf /var/lib/apt/lists/*

COPY scripts/ /scripts

CMD ["/bin/bash"]
