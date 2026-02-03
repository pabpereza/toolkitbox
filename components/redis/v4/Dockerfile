# Legacy Redis 4 Client Image
#
# Base: Alpine Linux 3.9 (for Redis 4 compatibility)

FROM alpine:3.9

# Install Redis 4 client
# Alpine 3.9 repositories contain Redis 4.x
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
