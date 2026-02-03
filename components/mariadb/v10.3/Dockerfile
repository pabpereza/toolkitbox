# Legacy MariaDB 10.3 Client Image
#
# Base: Alpine Linux 3.10 (for MariaDB 10.3 compatibility)

FROM alpine:3.10

# Install MariaDB 10.3 client
# Alpine 3.10 repositories contain MariaDB 10.3
RUN apk add --no-cache \
    mariadb-client \
    bash \
    && rm -rf /var/cache/apk/*

# Verify installation
RUN mysql --version

# Set default shell
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["/bin/bash"]
