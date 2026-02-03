# Redis Client

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/pabpereza/toolkitbox)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/redis?logo=docker)](https://hub.docker.com/r/toolkitbox/redis)

Command line client for Redis.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/redis:latest \
  redis-cli -h my-server.com -p 6379

# With authentication
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/redis:latest \
  redis-cli -h my-server.com -a PASSWORD

# Run single command
docker run --rm \
  ghcr.io/pabpereza/toolkitbox/redis:latest \
  redis-cli -h my-server.com PING
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-client
spec:
  containers:
  - name: redis-client
    image: ghcr.io/pabpereza/toolkitbox/redis:latest
    command: ["sleep", "infinity"]
    env:
    - name: REDISCLI_AUTH
      valueFrom:
        secretKeyRef:
          name: redis-credentials
          key: password
```

---

## Description

Redis CLI (`redis-cli`) is the official command line tool for interacting with Redis servers. It allows you to execute Redis commands, manage keys, monitor the server, and perform administration operations.

## Installation

This component installs `redis` (which includes `redis-cli`) from the Alpine Linux repositories.

## Basic Usage

### Connect to local Redis
```bash
redis-cli
```

### Connect to remote server
```bash
redis-cli -h hostname -p 6379
```

### Connect with authentication
```bash
redis-cli -h hostname -a password
```

### Connect to Redis with TLS
```bash
redis-cli -h hostname --tls
```

### Execute command and exit
```bash
redis-cli -h hostname PING
```

### Execute multiple commands from file
```bash
redis-cli -h hostname < commands.txt
```

## Useful Commands

### String operations
```bash
# Set value
SET key "value"

# Get value
GET key

# Set with expiration (seconds)
SETEX key 3600 "value"

# Increment counter
INCR counter
```

### List operations
```bash
# Add to list
LPUSH my_list "element"
RPUSH my_list "element"

# Get elements
LRANGE my_list 0 -1

# Get length
LLEN my_list
```

### Hash operations
```bash
# Set field
HSET user:1 name "John"

# Get field
HGET user:1 name

# Get all fields
HGETALL user:1
```

### Set operations
```bash
# Add to set
SADD my_set "element"

# Get members
SMEMBERS my_set

# Check membership
SISMEMBER my_set "element"
```

### Administration
```bash
# View all keys
KEYS *

# View keys with pattern
KEYS user:*

# Server information
INFO

# Real-time monitor
MONITOR

# View connected clients
CLIENT LIST

# Get configuration
CONFIG GET maxmemory
```

## Common Options

| Option | Description |
|--------|-------------|
| `-h` | Server hostname |
| `-p` | Port (default: 6379) |
| `-a` | Authentication password |
| `-n` | Database number (0-15) |
| `--tls` | Enable TLS |
| `--scan` | Use SCAN instead of KEYS |
| `--bigkeys` | Find large keys |
| `--memkeys` | Analyze memory usage |

## Special Modes

### Monitor mode
```bash
redis-cli MONITOR
```

### Pub/sub mode
```bash
# Subscribe to channel
redis-cli SUBSCRIBE my_channel

# Publish message
redis-cli PUBLISH my_channel "message"
```

### Key analysis
```bash
# Find large keys
redis-cli --bigkeys

# Analyze memory
redis-cli --memkeys
```

## Available Legacy Versions

- `v4` - Redis 4.x
- `v5` - Redis 5.x

## Official Documentation

- [Redis CLI](https://redis.io/docs/ui/cli/)
- [Redis Commands](https://redis.io/commands/)

