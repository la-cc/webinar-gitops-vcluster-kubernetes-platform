FROM python:3.10-alpine

ENV PATH=/usr/local/src:$PATH

# Versions
ARG KUBECTL_VERSION=1.32.0
ARG HELM_VERSION=3.13.0

# Install Python build dependencies and other required tools
RUN apk --no-cache add \
    gcc \
    musl-dev \
    libffi-dev \
    make \
    bash \
    openssl \
    curl \
    pcre2-tools \
    grep \
    git \
    jq \
    nano \
    apache2-utils \
    gettext

# Update pip
RUN pip3 install --upgrade pip

# Install Python requirements
COPY tools/templater/src/python/bootstrap/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Install envsubst
RUN apk --no-cache add gettext

# Install kubectl
RUN curl -L "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    -o kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin

# Install helm
RUN curl -L "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    -o helm.tar.gz \
    && tar -zxvf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin \
    && rm -rf linux-amd64 helm.tar.gz

# Copy validation schemas
COPY tools/templater/src/python/bootstrap/schemas /usr/local/lib/python3.10/schemas

# Copy binaries
COPY tools/templater/src/python/bootstrap/config-template /usr/local/bin

# Copy templates
COPY tools/templater/src/templates /usr/local/src/templates

# Copy initial config files
COPY tools/templater/src/configs /usr/local/src/configs

# Copy bash scripts
COPY tools/templater/src/bash/ /usr/local/bin
RUN chmod +x /usr/local/bin/*

WORKDIR /mnt/pwd

# Setup entrypoint to load environment variables and kubeconfig
ENTRYPOINT ["/bin/sh", "-c", "\
    export $(grep -v '^#' .env | xargs) && \
    echo \"$KUBECONFIG_BASE64\" | base64 -d > /tmp/kubeconfig && \
    export KUBECONFIG=/tmp/kubeconfig && \
    exec \"$@\" \
    ", "--"]

CMD ["bash"]
