#!/bin/bash
#
# Mimics Parity's CI test jobs:
# - polkadot : "test-build-linux-stable" job.
# - substrate: "test-linux-stable" job.

SOURCE_REPO="https://github.com/paritytech"

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


substrate_test() {
    time cargo test --workspace --locked --release --verbose --features runtime-benchmarks --manifest-path "bin/node/cli/Cargo.toml"
    time cargo test -p frame-support-test --features=conditional-storage,no-metadata-docs --manifest-path "frame/support/test/Cargo.toml" --test pallet

    SUBSTRATE_TEST_TIMEOUT=1 time cargo test -p substrate-test-utils --release --verbose --locked -- --ignored timeout
}

polkadot_test() {
    # Builds with the runtime benchmarks/metrics features are only to be used for testing
    time cargo test --workspace --profile testnet --locked --verbose --features runtime-benchmarks,runtime-metrics

    # We need to separately run the `polkadot-node-metrics` tests. More specifically because the
    # `runtime_can_publish_metrics` test uses the `test-runtime` which doesn't support
    # the `runtime-benchmarks` feature.
    time cargo test --profile testnet --locked --verbose --features=runtime-metrics -p polkadot-node-metrics

    time cargo build --profile testnet --features pyroscope --verbose --bin polkadot
}

help() {
    echo "Usage: subci <substrate|polkadot>"
    exit
}

target=$1
case $target in 
    substrate)
	target_func=substrate_test
        ;;
    polkadot)
	target_func=polkadot_test
        ;;
    *)
        help
        ;;
esac

echo "Testing target: $target"

sccache -z

repo=$SOURCE_REPO/$target.git

if [ ! -d /builds/$target ]; then
    echo "Cloning $repo to /builds/$target"
    git clone $repo /builds/$target
fi
cd /builds/$target
git pull

rust_info
set_default_variables

export RUSTFLAGS="-Cdebug-assertions=y -Dwarnings"
export RUST_BACKTRACE=1
export WASM_BUILD_NO_COLOR=1

$target_func

sccache -s
