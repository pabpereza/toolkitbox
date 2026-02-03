# Legacy PostgreSQL 10 Client Image
#
# Base: Alpine Linux 3.8 (for PostgreSQL 10 compatibility)

FROM alpine:3.8

# Install PostgreSQL 10 client
# Alpine 3.8 repositories contain PostgreSQL 10
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
