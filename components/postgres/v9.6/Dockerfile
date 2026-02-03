# Legacy PostgreSQL 9.6 Client Image
#
# Base: Official PostgreSQL 9.6 image (extracts only the client)

FROM postgres:9.6-alpine AS source

FROM alpine:3.18

# Copy PostgreSQL client from official image
COPY --from=source /usr/local/bin/psql /usr/local/bin/psql
COPY --from=source /usr/local/bin/pg_dump /usr/local/bin/pg_dump
COPY --from=source /usr/local/bin/pg_restore /usr/local/bin/pg_restore
COPY --from=source /usr/local/lib/libpq.so* /usr/local/lib/

# Install required libraries
RUN apk add --no-cache \
    libssl1.1 \
    libcrypto1.1 \
    bash \
    && ldconfig /usr/local/lib || true

# Verify installation
RUN psql --version

# Default command
CMD ["/bin/bash"]
