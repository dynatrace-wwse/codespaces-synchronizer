# Dockerfile
FROM ubuntu:22.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG YQ_VERSION=v4.44.3
ARG YQ_BINARY=yq_linux_amd64
ARG HELM_VERSION=v3.17.0

# Install sudo (if needed)
RUN apt-get update && apt-get install -y sudo zsh

# Create a user named '${USERNAME}' with sudo privileges
RUN useradd -ms /bin/bash ${USERNAME} && echo ${USERNAME}:${USERNAME} | chpasswd && adduser ${USERNAME} sudo

RUN whoami && \
    echo "Running as user: $(whoami)" && \
    echo "User ID: $(id -u)" && \
    echo "Group ID: $(id -g)"

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

# Install Python
RUN apt install python3 python3-pip -y

# Install NodeJS
RUN apt install nodejs -y 

# Install yq
RUN curl -L -o /usr/bin/yq https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/$YQ_BINARY && chmod +x /usr/bin/yq

# Install kubectl
RUN curl -sSL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install Helm
RUN curl -LO https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz \
    && tar -zxvf helm-$HELM_VERSION-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf helm-$HELM_VERSION-linux-amd64.tar.gz linux-amd64 

# Install kind
RUN KIND_RELEASE=$(curl --silent "https://api.github.com/repos/kubernetes-sigs/kind/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') \
    && curl -sSL -o /usr/local/bin/kind https://kind.sigs.k8s.io/dl/$KIND_RELEASE/kind-linux-amd64 \
    && chmod +x /usr/local/bin/kind
    
# Start Docker
# Create startup script
RUN echo '#!/bin/bash\n\
dockerd &\n\
# Wait for Docker to be available\n\
until docker info > /dev/null 2>&1; do\n\
  sleep 1\n\
done\n\
# Keep container running\n\
tail -f /dev/null' > /usr/local/bin/start-docker.sh && chmod +x /usr/local/bin/start-docker.sh

# change ownership of the home directory
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

WORKDIR /home/${USERNAME}
USER ${USERNAME}

#ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD ["/usr/local/bin/start-docker.sh", "bash"]
