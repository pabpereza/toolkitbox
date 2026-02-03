# Legacy MySQL 5.7 Client Image
#
# Base: Official MySQL 5.7 image

FROM mysql:5.7

# Remove server components to reduce size, keep only client
RUN rm -f /usr/sbin/mysqld /docker-entrypoint.sh 2>/dev/null || true

# Verify installation
RUN mysql --version

# Default command
CMD ["/bin/bash"]
