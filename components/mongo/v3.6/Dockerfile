# Legacy MongoDB 3.6 Client Image
#
# Base: Official MongoDB 3.6 image (extracts only the shell)

FROM mongo:3.6 AS source

FROM debian:stretch-slim

# Copy MongoDB tools from official image
COPY --from=source /usr/bin/mongo /usr/bin/mongo
COPY --from=source /usr/bin/mongodump /usr/bin/mongodump
COPY --from=source /usr/bin/mongorestore /usr/bin/mongorestore

# Install required libraries (stretch has compatible versions)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl3 \
    libssl1.0.2 \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mongo --version

# Default command
CMD ["/bin/bash"]
