#! /bin/bash
REGISTRY="ghcr.io/la-cc"

# get current tag information
IS_DEV_BUILD=$(git tag -l --contains HEAD)
GIT_TAG=$(git describe --abbrev=0 --tags HEAD)

if [ -z "$IS_DEV_BUILD" ]; then
    TIMESTAMP=$(date +%s)
    TAG=$(echo "$GIT_TAG"-"$TIMESTAMP")
else
    TAG=$GIT_TAG
fi

echo "Building image with tag $TAG"

docker \
    build . \
    -f build/docker/Dockerfile \
    -t $(echo "$REGISTRY/webinar-templater:$TAG")
