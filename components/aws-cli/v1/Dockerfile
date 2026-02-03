# Legacy AWS CLI v1 Image
#
# Base: Alpine with pip install for AWS CLI v1

FROM alpine:3.18

# Install AWS CLI v1 via pip
RUN apk add --no-cache \
    python3 \
    py3-pip \
    bash \
    groff \
    less \
    && pip3 install --no-cache-dir 'awscli>=1.0,<2.0' \
    && rm -rf /root/.cache

# Verify installation
RUN aws --version

# Default command
CMD ["/bin/bash"]
