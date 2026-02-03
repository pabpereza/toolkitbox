# PostgreSQL Client

[![GitHub Stars](https://img.shields.io/github/stars/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox)
[![GitHub Issues](https://img.shields.io/github/issues/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox/issues)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/postgres?logo=docker)](https://hub.docker.com/r/toolkitbox/postgres)

> 📢 **Found an issue or want to request a new tool?** [Open an issue on GitHub](https://github.com/pabpereza/toolkitbox/issues)

Command line client for PostgreSQL.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  -e PGPASSWORD=my_password \
  ghcr.io/pabpereza/toolkitbox/postgres:latest \
  psql -h my-server.com -U postgres -d my_database

# Run single query
docker run --rm \
  -e PGPASSWORD=my_password \
  ghcr.io/pabpereza/toolkitbox/postgres:latest \
  psql -h my-server.com -U postgres -d my_database -c "SELECT version();"
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: postgres-client
spec:
  containers:
  - name: postgres-client
    image: ghcr.io/pabpereza/toolkitbox/postgres:latest
    command: ["sleep", "infinity"]
    env:
    - name: PGHOST
      value: "postgres-service"
    - name: PGUSER
      value: "postgres"
    - name: PGPASSWORD
      valueFrom:
        secretKeyRef:
          name: postgres-credentials
          key: password
    - name: PGDATABASE
      value: "mydb"
```

---

## Description

PostgreSQL Client includes `psql`, the interactive terminal tool for PostgreSQL, along with additional utilities like `pg_dump`, `pg_restore`, and `pg_isready`. It allows you to execute SQL queries, manage databases, and perform backups.

## Installation

This component installs `postgresql-client` from the Alpine Linux repositories.

## Basic Usage

### Connect to a server
```bash
psql -h hostname -U user -d database
```

### Connect using URI
```bash
psql "postgresql://user:password@hostname:5432/database"
```

### Execute direct query
```bash
psql -h hostname -U user -d database -c "SELECT * FROM table"
```

### Execute SQL script
```bash
psql -h hostname -U user -d database -f script.sql
```

### Export database (backup)
```bash
pg_dump -h hostname -U user database > backup.sql
```

### Export in custom format (compressed)
```bash
pg_dump -h hostname -U user -Fc database > backup.dump
```

### Restore backup
```bash
pg_restore -h hostname -U user -d database backup.dump
```

### Check connectivity
```bash
pg_isready -h hostname -p 5432
```

## Useful psql Commands

```sql
-- List databases
\l

-- Connect to another database
\c database_name

-- List tables
\dt

-- Describe table
\d table_name

-- List users
\du

-- Show command help
\?

-- Execute system command
\! ls -la

-- Quit
\q
```

## Common Options

| Option | Description |
|--------|-------------|
| `-h, --host` | Server to connect to |
| `-p, --port` | Port (default: 5432) |
| `-U, --username` | Connection user |
| `-d, --dbname` | Database to select |
| `-c, --command` | Execute SQL command and exit |
| `-f, --file` | Execute commands from file |
| `-W, --password` | Force password prompt |

## Environment Variables

| Variable | Description |
|----------|-------------|
| `PGHOST` | Server host |
| `PGPORT` | Server port |
| `PGUSER` | Connection user |
| `PGPASSWORD` | Password (not recommended in production) |
| `PGDATABASE` | Default database |

## Available Legacy Versions

- `v9.6` - PostgreSQL 9.6
- `v10` - PostgreSQL 10
- `v11` - PostgreSQL 11

## Official Documentation

- [psql - PostgreSQL Interactive Terminal](https://www.postgresql.org/docs/current/app-psql.html)
- [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html)
- [pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html)