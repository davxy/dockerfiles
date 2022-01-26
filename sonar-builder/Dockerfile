FROM davxy/c-builder

RUN mkdir -p /usr/share/man/man1

# Upgrade system
RUN apt-get update && \
    apt-get dist-upgrade -y

# Install packages
RUN apt-get install --no-install-recommends --no-install-suggests -y \
        unzip \
        wget \
        openjdk-8-jre-headless

# Remove cache
RUN rm -rf /vat/lib/apt/lists/*

# Install Sonar Scanner CLI
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip && \
    unzip sonar-scanner* -d /opt && \
    mv /opt/sonar-scanner* /opt/sonar-scanner

ENV PATH="${PATH}:/opt/sonar-scanner/bin"

CMD ["/bin/bash"]
