# Legacy MySQL 5.7 Client Image
#
# Base: Debian Buster Slim (MySQL 5.7 client compatibility)
# Note: Alpine's mysql-client is actually MariaDB, using Debian for authentic MySQL

FROM debian:buster-slim

# Install MySQL 5.7 client from MySQL APT repository
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg \
    curl \
    ca-certificates \
    lsb-release \
    && curl -fsSL https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 | gpg --dearmor -o /usr/share/keyrings/mysql.gpg \
    && echo "deb [ signed-by=/usr/share/keyrings/mysql.gpg ] http://repo.mysql.com/apt/debian/ buster mysql-5.7" | tee /etc/apt/sources.list.d/mysql.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    mysql-community-client \
    && apt-get purge -y gnupg lsb-release \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mysql --version

# Default command
CMD ["/bin/bash"]
