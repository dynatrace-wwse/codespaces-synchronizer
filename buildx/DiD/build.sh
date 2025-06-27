#!/bin/bash

docker build -t msubuntu .

export RepositoryName=codespaces-synchronizer

# Works but image download not, check that over internet as next step. --init
docker run -e RepositoryName=$RepositoryName --privileged --dns=8.8.8.8 --network=host -v /var/run/docker.sock:/var/run/docker.sock -v /lib/modules:/lib/modules -v /home/ubuntu/codespaces-synchronizer:/workspaces/$RepositoryName -w /workspaces/$RepositoryName -it msubuntu /bin/bash


exit

kind delete cluster

export KIND_EXPERIMENTAL_CONTAINERD_SNAPSHOTTER=overlayfs
source .devcontainer/util/functions.sh
createKindCluster
installK9s
#docker pull shinojosa/todoapp:1.0.0
#kind load docker-image shinojosa/todoapp:1.0.0
deployTodoApp

: <<'EOF'
Comments on progress 
Kind creation ok


---- 

Try this...
export KIND_EXPERIMENTAL_CONTAINERD_SNAPSHOTTER=overlayfs

2. Ensure /var/lib/containerd is writable

EOF
