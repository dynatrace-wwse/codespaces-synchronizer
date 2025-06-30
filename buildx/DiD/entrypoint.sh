#!/bin/bash
# entrypoint.sh

# Add hostname to docker container's /etc/hosts
HOST_MAPPING="127.0.0.1  $(hostname)"
sudo sh -c "echo \"$HOST_MAPPING\" >> /etc/hosts" > /dev/null 2>&1
# Verify output (optional)
cat /etc/hosts

#GID from the socker stat
DOCKER_SOCK_GID=$(stat -c '%g' /var/run/docker.sock)
echo "DOCKER_SOCK_GID: $DOCKER_SOCK_GID"

# Group ID for docker group
DOCKER_GROUP_ID=$(getent group docker | cut -d: -f3)
echo "DOCKER_GROUP_ID: $DOCKER_GROUP_ID"

# Mapping docker groups of Host and Container
if [ $DOCKER_SOCK_GID = $DOCKER_GROUP_ID ]; then
    echo "Docker group GID matches the socket GID. No changes needed."
else
    echo "Docker group GID does not match the socket GID. Updating..."
    sudo groupmod -g $DOCKER_SOCK_GID docker
fi

echo "Adding user '$(whoami)' to docker group"
sudo usermod -aG docker $(whoami)
# making sure changes take effect
newgrp docker

exec "$@"