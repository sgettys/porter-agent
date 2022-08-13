ARG PORTER_VERSION
FROM debian:buster-slim as builder
ARG KUBERNETES_PLUGIN_VERSION
ARG TERRAFORM_MIXIN_VERSION
RUN apt-get update && apt-get install -y curl
RUN curl -L https://cdn.porter.sh/plugins/kubernetes/${KUBERNETES_PLUGIN_VERSION}/kubernetes-linux-amd64 -o /tmp/kubernetes
RUN curl -L https://cdn.porter.sh/mixins/terraform/${TERRAFORM_MIXIN_VERSION}/terraform-linux-amd64 -o /tmp/terraform
FROM ghcr.io/getporter/porter-agent:$PORTER_VERSION
COPY --chown=65535:0 --chmod=770 --from=builder /tmp/kubernetes /app/.porter/plugins/kubernetes/kubernetes
COPY --chown=65535:0 --chmod=770 --from=builder /tmp/terraform /app/.porter/mixins/terraform/terraform
