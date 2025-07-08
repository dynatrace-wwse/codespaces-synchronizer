#!/bin/bash
# Build script for building locally and launching the training environment in a Docker container without Visual Studio Code.
# Tested on Ubuntu 22.04 and 24.04 LTS with Docker installed.

source runlocal/helper.sh
ENV_FILE=runlocal/.env

IMAGENAME="dt-enablement"

ARCHITECTURE=$(uname -m)
# Setting the ARG ARCH amd64 or arm64 so the correct binaries can be downloaded.
if  [ "$ARCHITECTURE" == "x86_64" ] || [ "$ARCHITECTURE" == "amd64" ]; then
    ARCH="amd64"
elif [ "$ARCHITECTURE" == "aarch64" ] || [ "$ARCHITECTURE" == "arm64" ]; then   
    ARCH="arm64"
else 
    echo "Unknown architecture $ARCHITECTURE"
fi

# Commands to be executed in the container after it is created (as in VSCode devcontainer.json)
CMD="./.devcontainer/post-create.sh; ./.devcontainer/post-start.sh; zsh"

# Calculates the RepositoryName from the base path, needed for loading the framework inside the container.
getRepositoryName

# Loads variables k=v from the .env file into DOCKER_ENVS such as DT_TENANT, so they can be added as environment variables to the Docker container.
getDockerEnvsFromEnvFile

# Build the image
docker build --build-arg ARCH=$ARCH --platform linux/$ARCH -t $IMAGENAME .

echo "running $RepositoryName in docker container"

# Add repository name to the environment variables for the container
DOCKER_ENVS+=" -e RepositoryName=$RepositoryName"

docker run $DOCKER_ENVS \
    --name $IMAGENAME \
    --privileged \
    --dns=8.8.8.8 \
    --network=host \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /lib/modules:/lib/modules \
    -v $(dirname "$PWD"):/workspaces/$RepositoryName \
    -w /workspaces/$RepositoryName \
    -it $IMAGENAME \
    /usr/bin/zsh -c "$CMD"