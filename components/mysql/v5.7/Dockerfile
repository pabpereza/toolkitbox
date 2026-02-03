# Legacy MySQL 5.7 Client Image
#
# Base: Official MySQL 5.7 image (extracts only the client)
# Note: Using multi-stage to get only mysql client binaries

FROM mysql:5.7 AS source

FROM debian:bullseye-slim

# Copy MySQL client from official image
COPY --from=source /usr/bin/mysql /usr/bin/mysql
COPY --from=source /usr/bin/mysqldump /usr/bin/mysqldump
COPY --from=source /usr/bin/mysqlcheck /usr/bin/mysqlcheck
COPY --from=source /usr/bin/mysqladmin /usr/bin/mysqladmin

# Install required libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmysqlclient21 \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mysql --version

# Default command
CMD ["/bin/bash"]
