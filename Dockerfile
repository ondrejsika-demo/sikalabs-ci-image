FROM debian:9
MAINTAINER Ondrej Sika <ondrej@ondrejsika.com>
RUN apt update && apt install -y \
    openssh-client sshpass \
    curl \
    wget \
    git
COPY sshx /usr/local/bin/
ENV DOCKERVERSION=17.12.0-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && mv docker-${DOCKERVERSION}.tgz docker.tgz \
  && tar xzvf docker.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker.tgz
RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN base=https://github.com/docker/machine/releases/download/v0.14.0 && \
    curl -L $base/docker-machine-$(uname -s)-$(uname -m) > /tmp/docker-machine && \
    install /tmp/docker-machine /usr/local/bin/docker-machine

# Minio CLient (mc -> mcli)
RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc && \
    mv mc /usr/local/bin/mcli && \
    chmod +x /usr/local/bin/mcli
