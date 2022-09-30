# FROM mcr.microsoft.com/azure-cli:2.9.1
FROM mcr.microsoft.com/azure-cli

RUN apk add --no-cache \
  gettext \
  jq

ARG HELM_VERSION=v3.6.3

RUN curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

RUN mkdir -p /tmp/helm/ \
  && curl -fsSL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar -xzvC /tmp/helm/ --strip-components=1 \
  && cp /tmp/helm/helm /usr/local/bin/helm \
  && rm -rf /tmp/helm

RUN curl -fsSL https://github.com/mikefarah/yq/releases/download/v4.12.2/yq_linux_amd64 -o /usr/local/bin/yq \
  && chmod +x /usr/local/bin/yq

WORKDIR /gitpod

COPY . /gitpod

ENTRYPOINT ["/gitpod/setup.sh"]
