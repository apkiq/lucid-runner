#!/usr/bin/env bash
set -u

image="base/alpine-3.14"
base="alpine:3.14.9"

echo "Building image $image from base $base"

read -r -d '' dockerfile <<- EOM
FROM $base
RUN apk add --no-cache \
  alpine-sdk \
  curl
ENTRYPOINT ["/bin/sh","-c","sleep infinity"]
EOM

echo "$dockerfile" | $(which docker) build -t $image --progress=plain -
