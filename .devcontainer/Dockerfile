FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG HELM_VERSION=v3.17.0

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
    

COPY entrypoint.sh /tmp/
RUN chmod +x /tmp/entrypoint.sh

# change ownership of the home directory
RUN chown -R vscode:vscode /home/vscode

WORKDIR /home/vscode

USER vscode

# Entrypoint is on the mounted volume using the framework, post-create.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]

CMD [ "sleep", "infinity" ]