# Legacy MongoDB 3.6 Client Image
#
# Base: Official MongoDB 3.6 image (extracts only the shell)
# Note: Using multi-stage to get only mongo shell binary

FROM mongo:3.6 AS source

FROM debian:buster-slim

# Copy MongoDB shell from official image
COPY --from=source /usr/bin/mongo /usr/bin/mongo
COPY --from=source /usr/bin/mongodump /usr/bin/mongodump
COPY --from=source /usr/bin/mongorestore /usr/bin/mongorestore

# Install required libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4 \
    libssl1.1 \
    && rm -rf /var/lib/apt/lists/*

# Verify installation
RUN mongo --version

# Default command
CMD ["/bin/bash"]
