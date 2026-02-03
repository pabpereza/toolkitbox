# MySQL Client

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/pabpereza/toolkitbox)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/mysql?logo=docker)](https://hub.docker.com/r/toolkitbox/mysql)

Command line client for MySQL.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/mysql:latest \
  mysql -h my-server.com -u root -p

# Run single query
docker run --rm \
  ghcr.io/pabpereza/toolkitbox/mysql:latest \
  mysql -h my-server.com -u root -pPASSWORD -e "SHOW DATABASES;"
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql-client
spec:
  containers:
  - name: mysql-client
    image: ghcr.io/pabpereza/toolkitbox/mysql:latest
    command: ["sleep", "infinity"]
    env:
    - name: MYSQL_HOST
      value: "mysql-service"
    - name: MYSQL_USER
      value: "root"
    - name: MYSQL_PWD
      valueFrom:
        secretKeyRef:
          name: mysql-credentials
          key: password
```

---

## Description

MySQL Client (`mysql`) is the official command line tool for connecting to MySQL servers. It allows you to execute interactive SQL queries, scripts, and perform database administration tasks.

## Installation

This component installs `mysql-client` from the Alpine Linux repositories.

## Basic Usage

### Connect to a server
```bash
mysql -h hostname -u user -p
```

### Connect specifying database
```bash
mysql -h hostname -u user -p database_name
```

### Execute direct query
```bash
mysql -h hostname -u user -p -e "SHOW DATABASES;"
```

### Import SQL file
```bash
mysql -h hostname -u user -p database < backup.sql
```

### Export database
```bash
mysqldump -h hostname -u user -p database > backup.sql
```

### Export all databases
```bash
mysqldump -h hostname -u user -p --all-databases > full_backup.sql
```

### Export structure only (no data)
```bash
mysqldump -h hostname -u user -p --no-data database > schema.sql
```

## Common Options

| Option | Description |
|--------|-------------|
| `-h, --host` | Server to connect to |
| `-P, --port` | Port (default: 3306) |
| `-u, --user` | Connection user |
| `-p, --password` | Prompt for password |
| `-D, --database` | Database to select |
| `-e, --execute` | Execute command and exit |
| `-N, --skip-column-names` | Don't show column names |
| `-B, --batch` | Batch mode (no table formatting) |

## Useful Client Commands

```sql
-- Show databases
SHOW DATABASES;

-- Use database
USE database_name;

-- Show tables
SHOW TABLES;

-- Describe table structure
DESCRIBE table_name;

-- Show active processes
SHOW PROCESSLIST;

-- View server variables
SHOW VARIABLES LIKE '%max_connections%';
```

## Available Legacy Versions

- `v5.6` - MySQL 5.6
- `v5.7` - MySQL 5.7

## Official Documentation

- [MySQL Command-Line Client](https://dev.mysql.com/doc/refman/8.0/en/mysql.html)
- [mysqldump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html)

