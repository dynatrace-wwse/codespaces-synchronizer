--8<-- "snippets/container-image.js"

## Overview

The Dynatrace Enablement Framework uses a custom Docker image as the foundation for all training and demo environments. This image is designed for maximum compatibility, flexibility, and ease of use across different platforms and deployment scenarios.

---

## Key Features

### Base Image:
  The framework uses `mcr.microsoft.com/devcontainers/base:ubuntu` as its base image, ensuring seamless compatibility with GitHub Codespaces and Visual Studio Code Dev Containers.

### Cross-Platform Support:
  The image is built to run on both AMD and ARM architectures, eliminating vendor lock-in and enabling use on a wide range of hardware.

### Local and Cloud Execution:  
  - Can be run in GitHub Codespaces for cloud-based development.
  - Supports local execution on Windows, Linux, and macOS via Multipass, providing a consistent development environment regardless of the host OS.

## Dynatrace Integration:
  Dynatrace OneAgent FullStack and Kubernetes CloudNativeFullstack deployments work seamlessly with this deployment. All necessary components such as the CSI Driver, Webhook, ActiveGate, and OneAgents can be deployed in this image ensuring seamless monitoring and observability of the running applications.

## Included Tooling:
  The image comes with a comprehensive set of tools required for modern DevOps and cloud-native development, including:
    - Helm
    - Kubectl
    - Kind
    - Docker
    - Node.js
    - K9s
    - Python


## Docker-in-Socket Strategy

The Dynatrace Enablement Framework uses a **Docker-in-Socket** strategy to enable container management from within the development container. This approach allows the container to communicate directly with the Docker daemon running on the host machine by mounting the Docker socket (`/var/run/docker.sock`) into the container.

### How It Works

- The `entrypoint.sh` script inside the container handles the logic for interacting with the Docker daemon.
- By sharing the Docker socket, the container can run Docker commands as if it were running directly on the host.
- This enables workflows such as building, running, and managing additional containers from within your Codespace or Dev Container.

### Benefits

- **Consistency:** Ensures that Docker commands behave the same way inside the container as they do on the host.
- **Flexibility:** Supports advanced scenarios like running nested containers or orchestrating multi-container setups.
- **Simplicity:** No need to install Docker separately inside the container; it leverages the host’s Docker installation.

### Example

In the `devcontainer.json`, the Docker socket is typically mounted like this:

``` json
  "mounts": ["source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"],
```
## Special Container Runtime Arguments

The following `runArgs` configuration is used in the `devcontainer.json` file to enhance the capabilities of the development container:

```json
"runArgs": ["--init", "--privileged", "--network=host"]
```

  - **--init:** Runs an init process inside the container to handle reaping zombie processes and signal forwarding, improving container stability.
  - **--privileged:** Grants the container extended privileges, allowing it to access all devices on the host and perform operations typically restricted in standard containers. This is useful for scenarios that require low-level system access (e.g., running Docker inside Docker or accessing host resources).
  - **--network=host:** Shares the host’s networking stack with the container, enabling the container to use the host’s network interfaces directly. This is helpful for networking tests or when services inside the container need to be accessible on the host network.


## Image Distribution
  The image is hosted on Docker Hub and is crosscompiled for ARM and AMD architectures.
[![Downloads](https://img.shields.io/docker/pulls/shinojosa/dt-enablement?logo=docker)](https://hub.docker.com/r/shinojosa/dt-enablement)

## Using the Image in devcontainer.json
The way you configure your development container depends on whether you want to use the pre-built image or build it yourself from a Dockerfile.
### Using the Pre-built Image
To use the pre-built image, specify the "image" property in your devcontainer.json file:

``` json
  // Pulling the image from the Dockerhub, runs on AMD64 and ARM64. Pulling is normally faster.
  "image":"shinojosa/dt-enablement:v1.1",

```
This will pull the published image from Docker Hub and use it as the base for your Codespace or Dev Container.

### Building the Image with VS Code
If you want to build the image yourself (for example, to customise it), you need to use the "build" section in your devcontainer.json. Uncomment or add the following:
``` json
  // "image": "shinojosa/dt-enablement",  
  "build": {    
    "dockerfile": "Dockerfile"  }
    },
```

Comment out or remove the "image" line.
Uncomment or add the "build" section, pointing to your Dockerfile.
This will instruct the environment to build the image locally using your Dockerfile.

## Cross-Compiling with Buildx

In the `.devcontainer` folder, there is a `Makefile` that includes a `buildx` target specifically designed for cross-compiling the container image.

To use cross-compilation:

- Make sure your host architecture is **ARM**.
- Run the `buildx` target from the `Makefile` to build the image for multiple architectures.

Example usage:

``` sh

make buildx

```
---


<div class="grid cards" markdown>
- [Let's continue:octicons-arrow-right-24:](instantiation-types.md)
</div>
