# Legacy Redis 5 Client Image
#
# Base: Alpine Linux 3.12 (for Redis 5 compatibility)

FROM alpine:3.12

# Install Redis 5 client
# Alpine 3.12 repositories contain Redis 5.x
RUN apk add --no-cache \
    redis \
    bash \
    && rm -rf /var/cache/apk/*

# Verify installation
RUN redis-cli --version

# Set default shell
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["/bin/bash"]
