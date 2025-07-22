# syntax=docker/dockerfile:1
# Dockerfile for deploying a production Ruby on Rails app

# Match this with your `.ruby-version`
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Install essential runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test

# =======================================
# ⏳ Build Stage
# =======================================
FROM base AS build

# Install build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libpq-dev \
    libyaml-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ /usr/local/bundle/ruby/*/cache \
    /usr/local/bundle/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application files
COPY . .

# Precompile app code
RUN bundle exec bootsnap precompile app/ lib/

# ✅ Inject secret key for asset precompilation
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY
RUN ./bin/rails assets:precompile

# =======================================
# 🚀 Final Production Stage
# =======================================
FROM base

# Copy built gems and app code
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Setup non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

# Entrypoint and startup command
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server"]
