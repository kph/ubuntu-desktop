#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd $DIR

DOCKER_LOCAL=Dockerfile.local
USER_ID=1000
GROUP_ID=1000

# ARG1: Docker image name
# ARG2: Dockerfile
function docker_build {
    docker build --network="host" \
        --build-arg UID="$USER_ID"\
        --build-arg GID="$GROUP_ID"\
        --build-arg UNAME="$USER"\
        -t "$1" -f "$2" .
}

BASEIMAGE=desktop

docker_build $BASEIMAGE Dockerfile

docker run -it \
    --privileged \
    --cap-add SYS_ADMIN \
    --security-opt seccomp=unconfined \
    --cgroup-parent=docker.slice --cgroupns private \
    --tmpfs /tmp --tmpfs /run --tmpfs /run/lock \
    -p 2222:22 \
    $BASEIMAGE

popd
