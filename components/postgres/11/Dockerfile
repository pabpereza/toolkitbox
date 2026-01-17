# Legacy PostgreSQL 11 Image
# This Dockerfile demonstrates version isolation for legacy tools
# that require older base images or specific configurations.
#
# Base: Alpine Linux 3.10 (for PostgreSQL 11 compatibility)

FROM alpine:3.10

# Install PostgreSQL 11 client
# Alpine 3.10 repositories contain PostgreSQL 11
RUN apk add --no-cache \
    postgresql-client \
    bash \
    && rm -rf /var/cache/apk/*

# Verify installation
RUN psql --version

# Set default shell
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["/bin/bash"]
