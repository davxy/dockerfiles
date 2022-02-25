#!/bin/bash
#
# Mimics the substrate "test-linux-stable" CI job.

SUBSTRATE_REPO="https://github.com/paritytech/substrate.git"

rust_info() {
    rustup show
    cargo --version
    rustup +nightly show
    cargo +nightly --version
    sccache -s
}

set_default_variables() {
    export CARGO_INCREMENTAL=0
}

test_linux_stable() {

    rust_info
    set_default_variables

    export RUSTFLAGS="-Cdebug-assertions=y -Dwarnings"
    export RUST_BACKTRACE=1
    export WASM_BUILD_NO_COLOR=1

    time cargo test --workspace --locked --release --verbose --features runtime-benchmarks --manifest-path "bin/node/cli/Cargo.toml"
    time cargo test -p frame-support-test --features=conditional-storage,no-metadata-docs --manifest-path "frame/support/test/Cargo.toml" --test pallet

    SUBSTRATE_TEST_TIMEOUT=1 time cargo test -p substrate-test-utils --release --verbose --locked -- --ignored timeout
    sccache -s
}

if [ ! -d /builds/substrate ]; then
    git clone $SUBSTRATE_REPO /builds/substrate
fi
cd /builds/substrate

sccache -z
test_linux_stable
