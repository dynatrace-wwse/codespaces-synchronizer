#!/bin/bash
# entrypoint.sh


#GID from stat
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
echo "Docker GID: $DOCKER_GID"

# Group ID for docker group
DOCKER_GROUP_ID=$(getent group docker | cut -d: -f3)
echo "DOCKER_GROUP_ID: $DOCKER_GROUP_ID"


if [ -z "$DOCKER_GROUP_ID" ]; then
    echo "Docker group does not exist. Creating it..."
    sudo groupadd -g 1001 docker
else
    echo "Docker group already exists with GID: $DOCKER_GROUP_ID"
    sudo groupadd -g $DOCKER_GROUP_ID docker
fi

echo " Adding user 'vscode' to docker group"
sudo usermod -aG docker vscode


sudo cat /etc/hosts
# Add hostname resolution to Docker container
sudo echo "127.0.0.1  $(hostname)" >> /etc/hosts

# Fix permissions if needed
if [ -S /var/run/docker.sock ]; then
    sudo chown root:docker /var/run/docker.sock
fi

exec "$@"

exit 0
# End of entrypoint.sh

set -e

echo "🔧 [init-kind] Starting Kind setup..."

# Fix DNS resolution issues
echo "🛠️ [init-kind] Setting DNS to 8.8.8.8"
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# Start Docker daemon if not running
if ! docker info > /dev/null 2>&1; then
  echo "🐳 [init-kind] Docker daemon not running. Starting it..."
  sudo dockerd > /tmp/dockerd.log 2>&1 &
  sleep 5
else
  echo "✅ [init-kind] Docker daemon is already running."
fi

# Check internet connectivity from Docker
echo "🌐 [init-kind] Checking Docker network connectivity..."
if ! docker run --rm busybox ping -c 3 registry-1.docker.io > /dev/null 2>&1; then
  echo "❌ [init-kind] Docker cannot reach Docker Hub. Check DNS or network settings."
  exit 1
else
  echo "✅ [init-kind] Docker can reach Docker Hub."
fi

# Create Kind cluster if not already created
if ! kind get clusters | grep -q "kind"; then
  echo "🚀 [init-kind] Creating Kind cluster..."
  kind create cluster
else
  echo "✅ [init-kind] Kind cluster already exists."
fi
