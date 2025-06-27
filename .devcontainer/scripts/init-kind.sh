#!/bin/bash
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
