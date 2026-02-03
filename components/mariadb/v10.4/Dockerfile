# Legacy MariaDB 10.4 Client Image
#
# Base: Official MariaDB 10.4 image

FROM mariadb:10.4

# Remove server components to reduce size, keep only client
RUN rm -f /usr/sbin/mariadbd /usr/sbin/mysqld /docker-entrypoint.sh 2>/dev/null || true

# Verify installation
RUN mysql --version

# Default command
CMD ["/bin/bash"]
