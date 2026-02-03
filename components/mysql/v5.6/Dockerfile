# Legacy MySQL 5.6 Client Image
#
# Base: Official MySQL 5.6 image (extracts only the client)

FROM mysql:5.6 AS source

FROM debian:buster-slim

# Copy MySQL client and libraries from official image
COPY --from=source /usr/bin/mysql /usr/bin/mysql
COPY --from=source /usr/bin/mysqldump /usr/bin/mysqldump
COPY --from=source /usr/bin/mysqlcheck /usr/bin/mysqlcheck
COPY --from=source /usr/lib/x86_64-linux-gnu/libmysqlclient* /usr/lib/x86_64-linux-gnu/

# Install required libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    libc6 \
    zlib1g \
    libssl1.1 \
    && rm -rf /var/lib/apt/lists/* \
    && ldconfig

# Verify installation
RUN mysql --version

# Default command
CMD ["/bin/bash"]
