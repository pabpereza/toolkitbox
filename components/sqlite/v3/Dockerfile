# SQLite3 CLI Image
#
# Base: Alpine Linux with SQLite3

FROM alpine:3.18

# Install SQLite3 and bash
RUN apk add --no-cache sqlite bash

# Verify installation
RUN sqlite3 --version

# Default command
CMD ["/bin/bash"]
