#!/bin/bash


# Issues on githubactions and on local machine (Ubuntu 20.04 LTS)
# - RepositoryName not set

# Issue on githubaction
# Kind create cluster fails with https://github.com/dynatrace-wwse/codespaces-synchronizer/actions/runs/15859900011/job/44714237833#step:3:1396


# Notes on how to build and compile the container


# TEST on Ubuntu
# git clone the repo in Linux server
# cd into the repo
# let the codespace start the container.
# Fails due the repository environment variable RepositoryName
# After setting it then post-create works.
# problem exposing the port 30100 (AWS config?)
# TODO: Verify ACL from exposing the port 30100
export RepositoryName="codespaces-synchronizer"
# build the images?

# Shellinto the linux server
docker build -t enablement-container .devcontainer

# Run it
docker run -it -v "$(pwd):/workspace" -w /workspace my-dev-container

# Run it in Debug mode
docker run --log-level=debug -it -v "$(pwd):/workspace" -w /workspace enablement-container


