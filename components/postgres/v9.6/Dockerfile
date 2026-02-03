# Legacy PostgreSQL 9.6 Client Image
#
# Base: Alpine Linux 3.6 (for PostgreSQL 9.6 compatibility)

FROM alpine:3.6

# Install PostgreSQL 9.6 client
# Alpine 3.6 repositories contain PostgreSQL 9.6
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
