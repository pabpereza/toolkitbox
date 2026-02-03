# MariaDB Client

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/pabpereza/toolkitbox)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/mariadb?logo=docker)](https://hub.docker.com/r/toolkitbox/mariadb)

Command line client for MariaDB/MySQL.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/mariadb:latest \
  mariadb -h my-server.com -u root -p

# Run single query
docker run --rm \
  ghcr.io/pabpereza/toolkitbox/mariadb:latest \
  mariadb -h my-server.com -u root -pPASSWORD -e "SHOW DATABASES;"
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mariadb-client
spec:
  containers:
  - name: mariadb-client
    image: ghcr.io/pabpereza/toolkitbox/mariadb:latest
    command: ["sleep", "infinity"]
    env:
    - name: MYSQL_HOST
      value: "mariadb-service"
    - name: MYSQL_USER
      value: "root"
    - name: MYSQL_PWD
      valueFrom:
        secretKeyRef:
          name: mariadb-credentials
          key: password
```

---

## Description

MariaDB Client (`mariadb` / `mysql`) is the command line tool for connecting to MariaDB and MySQL servers. It allows you to execute SQL queries, manage databases, import/export data, and manage users.

## Installation

This component installs `mariadb-client` from the Alpine Linux repositories.

## Basic Usage

### Connect to a server
```bash
mariadb -h hostname -u user -p
```

### Connect specifying database
```bash
mariadb -h hostname -u user -p database_name
```

### Execute direct query
```bash
mariadb -h hostname -u user -p -e "SELECT * FROM table"
```

### Import SQL file
```bash
mariadb -h hostname -u user -p database < backup.sql
```

### Export database (dump)
```bash
mariadb-dump -h hostname -u user -p database > backup.sql
```

### Export structure only
```bash
mariadb-dump -h hostname -u user -p --no-data database > schema.sql
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

## Available Legacy Versions

- `v10.3` - MariaDB 10.3
- `v10.4` - MariaDB 10.4

## Official Documentation

- [MariaDB Client](https://mariadb.com/kb/en/mariadb-command-line-client/)
- [mariadb-dump](https://mariadb.com/kb/en/mariadb-dump/)

