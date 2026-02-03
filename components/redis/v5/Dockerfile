# Legacy Redis 5 Client Image
#
# Base: Official Redis 5 image (extracts only the client)

FROM redis:5-alpine AS source

FROM alpine:3.18

# Copy Redis client from official image
COPY --from=source /usr/local/bin/redis-cli /usr/local/bin/redis-cli

# Install bash
RUN apk add --no-cache bash

# Verify installation
RUN redis-cli --version

# Default command
CMD ["/bin/bash"]
