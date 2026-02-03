# Legacy MySQL 5.6 Client Image
#
# Base: Debian Jessie Slim (MySQL 5.6 client compatibility)
# Note: MySQL 5.6 requires older Debian version

FROM debian:jessie-slim

# Install MySQL 5.6 client
RUN apt-get update && apt-get install -y --no-install-recommends \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mysql --version

# Default command
CMD ["/bin/bash"]
