FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Change to root only when running locally on MAC, otherwise leave it to vscode 
ARG USERNAME=vscode
ARG HELM_VERSION=v3.17.0
# Multiarchitecture
ARG ARCH
RUN echo "Building for architecture: ${ARCH}"

# Install Docker CLI (not daemon)
RUN apt update && apt install -y \
    docker.io \
    curl \
    iptables \
    socat \
    ebtables \
    ethtool \
    conntrack \
    sudo \
    gh \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Install Helm
RUN curl -LO https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz \
    && tar -zxvf helm-$HELM_VERSION-linux-amd64.tar.gz \
    && sudo mv linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf helm-$HELM_VERSION-linux-amd64.tar.gz linux-amd64 

# Install kind
RUN KIND_RELEASE=$(curl --silent "https://api.github.com/repos/kubernetes-sigs/kind/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') \
    && curl -sSL -o /usr/local/bin/kind https://kind.sigs.k8s.io/dl/$KIND_RELEASE/kind-linux-amd64 \
    && chmod +x /usr/local/bin/kind
    

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

# In case the user is root, easy workaround when running locally on MAC so root can access the docker.socket of the hosts, otherwise user should be vscode.
# Change ownership carefully and use only locally. Container should run with --privileged
RUN if [ "$USERNAME" != "root" ]; then \
      chown -R $USERNAME:$USERNAME /home/$USERNAME; \
    fi

USER $USERNAME

# Entrypoint is on the mounted volume using the framework, post-create.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD [ "sleep", "infinity" ]