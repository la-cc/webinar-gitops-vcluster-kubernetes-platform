FROM python:3.10-alpine

ENV PATH=/usr/local/src:$PATH

# Versions
ARG KUBECTL_VERSION=1.32.0
ARG HELM_VERSION=3.13.0



# install python build dependencies
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


# update pip
RUN pip3 install --upgrade pip

# install requirements
COPY src/python/bootstrap/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# install envsubst
RUN apk --no-cache add gettext


# install kubectl
RUN curl -L "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    -o kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin

# install helm
RUN curl -L "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    -o helm.tar.gz \
    && tar -zxvf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin \
    && rm -rf linux-amd64 helm.tar.gz


# Copy validation schemas
COPY src/python/bootstrap/schemas /usr/local/lib/python3.10/schemas

# copy binaries
COPY src/python/bootstrap/config-template /usr/local/bin

# copy templates
COPY src/templates /usr/local/src/templates

# copy initial config files
COPY src/configs /usr/local/src/configs



# copy bash scripts
COPY src/bash/ /usr/local/bin
RUN chmod +x /usr/local/bin/*

WORKDIR /mnt/pwd

# setup
ENTRYPOINT ["/bin/sh", "-c", "\
    export $(grep -v '^#' .env | xargs) && \
    echo \"$KUBECONFIG_BASE64\" | base64 -d > /tmp/kubeconfig && \
    export KUBECONFIG=/tmp/kubeconfig && \
    exec \"$@\" \
    ", "--"]

CMD ["bash"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]

