#!/bin/sh
VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: `basename $0` <version>"
  exit 1
fi

LOCAL_TAG=`docker ps -a | grep msx-sdcc-toolchain | awk '{ print $2 }'`

docker tag $LOCAL_TAG rfocosi/msx-sdcc-toolchain:$VERSION
docker push rfocosi/msx-sdcc-toolchain:$VERSION
