# AWS CLI

[![GitHub Stars](https://img.shields.io/github/stars/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox)
[![GitHub Issues](https://img.shields.io/github/issues/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox/issues)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/aws-cli?logo=docker)](https://hub.docker.com/r/toolkitbox/aws-cli)

> 📢 **Found an issue or want to request a new tool?** [Open an issue on GitHub](https://github.com/pabpereza/toolkitbox/issues)

Command line client for Amazon Web Services.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  -e AWS_ACCESS_KEY_ID=your_access_key \
  -e AWS_SECRET_ACCESS_KEY=your_secret_key \
  -e AWS_DEFAULT_REGION=eu-west-1 \
  ghcr.io/pabpereza/toolkitbox/aws-cli:latest

# Run single command
docker run --rm \
  -e AWS_ACCESS_KEY_ID=your_access_key \
  -e AWS_SECRET_ACCESS_KEY=your_secret_key \
  -e AWS_DEFAULT_REGION=eu-west-1 \
  ghcr.io/pabpereza/toolkitbox/aws-cli:latest aws s3 ls
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: aws-cli
spec:
  containers:
  - name: aws-cli
    image: ghcr.io/pabpereza/toolkitbox/aws-cli:latest
    command: ["sleep", "infinity"]
    env:
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
      value: "eu-west-1"
```

---

## Description

AWS CLI is Amazon's official tool for interacting with all AWS services from the terminal. It allows you to manage EC2, S3, Lambda, RDS resources, and over 200 AWS services.

## Installation

This component installs AWS CLI v2 from the Alpine Linux repositories.

## Basic Usage

### Configure credentials
```bash
aws configure
```

### List S3 buckets
```bash
aws s3 ls
```

### List EC2 instances
```bash
aws ec2 describe-instances
```

### Upload file to S3
```bash
aws s3 cp file.txt s3://my-bucket/
```

### Sync directory with S3
```bash
aws s3 sync ./local-dir s3://my-bucket/remote-dir
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `AWS_ACCESS_KEY_ID` | Access key ID |
| `AWS_SECRET_ACCESS_KEY` | Secret access key |
| `AWS_DEFAULT_REGION` | Default region (e.g., `eu-west-1`) |
| `AWS_PROFILE` | Configuration profile to use |

## Official Documentation

- [AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/)
- [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/)

