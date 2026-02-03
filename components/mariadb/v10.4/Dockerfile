# Legacy MariaDB 10.4 Client Image
#
# Base: Alpine Linux 3.12 (for MariaDB 10.4 compatibility)

FROM alpine:3.12

# Install MariaDB 10.4 client
# Alpine 3.12 repositories contain MariaDB 10.4
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
