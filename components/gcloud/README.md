# Google Cloud SDK (gcloud)

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/pabpereza/toolkitbox)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/gcloud?logo=docker)](https://hub.docker.com/r/toolkitbox/gcloud)

Command line client for Google Cloud Platform.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/gcloud:latest

# Login interactively
docker run -it --rm \
  -v ~/.config/gcloud:/root/.config/gcloud \
  ghcr.io/pabpereza/toolkitbox/gcloud:latest \
  gcloud auth login

# Run single command with cached credentials
docker run --rm \
  -v ~/.config/gcloud:/root/.config/gcloud \
  ghcr.io/pabpereza/toolkitbox/gcloud:latest \
  gcloud projects list

# With service account key
docker run --rm \
  -v /path/to/key.json:/credentials.json \
  -e GOOGLE_APPLICATION_CREDENTIALS=/credentials.json \
  ghcr.io/pabpereza/toolkitbox/gcloud:latest \
  gcloud auth activate-service-account --key-file=/credentials.json
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: gcloud-client
spec:
  containers:
  - name: gcloud-client
    image: ghcr.io/pabpereza/toolkitbox/gcloud:latest
    command: ["sleep", "infinity"]
    env:
    - name: GOOGLE_APPLICATION_CREDENTIALS
      value: /var/secrets/google/key.json
    volumeMounts:
    - name: gcp-credentials
      mountPath: /var/secrets/google
      readOnly: true
  volumes:
  - name: gcp-credentials
    secret:
      secretName: gcp-credentials
```

---

## Description

Google Cloud SDK is a set of tools for Google Cloud Platform. It includes `gcloud`, `gsutil`, and `bq` command-line tools for managing GCP resources, Cloud Storage, and BigQuery.

## Installation

This component downloads and installs the Google Cloud SDK from the official distribution.

## Included Tools

| Tool | Description |
|------|-------------|
| `gcloud` | Main CLI for GCP resources |
| `gsutil` | Cloud Storage management |
| `bq` | BigQuery command-line tool |

## Basic Usage

```bash
# Initialize and configure
gcloud init

# Login
gcloud auth login

# List projects
gcloud projects list

# Set default project
gcloud config set project my-project-id

# List compute instances
gcloud compute instances list

# List GKE clusters
gcloud container clusters list

# Upload to Cloud Storage
gsutil cp file.txt gs://my-bucket/

# Run BigQuery query
bq query "SELECT * FROM dataset.table LIMIT 10"
```

## Common Options

| Option | Description |
|--------|-------------|
| `--project` | GCP project ID |
| `--region` | Compute region |
| `--zone` | Compute zone |
| `--format` | Output format (json, yaml, table, csv) |
| `--quiet`, `-q` | Disable interactive prompts |
| `--verbosity` | Logging verbosity (debug, info, warning, error) |

## Service Account Authentication

For non-interactive authentication:

```bash
# Activate service account
gcloud auth activate-service-account \
  --key-file=/path/to/service-account-key.json

# Set project
gcloud config set project my-project-id
```

## Official Documentation

- [Google Cloud SDK Documentation](https://cloud.google.com/sdk/docs)
- [gcloud Reference](https://cloud.google.com/sdk/gcloud/reference)
- [gsutil Documentation](https://cloud.google.com/storage/docs/gsutil)
- [bq Documentation](https://cloud.google.com/bigquery/docs/bq-command-line-tool)
