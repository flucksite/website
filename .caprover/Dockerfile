ARG RUBY_VERSION=4.0.3
ARG BUN_VERSION=1

# --- Stage 1: install gems + node bin (Bun) ---
FROM ruby:${RUBY_VERSION}-slim AS build
WORKDIR /app
ARG BUN_VERSION
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    libyaml-dev \
    unzip \
  && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://bun.sh/install | bash -s "bun-v${BUN_VERSION}"
ENV PATH="/root/.bun/bin:$PATH"

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test cli' \
  && bundle config set --local deployment 'true' \
  && bundle install --jobs=4 --retry=3

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY . .
RUN bundle exec bun_bun_bundle build --prod

# --- Stage 2: minimal runtime ---
FROM ruby:${RUBY_VERSION}-slim AS webserver
ENV HANAMI_ENV=production \
    BUNDLE_WITHOUT="development:test:cli" \
    BUNDLE_DEPLOYMENT=true \
    HANAMI_PORT=80
WORKDIR /app
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    curl \
    libyaml-0-2 \
    tzdata \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /app /app

EXPOSE 80
HEALTHCHECK --interval=20s --retries=5 \
  CMD curl --fail http://localhost:${HANAMI_PORT}/ops/health || exit 1
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
