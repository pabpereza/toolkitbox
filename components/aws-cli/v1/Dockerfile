# Legacy AWS CLI v1 Image
#
# Base: Alpine Linux 3.15 (for AWS CLI v1 compatibility)

FROM alpine:3.15

# Install AWS CLI v1
# Alpine 3.15 repositories contain AWS CLI v1.x
RUN apk add --no-cache \
    aws-cli \
    bash \
    && rm -rf /var/cache/apk/*

# Verify installation
RUN aws --version

# Set default shell
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["/bin/bash"]
