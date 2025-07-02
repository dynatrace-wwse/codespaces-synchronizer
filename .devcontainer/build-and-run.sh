#!/bin/bash

# Build script for building locally and launching the training environment in a Docker container without Visual Studio Code.
# Tested on Ubuntu 22.04 and 24.04 LTS with Docker installed.

# Variables
RepositoryName=codespaces-synchronizer

# Commands to be executed in the container after it is created (as in VSCode devcontainer.json)
CMD="./.devcontainer/post-create.sh; ./.devcontainer/post-start.sh; zsh"

docker build -t msubuntu .

#docker build --no-cache -t msubuntu .
export RepositoryName=$RepositoryName
echo "running codespaces-synchronizer in docker container with name $RepositoryName"

docker run -e RepositoryName=$RepositoryName \
    --privileged \
    --dns=8.8.8.8 \
    --network=host \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /lib/modules:/lib/modules \
    -v $(dirname "$PWD"):/workspaces/$RepositoryName \
    -w /workspaces/$RepositoryName \
    -it msubuntu /usr/bin/zsh \
    -c "$CMD"