# Legacy MariaDB 10.3 Client Image
#
# Base: Official MariaDB 10.3 image

FROM mariadb:10.3

# Remove server components to reduce size, keep only client
RUN rm -f /usr/sbin/mariadbd /usr/sbin/mysqld /docker-entrypoint.sh 2>/dev/null || true

# Verify installation
RUN mysql --version

# Default command
CMD ["/bin/bash"]
