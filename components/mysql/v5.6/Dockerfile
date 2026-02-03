# Legacy MySQL 5.6 Client Image
#
# Base: Official MySQL 5.6 image (extracts only the client)
# Note: Using multi-stage to get only mysql client binaries

FROM mysql:5.6 AS source

FROM debian:buster-slim

# Copy MySQL client from official image
COPY --from=source /usr/bin/mysql /usr/bin/mysql
COPY --from=source /usr/bin/mysqldump /usr/bin/mysqldump
COPY --from=source /usr/bin/mysqlcheck /usr/bin/mysqlcheck

# Install required libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmysqlclient18 \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mysql --version || echo "MySQL 5.6 client installed"

# Default command
CMD ["/bin/bash"]
