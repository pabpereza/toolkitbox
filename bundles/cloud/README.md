# Cloud Bundle

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/pabpereza/toolkitbox)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/cloud?logo=docker)](https://hub.docker.com/r/toolkitbox/cloud)

All-in-one bundle with CLI tools for major cloud providers: AWS, Azure, and Google Cloud.

## Quick Start

### Docker
```bash
# Interactive mode with shell access
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/cloud:latest \
  sh

# AWS CLI
docker run -it --rm \
  -v ~/.aws:/root/.aws:ro \
  ghcr.io/pabpereza/toolkitbox/cloud:latest \
  aws s3 ls

# Azure CLI
docker run -it --rm \
  -v ~/.azure:/root/.azure:ro \
  ghcr.io/pabpereza/toolkitbox/cloud:latest \
  az account show

# Google Cloud CLI
docker run -it --rm \
  -v ~/.config/gcloud:/root/.config/gcloud:ro \
  ghcr.io/pabpereza/toolkitbox/cloud:latest \
  gcloud projects list
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cloud-client
spec:
  containers:
  - name: cloud-client
    image: ghcr.io/pabpereza/toolkitbox/cloud:latest
    command: ["sleep", "infinity"]
    env:
    # AWS
    - name: AWS_ACCESS_KEY_ID
      valueFrom:
        secretKeyRef:
          name: aws-credentials
          key: access-key-id
    - name: AWS_SECRET_ACCESS_KEY
      valueFrom:
        secretKeyRef:
          name: aws-credentials
          key: secret-access-key
    - name: AWS_DEFAULT_REGION
      value: "us-east-1"
    # Azure (using service principal)
    - name: AZURE_CLIENT_ID
      valueFrom:
        secretKeyRef:
          name: azure-credentials
          key: client-id
    - name: AZURE_CLIENT_SECRET
      valueFrom:
        secretKeyRef:
          name: azure-credentials
          key: client-secret
    - name: AZURE_TENANT_ID
      valueFrom:
        secretKeyRef:
          name: azure-credentials
          key: tenant-id
    # Google Cloud
    - name: GOOGLE_APPLICATION_CREDENTIALS
      value: "/var/secrets/google/key.json"
    volumeMounts:
    - name: gcp-key
      mountPath: /var/secrets/google
      readOnly: true
  volumes:
  - name: gcp-key
    secret:
      secretName: gcp-credentials
```

---

## Description

The Cloud Bundle is a comprehensive Docker image containing official CLI tools for the three major cloud providers. This bundle is ideal for:

- **DevOps engineers** managing multi-cloud infrastructure
- **CI/CD pipelines** deploying to multiple cloud providers
- **Cloud architects** who need quick access to all cloud CLIs
- **Troubleshooting** cloud resources from Kubernetes pods

## Included Components

| Component | Tool | Description |
|-----------|------|-------------|
| aws-cli | `aws` | AWS Command Line Interface v2 |
| azure-cli | `az` | Microsoft Azure CLI |
| gcloud | `gcloud`, `gsutil`, `bq` | Google Cloud SDK |

## Basic Usage

### AWS CLI
```bash
# Configure credentials
aws configure

# List S3 buckets
aws s3 ls

# List EC2 instances
aws ec2 describe-instances

# Get caller identity
aws sts get-caller-identity
```

### Azure CLI
```bash
# Login interactively
az login

# Login with service principal
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# List subscriptions
az account list

# List resource groups
az group list
```

### Google Cloud CLI
```bash
# Login interactively
gcloud auth login

# Login with service account
gcloud auth activate-service-account --key-file=/path/to/key.json

# List projects
gcloud projects list

# Set project
gcloud config set project PROJECT_ID

# List compute instances
gcloud compute instances list
```

## Environment Variables

### AWS
| Variable | Description |
|----------|-------------|
| `AWS_ACCESS_KEY_ID` | Access key ID |
| `AWS_SECRET_ACCESS_KEY` | Secret access key |
| `AWS_DEFAULT_REGION` | Default region |
| `AWS_PROFILE` | Named profile to use |

### Azure
| Variable | Description |
|----------|-------------|
| `AZURE_CLIENT_ID` | Service principal client ID |
| `AZURE_CLIENT_SECRET` | Service principal secret |
| `AZURE_TENANT_ID` | Azure AD tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Default subscription ID |

### Google Cloud
| Variable | Description |
|----------|-------------|
| `GOOGLE_APPLICATION_CREDENTIALS` | Path to service account key JSON |
| `CLOUDSDK_CORE_PROJECT` | Default project ID |
| `CLOUDSDK_COMPUTE_REGION` | Default compute region |

## Volume Mounts for Credentials

For local development, mount your credential directories:

```bash
docker run -it --rm \
  -v ~/.aws:/root/.aws:ro \
  -v ~/.azure:/root/.azure:ro \
  -v ~/.config/gcloud:/root/.config/gcloud:ro \
  ghcr.io/pabpereza/toolkitbox/cloud:latest \
  sh
```

## Official Documentation

- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/)
- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)
- [Google Cloud CLI Documentation](https://cloud.google.com/sdk/docs)
