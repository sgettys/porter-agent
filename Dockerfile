ARG PORTER_VERSION
ARG KUBERNETES_PLUGIN_VERSION
FROM debian:buster-slim as builder
RUN apt-get update && apt-get install -y curl
RUN curl https://cdn.porter.sh/plugins/kubernetes/$KUBERNETES_PLUGIN_VERSION/kubernetes-linux-amd64 -o /tmp/kubernetes
FROM ghcr.io/getporter/porter-agent:$PORTER_VERSION
COPY --chown=65535:0 --chmod=770 --from=builder /tmp/kubernetes /app/.porter/plugins/kubernetes/kubernetes
