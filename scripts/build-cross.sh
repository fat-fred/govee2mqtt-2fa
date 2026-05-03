#!/bin/bash
set -e

TARGETPLATFORM=$1
echo "build-cross: TARGETPLATFORM=$TARGETPLATFORM"

case "$TARGETPLATFORM" in
  "linux/amd64")
    TARGET=x86_64-unknown-linux-musl
    ;;
  "linux/arm64")
    TARGET=aarch64-unknown-linux-musl
    ;;
  *)
    echo "$TARGETPLATFORM needs to map to a rust target";
    exit 1
    ;;
esac

cross build --target $TARGET --release --bin govee

mkdir -p docker-target/$TARGETPLATFORM
cp target/$TARGET/release/govee docker-target/$TARGETPLATFORM

