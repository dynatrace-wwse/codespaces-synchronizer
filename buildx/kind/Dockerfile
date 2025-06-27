FROM ubuntu:22.04 as kind

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG YQ_VERSION=v4.44.3
ARG YQ_BINARY=yq_linux_amd64
ARG HELM_VERSION=v3.17.0


# update the container
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install zsh ca-certificates gnupg jq gh wget curl sudo -y && \
    apt-get autoremove -y && \
    apt-get clean -y

# Install Python
RUN apt install python3 python3-pip -y

# Install NodeJS
RUN apt install nodejs -y 

# Install yq
RUN curl -L -o /usr/bin/yq https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/$YQ_BINARY && \
    chmod +x /usr/bin/yq

# Install kubectl
RUN curl -sSL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

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

# Add user to docker group for local development 
#RUN usermod -aG docker $USER

# change ownership of the home directory
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

WORKDIR /home/${USERNAME}
USER ${USERNAME}

ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]
