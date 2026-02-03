# Databases Bundle

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/pabpereza/toolkitbox)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/databases?logo=docker)](https://hub.docker.com/r/toolkitbox/databases)

All-in-one bundle with database client tools for PostgreSQL, MySQL, MariaDB, MongoDB, and Redis.

## Quick Start

### Docker
```bash
# Interactive mode with shell access
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/databases:latest \
  sh

# Connect to PostgreSQL
docker run -it --rm \
  -e PGPASSWORD=my_password \
  ghcr.io/pabpereza/toolkitbox/databases:latest \
  psql -h my-server.com -U postgres -d my_database

# Connect to MySQL
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/databases:latest \
  mysql -h my-server.com -u root -p

# Connect to Redis
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/databases:latest \
  redis-cli -h my-server.com

# Connect to MongoDB
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/databases:latest \
  mongosh "mongodb://my-server.com:27017"
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: databases-client
spec:
  containers:
  - name: databases-client
    image: ghcr.io/pabpereza/toolkitbox/databases:latest
    command: ["sleep", "infinity"]
    env:
    # PostgreSQL
    - name: PGHOST
      value: "postgres-service"
    - name: PGUSER
      value: "postgres"
    - name: PGPASSWORD
      valueFrom:
        secretKeyRef:
          name: postgres-credentials
          key: password
    # MySQL
    - name: MYSQL_HOST
      value: "mysql-service"
    - name: MYSQL_PWD
      valueFrom:
        secretKeyRef:
          name: mysql-credentials
          key: password
    # Redis
    - name: REDISCLI_AUTH
      valueFrom:
        secretKeyRef:
          name: redis-credentials
          key: password
```

---

## Description

The Databases Bundle is a comprehensive Docker image containing command-line clients for the most popular databases. This bundle is ideal for:

- **Database administrators** who need to connect to multiple database types
- **DevOps engineers** troubleshooting database connectivity in Kubernetes
- **Developers** running database migrations or queries from CI/CD pipelines

## Included Components

| Component | Tool | Description |
|-----------|------|-------------|
| postgres | `psql`, `pg_dump`, `pg_restore` | PostgreSQL client and utilities |
| mysql | `mysql`, `mysqldump` | MySQL client and utilities |
| mariadb | `mariadb`, `mariadb-dump` | MariaDB client and utilities |
| mongo | `mongosh` | MongoDB Shell |
| redis | `redis-cli` | Redis command line interface |

## Basic Usage

### PostgreSQL
```bash
# Connect to database
psql -h hostname -U user -d database

# Execute query
psql -h hostname -U user -d database -c "SELECT version();"

# Backup database
pg_dump -h hostname -U user database > backup.sql
```

### MySQL
```bash
# Connect to database
mysql -h hostname -u user -p

# Execute query
mysql -h hostname -u user -p -e "SHOW DATABASES;"

# Backup database
mysqldump -h hostname -u user -p database > backup.sql
```

### MariaDB
```bash
# Connect to database
mariadb -h hostname -u user -p

# Execute query
mariadb -h hostname -u user -p -e "SHOW DATABASES;"
```

### MongoDB
```bash
# Connect to server
mongosh "mongodb://hostname:27017"

# Connect with authentication
mongosh "mongodb://user:password@hostname:27017/database"

# Execute command
mongosh "mongodb://hostname:27017" --eval "db.stats()"
```

### Redis
```bash
# Connect to server
redis-cli -h hostname -p 6379

# Connect with authentication
redis-cli -h hostname -a password

# Execute command
redis-cli -h hostname PING
```

## Environment Variables

### PostgreSQL
| Variable | Description |
|----------|-------------|
| `PGHOST` | Server host |
| `PGPORT` | Server port (default: 5432) |
| `PGUSER` | Connection user |
| `PGPASSWORD` | Password |
| `PGDATABASE` | Default database |

### MySQL/MariaDB
| Variable | Description |
|----------|-------------|
| `MYSQL_HOST` | Server host |
| `MYSQL_TCP_PORT` | Server port (default: 3306) |
| `MYSQL_PWD` | Password (not recommended in production) |

### Redis
| Variable | Description |
|----------|-------------|
| `REDISCLI_AUTH` | Authentication password |

## Official Documentation

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [MariaDB Documentation](https://mariadb.com/kb/en/)
- [MongoDB Documentation](https://www.mongodb.com/docs/)
- [Redis Documentation](https://redis.io/docs/)
