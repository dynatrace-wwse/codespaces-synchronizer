FROM ubuntu:22.04

# Install sudo (if needed)
RUN apt-get update && apt-get install -y sudo zsh


# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release \
        git \
        && rm -rf /var/lib/apt/lists/*

# Install Docker and dependencies
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Optional: add entrypoint or default command
CMD ["bash"]