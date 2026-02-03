# Legacy MariaDB 10.3 Client Image
#
# Base: Official MariaDB 10.3 image (extracts only the client)

FROM mariadb:10.3 AS source

FROM debian:bullseye-slim

# Copy MariaDB client from official image
COPY --from=source /usr/bin/mysql /usr/bin/mysql
COPY --from=source /usr/bin/mysqldump /usr/bin/mysqldump
COPY --from=source /usr/bin/mysqlcheck /usr/bin/mysqlcheck
COPY --from=source /usr/bin/mysqladmin /usr/bin/mysqladmin

# Install required libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmariadb3 \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mysql --version

# Default command
CMD ["/bin/bash"]
