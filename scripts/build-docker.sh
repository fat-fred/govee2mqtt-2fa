#!/bin/bash
set -e

TARGETPLATFORM=$1
echo "build-docker: TARGETPLATFORM=$TARGETPLATFORM"
shift

./scripts/build-cross.sh "$TARGETPLATFORM"

docker buildx build --platform $TARGETPLATFORM . "$@"
