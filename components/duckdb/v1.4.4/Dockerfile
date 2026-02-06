# DuckDB v1.4.4 CLI Image
#
# Base: Debian slim (DuckDB requires glibc, Alpine uses musl)

FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install DuckDB
RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
        x86_64)  ARCH_NAME="amd64" ;; \
        aarch64) ARCH_NAME="arm64" ;; \
        *)       ARCH_NAME="amd64" ;; \
    esac && \
    echo "Downloading DuckDB for ${ARCH_NAME}..." && \
    curl -fsSL "https://github.com/duckdb/duckdb/releases/download/v1.4.4/duckdb_cli-linux-${ARCH_NAME}.zip" -o /tmp/duckdb.zip && \
    unzip -o /tmp/duckdb.zip -d /tmp && \
    mv /tmp/duckdb /usr/local/bin/duckdb && \
    chmod +x /usr/local/bin/duckdb && \
    rm -rf /tmp/*

# Verify installation
RUN duckdb --version

# Default command
CMD ["/bin/bash"]
