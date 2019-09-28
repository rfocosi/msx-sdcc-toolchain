#!/bin/sh
VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: `basename $0` <version>"
  exit 1
fi

docker build . -t msx-sdcc-toolchain
docker tag msx-sdcc-toolchain rfocosi/msx-sdcc-toolchain:$VERSION
docker push rfocosi/msx-sdcc-toolchain:$VERSION
