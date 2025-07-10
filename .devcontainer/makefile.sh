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
CMD="./.devcontainer/post-create.sh; ./.devcontainer/post-start.sh; zsh ;"

# Calculates the RepositoryName from the base path, needed for loading the framework inside the container.
getRepositoryName

# Loads variables k=v from the .env file into DOCKER_ENVS such as DT_TENANT, so they can be added as environment variables to the Docker container.
getDockerEnvsFromEnvFile


buildNoCache(){
    # Build the image with no cache
    echo "Building the image $IMAGENAME for $ARCH..."
    docker build --no-cache --build-arg ARCH=$ARCH --platform linux/$ARCH -t $IMAGENAME .
    echo "Building completed."   
}


buildx(){
    docker buildx build --platform linux/amd64,linux/arm64 --build-arg ARCH=amd64,ARCH=arm64 -t dt-enablement:dual .
}

buildxx(){
    # Build the image for AMD
    ARCH=amd64
    echo "Building the image $IMAGENAME for $ARCH..."
    docker build --platform linux/amd64 --build-arg ARCH=amd64 -t $IMAGENAME:v0-amd64.
    ARCH=arm64
    docker build --platform linux/arm64 --build-arg ARCH=amd64 -t $IMAGENAME:v0-arm64 .
    echo "Building the image $IMAGENAME for $ARCH..."
    #docker buildx build --platform linux/amd64,linux/arm64 -t $IMAGENAME:dual .
    echo "Build X completed."
}

build(){
    # Build the image
    echo "Building the image $IMAGENAME for $ARCH..."
    docker build --build-arg ARCH=$ARCH --platform linux/$ARCH -t $IMAGENAME .
    echo "Building completed."
}

runForProfessors(){
    # Same as run but with exposure of port 8000 for Labguides

    # Add repository name to the environment variables for the container
    DOCKER_ENVS+=" -e RepositoryName=$RepositoryName"

    docker run $DOCKER_ENVS \
        --name $IMAGENAME \
        --privileged \
        --dns=8.8.8.8 \
        --network=host \
        -p 8000:8000 \
        -p 30100:30100 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /lib/modules:/lib/modules \
        -v $(dirname "$PWD"):/workspaces/$RepositoryName \
        -w /workspaces/$RepositoryName \
        -it $IMAGENAME \
        /usr/bin/zsh -c "$CMD"
}

run(){
    # Add repository name to the environment variables for the container
    DOCKER_ENVS+=" -e RepositoryName=$RepositoryName"

    docker run $DOCKER_ENVS \
        --name $IMAGENAME \
        --privileged \
        --dns=8.8.8.8 \
        --network=host \
        -p 30100:30100 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /lib/modules:/lib/modules \
        -v $(dirname "$PWD"):/workspaces/$RepositoryName \
        -w /workspaces/$RepositoryName \
        -it $IMAGENAME \
        /usr/bin/zsh -c "$CMD"
}

start(){
    status=$(docker inspect -f '{{.State.Status}}' "$IMAGENAME")
    #echo "STATUS $status"
    if [ "$status" = "exited" ] || [ "$status" = "dead" ]; then
        echo "Container is stopped removing container."
        #TODO: fix when no image is there
        # Add repository name to the environment variables for the container
        docker rm $IMAGENAME
        echo "Starting a new container"
        run 
    elif  [ "$status" = "running" ]; then 
        echo "Container $IMAGENAME is running, attaching new shell to it"
        docker exec -it $IMAGENAME zsh 
    else
        echo "Image $IMAGENAME is not found."
        if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^$IMAGENAME$"; then
            echo "Image exists locally, running it."
        else
            echo "Image does not exist locally. Building it first"
            build
        fi
        run
    fi
}