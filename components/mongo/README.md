# MongoDB Client (mongosh)

Modern MongoDB shell for interacting with MongoDB databases.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/mongo:latest \
  mongosh "mongodb://my-server:27017"

# With authentication
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/mongo:latest \
  mongosh "mongodb://user:password@my-server:27017/database"

# Run single command
docker run --rm \
  ghcr.io/pabpereza/toolkitbox/mongo:latest \
  mongosh "mongodb://my-server:27017" --eval "db.getCollectionNames()"
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mongo-client
spec:
  containers:
  - name: mongo-client
    image: ghcr.io/pabpereza/toolkitbox/mongo:latest
    command: ["sleep", "infinity"]
    env:
    - name: MONGODB_URI
      valueFrom:
        secretKeyRef:
          name: mongo-credentials
          key: uri
```

---

## Description

`mongosh` is the official MongoDB shell that replaces the legacy `mongo` shell. It provides a rich command line interface with autocomplete, syntax highlighting, and full JavaScript support.

## Installation

This component downloads and installs `mongosh` directly from the official MongoDB binaries. Supports x64 and arm64 architectures.

## Basic Usage

### Connect to local MongoDB
```bash
mongosh
```

### Connect to remote server
```bash
mongosh "mongodb://hostname:27017"
```

### Connect with authentication
```bash
mongosh "mongodb://user:password@hostname:27017/database"
```

### Connect to MongoDB Atlas
```bash
mongosh "mongodb+srv://cluster.mongodb.net/mydb" --username user
```

### Execute command and exit
```bash
mongosh --eval "db.getCollectionNames()"
```

### Execute JavaScript script
```bash
mongosh script.js
```

## Useful Shell Commands

```javascript
// Show databases
show dbs

// Use database
use my_database

// Show collections
show collections

// Find documents
db.my_collection.find()

// Insert document
db.my_collection.insertOne({ name: "example" })

// Find with filter
db.my_collection.find({ field: "value" })

// Count documents
db.my_collection.countDocuments()

// Create index
db.my_collection.createIndex({ field: 1 })
```

## Connection Options

| Option | Description |
|--------|-------------|
| `--host` | MongoDB server |
| `--port` | Port (default: 27017) |
| `--username` | Authentication user |
| `--password` | Password |
| `--authenticationDatabase` | Authentication database |
| `--eval` | Execute JavaScript expression |

## Available Legacy Versions

- `v3.6` - MongoDB 3.6 (uses classic mongo shell)
- `v4.4` - MongoDB 4.4 (uses classic mongo shell)

## Official Documentation

- [MongoDB Shell (mongosh)](https://www.mongodb.com/docs/mongodb-shell/)
- [CRUD Operations](https://www.mongodb.com/docs/mongodb-shell/crud/)

