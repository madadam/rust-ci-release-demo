#!/bin/bash

set -ex

CHANNEL=${CHANNEL:-stable}

# Skip if $ONLY_DEPLOY is defined and this is not a version bump.
[ -n "$ONLY_DEPLOY" -a -z "$PROJECT_VERSION" ] && exit 0

# Skip if this is a version bump, but rust channel is not stable.
[ -n "$PROJECT_VERSION" -a "$CHANNEL" != stable ] && exit 0

case "$TRAVIS_OS_NAME" in
  linux)
    HOST=x86_64-unknown-linux-gnu
    ;;
  osx)
    HOST=x86_64-apple-darwin
    ;;
esac

# Install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain=$CHANNEL
rustc -V
cargo -V

# Install crates for cross-compilation
if [ -n "$TARGET" -a "$HOST" != "$TARGET" ]; then
  rustup target add $TARGET
fi
