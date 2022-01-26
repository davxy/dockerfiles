FROM rust:slim

# Upgrade system
RUN apt-get update && \
    apt-get dist-upgrade -y

# Install packages
RUN apt-get install -y \
        ssh \
        build-essential \
        clang \
        llvm \
        curl \
        lsb-release \
        protobuf-compiler \
        librust-openssl-sys-dev \
        libtss2-dev \
        binaryen

# Remove cache
RUN rm -rf /var/lib/apt/lists/*

# Install/Update Rust required components
RUN rustup update && \
    rustup install nightly && \
    rustup target install wasm32-unknown-unknown && \
    rustup component add rustfmt && \
    rustup component add clippy

# Default command
CMD ["rustc", "--version"]
