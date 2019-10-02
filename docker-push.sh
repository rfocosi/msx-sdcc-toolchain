#!/bin/sh
HUB_REPOSITORY=rfocosi/msx-sdcc-toolchain
VERSION=`grep TOOLCHAIN_VERSION Dockerfile | sed 's/.\+TOOLCHAIN_VERSION=//' | head -n1`

if [ -z "$VERSION" ]; then
  echo "ERROR: TOOLCHAIN VERSION not found!"
  exit 1
fi

docker build -t $HUB_REPOSITORY:$VERSION .

SDCC_VERSION=`docker run $HUB_REPOSITORY:$VERSION sdcc -v | head -n 1 | awk '{ print $4 }'`

[ -z "$SDCC_VERSION" ] && echo "ERROR: Version empty!" && exit 1

docker tag $HUB_REPOSITORY:$VERSION $HUB_REPOSITORY:$VERSION-SDCC-$SDCC_VERSION
docker push $HUB_REPOSITORY:$VERSION-SDCC-$SDCC_VERSION
