# Toolkitbox 

A modular Docker image build system for DevOps/SysAdmin tools based on Alpine Linux.

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/pabpereza/toolkitbox)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/all?logo=docker)](https://hub.docker.com/r/toolkitbox/all)

## Available Images

### Bundle Images

<!-- BUNDLE_TABLE_START -->
| Image | Description | Components | Docker Pull | Badges |
|-------|-------------|------------|-------------|--------|
| all | All tools in one image | all components | `docker pull toolkitbox/all` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/all?logo=docker)](https://hub.docker.com/r/toolkitbox/all) |
| cloud | Cloud Bundle | aws-cli, azure-cli, gcloud | `docker pull toolkitbox/cloud` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/cloud?logo=docker)](https://hub.docker.com/r/toolkitbox/cloud) |
| databases | Databases Bundle | postgres, mysql, mariadb, mongo, redis | `docker pull toolkitbox/databases` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/databases?logo=docker)](https://hub.docker.com/r/toolkitbox/databases) |
<!-- BUNDLE_TABLE_END -->

### Individual Tools

<!-- TOOLS_TABLE_START -->
| Tool | Versions | Size | Docker Pull | Badges |
|------|----------|------|-------------|--------|
| aws-cli | `latest`,`v1` | 45.3 MB | `docker pull toolkitbox/aws-cli` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/aws-cli?logo=docker)](https://hub.docker.com/r/toolkitbox/aws-cli) |
| azure-cli | `latest` | 132.5 MB | `docker pull toolkitbox/azure-cli` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/azure-cli?logo=docker)](https://hub.docker.com/r/toolkitbox/azure-cli) |
| gcloud | `latest` | 152.1 MB | `docker pull toolkitbox/gcloud` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/gcloud?logo=docker)](https://hub.docker.com/r/toolkitbox/gcloud) |
| mariadb | `latest`,`v10.3`,`v10.4` | 17.2 MB | `docker pull toolkitbox/mariadb` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/mariadb?logo=docker)](https://hub.docker.com/r/toolkitbox/mariadb) |
| mongo | `latest`,`v3.6`,`v4.4` | 53.2 MB | `docker pull toolkitbox/mongo` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/mongo?logo=docker)](https://hub.docker.com/r/toolkitbox/mongo) |
| mysql | `latest`,`v5.6`,`v5.7` | 17.2 MB | `docker pull toolkitbox/mysql` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/mysql?logo=docker)](https://hub.docker.com/r/toolkitbox/mysql) |
| postgres | `latest`,`v10`,`v11`,`v9.6` | 8.7 MB | `docker pull toolkitbox/postgres` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/postgres?logo=docker)](https://hub.docker.com/r/toolkitbox/postgres) |
| redis | `latest`,`v4`,`v5` | 9.9 MB | `docker pull toolkitbox/redis` | [![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/redis?logo=docker)](https://hub.docker.com/r/toolkitbox/redis) |
<!-- TOOLS_TABLE_END -->

## Overview
This system allows you to dynamically build a "mega image" containing multiple tools without manually editing Dockerfiles. Simply add a new component directory with an `install.sh` script, and the orchestrator automatically includes it in the build.

This repository builds an individual image for each component as well, allowing for flexible usage and an all-in-one image.

## Architecture

The Dynamic Injection pattern works as follows:

1. **Component Discovery**: The orchestrator scans the `components/` directory for tools
2. **Script Collection**: Each component's `install.sh` is copied to a temporary build context
3. **Dynamic Installation**: The Dockerfile iterates through all collected scripts and executes them
4. **Clean Build**: Temporary files are removed to keep the final image lean

## Project Structure

```
.gitignore                   # Ignores .build-context directory
build-mega-image.sh          # Orchestrator script (main entry point)
build-single.sh              # Script to build individual component images
Dockerfile.bundle            # Generic Dockerfile for mega image
components/                  # Component library
├── postgres/
│   ├── install.sh           # Latest PostgreSQL client installer
│   └── v11-legacy/          # Legacy version (not included in bundle)
│       └── Dockerfile       # Standalone Dockerfile for PG 11
└── aws-cli/
└── install.sh           # AWS CLI installer
```

## Quick Start

### Building the all-in-one Image

```bash
./build-all-in-one.sh
```

The script will:
- Discover all components with `install.sh` files
- Create a temporary `.build-context` directory
- Copy and rename component installers (e.g., `postgres.sh`, `aws-cli.sh`)
- Build the Docker image tagged as `ops-toolchain:latest`


## Adding New Components

To add a new tool to the mega image:

1. Create a new directory under `components/`:
   ```bash
   mkdir components/my-tool
   ```

2. Create an `install.sh` script:
   ```bash
   cat > components/my-tool/install.sh <<'EOF'
   #!/bin/bash
   set -e
   
   echo "Installing my-tool..."
   apk add --no-cache my-tool
   
   # Verify installation
   if command -v my-tool &> /dev/null; then
       echo "my-tool installed successfully"
   else
       echo "ERROR: my-tool installation failed"
       exit 1
   fi
   EOF
   ```

3. Rebuild the all-in-one image:
   ```bash
   ./build-allinone.sh
   ```

That's it! No Dockerfile editing required.

## Automated Docker Hub Description Sync

This repository includes an automated workflow that keeps Docker Hub image descriptions synchronized with component READMEs.

### Workflow: `sync-dockerhub-descriptions.yml`

**Triggers:**
- Automatically when `components/**/README.md` files are updated in the `main` branch
- Manually via GitHub Actions UI (workflow_dispatch)

**Functionality:**
1. Authenticates with Docker Hub API
2. Iterates through all components in `components/` directory
3. Updates the Docker Hub description for each image using its README.md content

**Requirements:**
- `DOCKER_TOKEN` secret must be configured in repository settings
- Docker Hub repositories must exist before running the workflow

### Updating Component Descriptions

To update a Docker Hub image description:

1. Edit the component's README: `components/{component}/README.md`
2. Commit and push to the `main` branch
3. The workflow will automatically sync the description to Docker Hub

The workflow uses the entire README content as the "full description" on Docker Hub, preserving all markdown formatting.

## Contributing
When adding new components:
1. Follow the component guidelines above
2. Test the installation script in isolation first
3. Verify the individual and all-in-one image builds successfully
4. Update documentation if adding complex components
5. Create a comprehensive README.md in the component directory (it will be synced to Docker Hub)

## Author

Created and maintained by:
- Fermín Jiménez ([@Rimander](https://github.com/Rimander))
- Pablo Pérez-Aradros ([@pabpereza](https://github.com/pabpereza))