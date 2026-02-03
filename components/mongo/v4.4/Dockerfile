# Legacy MongoDB 4.4 Client Image
#
# Base: Debian Slim (MongoDB shell requires glibc)
# Note: Alpine uses musl, MongoDB binaries require glibc

FROM debian:buster-slim

ENV MONGO_VERSION=4.4

# Install MongoDB 4.4 shell
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg \
    curl \
    ca-certificates \
    && curl -fsSL https://pgp.mongodb.com/server-${MONGO_VERSION}.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-server-${MONGO_VERSION}.gpg \
    && echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-${MONGO_VERSION}.gpg ] http://repo.mongodb.org/apt/debian buster/mongodb-org/${MONGO_VERSION} main" | tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    mongodb-org-shell \
    && apt-get purge -y gnupg \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mongo --version

# Default command
CMD ["/bin/bash"]
