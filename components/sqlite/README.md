# SQLite3 Client

[![GitHub Stars](https://img.shields.io/github/stars/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox)
[![GitHub Issues](https://img.shields.io/github/issues/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox/issues)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/sqlite?logo=docker)](https://hub.docker.com/r/toolkitbox/sqlite)

> 📢 **Found an issue or want to request a new tool?** [Open an issue on GitHub](https://github.com/pabpereza/toolkitbox/issues)

Command line interface for SQLite3.

## Quick Start

### Docker
```bash
# Interactive mode with a database file
docker run -it --rm \
  -v $(pwd):/data \
  ghcr.io/pabpereza/toolkitbox/sqlite:latest \
  sqlite3 /data/mydatabase.db

# Execute single query
docker run --rm \
  -v $(pwd):/data \
  ghcr.io/pabpereza/toolkitbox/sqlite:latest \
  sqlite3 /data/mydatabase.db "SELECT * FROM users;"

# Create in-memory database for testing
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/sqlite:latest \
  sqlite3 :memory:
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sqlite-client
spec:
  containers:
  - name: sqlite-client
    image: ghcr.io/pabpereza/toolkitbox/sqlite:latest
    command: ["sleep", "infinity"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: sqlite-data
```

---

## Description

SQLite3 (`sqlite3`) is the official command line interface for interacting with SQLite databases. It allows you to create, query, and manage SQLite database files, execute SQL commands, and perform data import/export operations.

## Installation

This component installs `sqlite` from the Alpine Linux repositories.

## Basic Usage

### Open or create a database
```bash
sqlite3 mydatabase.db
```

### Open database in read-only mode
```bash
sqlite3 -readonly mydatabase.db
```

### Execute command and exit
```bash
sqlite3 mydatabase.db "SELECT * FROM users;"
```

### Execute SQL from file
```bash
sqlite3 mydatabase.db < script.sql
```

### Use in-memory database
```bash
sqlite3 :memory:
```

## Useful Commands

### Table operations
```sql
-- Create table
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE
);

-- Insert data
INSERT INTO users (name, email) VALUES ('John', 'john@example.com');

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
.tables

-- Show table schema
.schema users

-- Describe table structure
PRAGMA table_info(users);

-- Show all indexes
.indexes
```

### Data import/export
```bash
# Export to CSV
sqlite3 -header -csv mydatabase.db "SELECT * FROM users;" > users.csv

# Import from CSV
sqlite3 mydatabase.db
.mode csv
.import users.csv users

# Dump database to SQL
sqlite3 mydatabase.db .dump > backup.sql

# Restore from SQL dump
sqlite3 newdatabase.db < backup.sql
```

## Common Options

| Option | Description |
|--------|-------------|
| `-header` | Show column headers |
| `-csv` | Output in CSV format |
| `-json` | Output in JSON format |
| `-line` | Output one value per line |
| `-column` | Output in column format |
| `-readonly` | Open database in read-only mode |
| `-cmd` | Run command before reading stdin |
| `-init` | Read and execute commands from file |

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
.mode column
.mode line

# Enable headers
.headers on

# Open another database
.open another.db

# Attach database
ATTACH DATABASE 'other.db' AS other;

# Show current settings
.show

# Exit
.exit
```

## Output Modes

```bash
# CSV format
.mode csv
SELECT * FROM users;

# JSON format
.mode json
SELECT * FROM users;

# Column format (pretty table)
.mode column
.headers on
SELECT * FROM users;

# Line format (one value per line)
.mode line
SELECT * FROM users;
```

## Official Documentation

- [SQLite CLI Documentation](https://www.sqlite.org/cli.html)
- [SQLite SQL Syntax](https://www.sqlite.org/lang.html)

