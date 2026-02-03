# Legacy MongoDB 3.6 Client Image
#
# Base: Official MongoDB 3.6 image

FROM mongo:3.6

# Remove server components to reduce size, keep only client tools
RUN rm -f /usr/bin/mongod /usr/bin/mongos /docker-entrypoint.sh 2>/dev/null || true

# Verify installation
RUN mongo --version

# Default command
CMD ["/bin/bash"]
