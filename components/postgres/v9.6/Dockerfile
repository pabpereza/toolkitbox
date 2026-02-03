# Legacy PostgreSQL 9.6 Client Image
#
# Base: Official PostgreSQL 9.6 Alpine image

FROM postgres:9.6-alpine

# Remove server components to reduce size, keep only client
RUN rm -f /usr/local/bin/postgres /usr/local/bin/initdb /docker-entrypoint.sh 2>/dev/null || true

# Verify installation
RUN psql --version

# Default command
CMD ["/bin/bash"]
