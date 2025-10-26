ARG CRYSTAL_VERSION=1.18.2
ARG LUCKY_ENV

# Install the application Crystal dependencies
FROM crystallang/crystal:$CRYSTAL_VERSION as crystal_dependencies
WORKDIR /shards
ENV LUCKY_ENV=$LUCKY_ENV
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  gnupg2 \
  cmake
ENV SKIP_LUCKY_TASK_PRECOMPILATION=1
COPY shard.yml shard.lock ./
RUN  shards install --production

# Install the application Yarn dependencies, then compile production CSS/JS
FROM node:alpine as frontend_build
WORKDIR /frontend
COPY . .
RUN npm install && npm build

# Build the webserver binary
FROM crystallang/crystal:$CRYSTAL_VERSION as lucky_binaries_build
WORKDIR /binaries_build
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  gnupg2
ENV LUCKY_ENV=$LUCKY_ENV
COPY . .
COPY --from=crystal_dependencies /shards/lib lib
COPY --from=frontend_build /frontend/public public
RUN shards build --production --release \
  && mv ./bin/app /usr/local/bin/webserver \
  && chmod +x /usr/local/bin/webserver

# Create the release scripts
FROM alpine:3.20 as release_script_build
RUN echo "#!/bin/sh" >> /usr/local/bin/release \
  && echo "./webserver" >> /usr/local/bin/release \
  && chmod +x /usr/local/bin/release
RUN echo "#!/bin/sh" >> /usr/local/bin/healthcheck \
  && echo "curl --fail localhost:5000/ops/health" >> /usr/local/bin/healthcheck \
  && chmod +x /usr/local/bin/healthcheck

# Serve the application binary
FROM ubuntu:24.04 as webserver
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  gnupg2 \
  curl \
  ca-certificates \
  libc6-dev \
  libevent-dev \
  libpcre2-dev \
  libpcre3-dev \
  libpng-dev \
  libssl-dev \
  libxml2-dev \
  libyaml-dev \
  zlib1g-dev \
  tzdata \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log
WORKDIR /app
COPY --from=release_script_build /usr/local/bin/release release
COPY --from=release_script_build /usr/local/bin/healthcheck healthcheck
COPY --from=lucky_binaries_build /usr/local/bin/webserver webserver
COPY --from=frontend_build /frontend/public public
COPY ./config/watch.yml config/
CMD ["./release"]

# Health check for zero-downtime deploys
HEALTHCHECK \
  --interval=20s --retries=5 \
  CMD ./healthcheck || exit 1

