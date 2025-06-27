#!/bin/bash

docker build -t msubuntu .

export RepositoryName=codespaces-synchronizer

# Works after reboot, most likely the dns of docker due hostname change.
docker run -e RepositoryName=$RepositoryName --privileged --dns=8.8.8.8 --network=host -v /var/run/docker.sock:/var/run/docker.sock -v /lib/modules:/lib/modules -v /home/ubuntu/codespaces-synchronizer:/workspaces/$RepositoryName -w /workspaces/$RepositoryName -it msubuntu /bin/bash


exit
###-----------------

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
sudo su
export RepositoryName=codespaces-synchronizer
source .devcontainer/util/functions.sh
createKindCluster
installHelm
installK9s


Try this...
export KIND_EXPERIMENTAL_CONTAINERD_SNAPSHOTTER=overlayfs
2. Ensure /var/lib/containerd is writable

--- inside codespaces.

vscode user is created, has no access to docker.
kind cluster can be accessed (root)
when deploying oCloudNative apparently the OA and AG cant be pulled, they hang
should be alsso an issue when doing sudo su that the hostname is not found 

maybe set the Overlay??

EOF
