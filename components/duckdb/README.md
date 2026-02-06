# DuckDB

[![GitHub Stars](https://img.shields.io/github/stars/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox)
[![GitHub Issues](https://img.shields.io/github/issues/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox/issues)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/duckdb?logo=docker)](https://hub.docker.com/r/toolkitbox/duckdb)

> 📢 **Found an issue or want to request a new tool?** [Open an issue on GitHub](https://github.com/pabpereza/toolkitbox/issues)

Fast in-process analytical database with SQL support.

## Quick Start

### Docker
```bash
# Interactive mode with a database file
docker run -it --rm \
  -v $(pwd):/data \
  ghcr.io/pabpereza/toolkitbox/duckdb:latest \
  duckdb /data/mydatabase.duckdb

# Execute single query
docker run --rm \
  -v $(pwd):/data \
  ghcr.io/pabpereza/toolkitbox/duckdb:latest \
  duckdb /data/mydatabase.duckdb "SELECT * FROM users;"

# Create in-memory database for testing
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/duckdb:latest \
  duckdb
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: duckdb-client
spec:
  containers:
  - name: duckdb-client
    image: ghcr.io/pabpereza/toolkitbox/duckdb:latest
    command: ["sleep", "infinity"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: duckdb-data
```

---

## Description

DuckDB (`duckdb`) is an in-process SQL OLAP database management system. It is designed for analytical workloads and provides fast execution of complex queries on large datasets. DuckDB supports a rich SQL dialect, including window functions, common table expressions (CTEs), and complex aggregations.

Key features:
- **Columnar storage** for efficient analytical queries
- **Vectorized query execution** for high performance
- **Zero dependencies** - single binary
- **Direct Parquet, CSV, and JSON support**
- **PostgreSQL-compatible SQL syntax**

## Installation

This component downloads the official DuckDB CLI binary from GitHub releases for the detected architecture (amd64/aarch64).

## Basic Usage

### Open or create a database
```bash
duckdb mydatabase.duckdb
```

### Open database in read-only mode
```bash
duckdb -readonly mydatabase.duckdb
```

### Execute command and exit
```bash
duckdb mydatabase.duckdb "SELECT * FROM users;"
```

### Use in-memory database
```bash
duckdb
```

### Execute SQL from file
```bash
duckdb mydatabase.duckdb < script.sql
```

## Working with Files

### Query CSV files directly
```sql
SELECT * FROM read_csv_auto('data.csv');

-- Create table from CSV
CREATE TABLE users AS SELECT * FROM read_csv_auto('users.csv');
```

### Query Parquet files
```sql
SELECT * FROM read_parquet('data.parquet');

-- Export to Parquet
COPY users TO 'users.parquet' (FORMAT PARQUET);
```

### Query JSON files
```sql
SELECT * FROM read_json_auto('data.json');
```

### Query remote files
```sql
-- Query CSV from URL
SELECT * FROM read_csv_auto('https://example.com/data.csv');

-- Query Parquet from S3
SELECT * FROM read_parquet('s3://bucket/data.parquet');
```

## Useful Commands

### Table operations
```sql
-- Create table
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR UNIQUE,
    created_at TIMESTAMP DEFAULT current_timestamp
);

-- Insert data
INSERT INTO users (id, name, email) VALUES (1, 'John', 'john@example.com');

-- Select data
SELECT * FROM users;

-- Update data
UPDATE users SET name = 'Jane' WHERE id = 1;

-- Delete data
DELETE FROM users WHERE id = 1;
```

### Schema inspection
```sql
-- Show all tables
SHOW TABLES;

-- Describe table structure
DESCRIBE users;

-- Show table schema
.schema users
```

### Data import/export
```bash
# Export to CSV
duckdb mydatabase.duckdb "COPY users TO 'users.csv' (HEADER, DELIMITER ',');"

# Export to Parquet
duckdb mydatabase.duckdb "COPY users TO 'users.parquet' (FORMAT PARQUET);"

# Import from CSV
duckdb mydatabase.duckdb "CREATE TABLE users AS SELECT * FROM read_csv_auto('users.csv');"
```

## Common Options

| Option | Description |
|--------|-------------|
| `-readonly` | Open database in read-only mode |
| `-cmd` | Run SQL command before entering interactive mode |
| `-c` | Run SQL command and exit |
| `-json` | Output results in JSON format |
| `-csv` | Output results in CSV format |
| `-line` | Output results in line format |
| `-box` | Output results in box format |
| `-init` | Read and execute commands from file on startup |

## Dot Commands

```bash
# Show help
.help

# Show tables
.tables

# Show schema
.schema

# Change output mode
.mode csv
.mode json
.mode line
.mode box

# Enable headers
.headers on

# Open another database
.open another.duckdb

# Show current settings
.show

# Exit
.exit
```

## Analytical Functions

```sql
-- Window functions
SELECT 
    name,
    department,
    salary,
    AVG(salary) OVER (PARTITION BY department) as dept_avg,
    RANK() OVER (ORDER BY salary DESC) as salary_rank
FROM employees;

-- Common Table Expressions (CTEs)
WITH monthly_sales AS (
    SELECT date_trunc('month', sale_date) as month, SUM(amount) as total
    FROM sales
    GROUP BY 1
)
SELECT * FROM monthly_sales ORDER BY month;

-- PIVOT
PIVOT sales ON product USING SUM(amount);
```

## Official Documentation

- [DuckDB Documentation](https://duckdb.org/docs/)
- [DuckDB SQL Reference](https://duckdb.org/docs/sql/introduction)
- [DuckDB CLI Reference](https://duckdb.org/docs/api/cli)
- [DuckDB GitHub](https://github.com/duckdb/duckdb)
