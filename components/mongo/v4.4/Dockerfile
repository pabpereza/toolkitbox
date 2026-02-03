# Legacy MongoDB 4.4 Client Image
#
# Base: Official MongoDB 4.4 image

FROM mongo:4.4

# Remove server components to reduce size, keep only client tools
RUN rm -f /usr/bin/mongod /usr/bin/mongos /docker-entrypoint.sh 2>/dev/null || true

# Verify installation
RUN mongo --version

# Default command
CMD ["/bin/bash"]
