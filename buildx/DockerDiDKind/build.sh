#!/bin/bash

docker build -t docker-kind-dind .

# works
#docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock -p 6443:6443 -it docker-kind-dind /bin/bash

export RepositoryName=codespaces-synchronizer


# Works but image download not, check that over internet as next step.
docker run -e RepositoryName=$RepositoryName --privileged --network=host -v /var/run/docker.sock:/var/run/docker.sock -v /home/ubuntu/codespaces-synchronizer:/workspaces/$RepositoryName -w /workspaces/$RepositoryName -it docker-kind-dind /bin/bash

: <<'EOF'

This configuration works but the images need to be downloaded first then loaded

export NO_PROXY="localhost, 127.0.0.*"

export no_proxy=$NO_PROXY

export NO_PROXY="localhost, 127.0.0.*"
source .devcontainer/util/functions.sh
createKindCluster 
installK9s
source ~/.config/envman/PATH.env
k9s

docker pull shinojosa/todoapp:1.0.0
kind load docker-image shinojosa/todoapp:1.0.0
deployTodoApp

EOF
