# Legacy MongoDB 3.6 Client Image
#
# Base: Debian Stretch Slim (MongoDB 3.6 requires older Debian)
# Note: Alpine uses musl, MongoDB binaries require glibc

FROM debian:stretch-slim

ENV MONGO_VERSION=3.6

# Install MongoDB 3.6 shell
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg \
    curl \
    ca-certificates \
    apt-transport-https \
    && curl -fsSL https://pgp.mongodb.com/server-${MONGO_VERSION}.asc | apt-key add - \
    && echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/${MONGO_VERSION} main" | tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    mongodb-org-shell \
    && apt-get purge -y gnupg apt-transport-https \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mongo --version

# Default command
CMD ["/bin/bash"]
