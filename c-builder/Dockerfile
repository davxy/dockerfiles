FROM debian:stable-slim

# Upgrade system
RUN apt-get update && \
    apt-get dist-upgrade -y

# Install packages
RUN apt-get install --no-install-recommends --no-install-suggests -y \
        gcc \
        clang \
        binutils \
        make \
        build-essential \
        lcov \
        gcovr \
        valgrind \
        cppcheck \
        vera++ \
        libgoogle-perftools-dev \
        doxygen \
        git

# Remove cache
RUN rm -rf /var/lib/apt/lists/*

# Default command
CMD ["gcc", "--version"]
