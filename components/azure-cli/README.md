# Azure CLI

[![GitHub Stars](https://img.shields.io/github/stars/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox)
[![GitHub Issues](https://img.shields.io/github/issues/pabpereza/toolkitbox?style=flat&logo=github)](https://github.com/pabpereza/toolkitbox/issues)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/azure-cli?logo=docker)](https://hub.docker.com/r/toolkitbox/azure-cli)

> 📢 **Found an issue or want to request a new tool?** [Open an issue on GitHub](https://github.com/pabpereza/toolkitbox/issues)

Command line client for Microsoft Azure.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/azure-cli:latest

# Login interactively
docker run -it --rm \
  -v ~/.azure:/root/.azure \
  ghcr.io/pabpereza/toolkitbox/azure-cli:latest \
  az login

# Run single command with cached credentials
docker run --rm \
  -v ~/.azure:/root/.azure \
  ghcr.io/pabpereza/toolkitbox/azure-cli:latest \
  az account list
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: azure-cli-client
spec:
  containers:
  - name: azure-cli-client
    image: ghcr.io/pabpereza/toolkitbox/azure-cli:latest
    command: ["sleep", "infinity"]
    env:
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
```

---

## Description

Azure CLI is a cross-platform command-line tool for managing Azure resources. It provides commands for working with Azure services including virtual machines, storage, networking, databases, and more.

## Installation

This component installs Azure CLI via pip on Alpine Linux.

## Basic Usage

```bash
# Login to Azure
az login

# List subscriptions
az account list

# Set default subscription
az account set --subscription "My Subscription"

# List resource groups
az group list

# Create a resource group
az group create --name myResourceGroup --location eastus

# List VMs
az vm list

# Get help
az --help
```

## Common Options

| Option | Description |
|--------|-------------|
| `--subscription` | Name or ID of subscription |
| `--resource-group`, `-g` | Name of resource group |
| `--output`, `-o` | Output format (json, table, tsv, yaml) |
| `--query` | JMESPath query string |
| `--verbose` | Increase logging verbosity |
| `--debug` | Show all debug logs |

## Service Principal Authentication

For non-interactive authentication (CI/CD, scripts):

```bash
# Login with service principal
az login --service-principal \
  --username $AZURE_CLIENT_ID \
  --password $AZURE_CLIENT_SECRET \
  --tenant $AZURE_TENANT_ID
```

## Official Documentation

- [Azure CLI Documentation](https://docs.microsoft.com/cli/azure/)
- [Azure CLI Reference](https://docs.microsoft.com/cli/azure/reference-index)
- [Azure CLI GitHub](https://github.com/Azure/azure-cli)
