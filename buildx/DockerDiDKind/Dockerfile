FROM docker:27.5.1-dind as kind
#FROM docker:24.0.6-dind

# Install dependencies
RUN apk add --no-cache \
    curl \
    bash \
    git \
    libc6-compat \
    && rm -rf /var/cache/apk/*

# Install kubectl (works with kind 20)
#RUN curl -LO "https://dl.k8s.io/release/v1.27.4/bin/linux/amd64/kubectl" && \
#    chmod +x kubectl && \
#    mv kubectl /usr/local/bin/

# Install kubectl (latest)
RUN curl -sSL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install kind 20 (works without pulling)
#RUN curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64 && \
#    chmod +x /usr/local/bin/kind

# Install kind latest
RUN KIND_RELEASE=$(curl --silent "https://api.github.com/repos/kubernetes-sigs/kind/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') \
    && curl -sSL -o /usr/local/bin/kind https://kind.sigs.k8s.io/dl/$KIND_RELEASE/kind-linux-amd64 \
    && chmod +x /usr/local/bin/kind

# Expose Docker socket
VOLUME /var/run/docker.sock


CMD [ "sleep", "infinity" ]