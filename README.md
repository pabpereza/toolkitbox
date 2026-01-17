# Toolkitbox 

A modular Docker image build system for DevOps/SysAdmin tools based on Alpine Linux.

## Available Images

### Bundle Images

<!-- BUNDLE_TABLE_START -->
| Image | Description | Size | Docker Pull |
|-------|-------------|------|-------------|
| all | All tools in one image | - | `docker pull toolkitbox/all:latest` |
<!-- BUNDLE_TABLE_END -->

### Individual Tools

<!-- TOOLS_TABLE_START -->
| Tool | Versions | Size | Docker Pull |
|------|----------|------|-------------|
| aws-cli | `latest` | - | `docker pull toolkitbox/aws-cli:latest` |
| postgres | `latest`, `v11` | - | `docker pull toolkitbox/postgres:latest` |
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

## Contributing
When adding new components:
1. Follow the component guidelines above
2. Test the installation script in isolation first
3. Verify the individual and all-in-one image builds successfully
4. Update documentation if adding complex components

## Author

Created and maintained by:
- Fermín Jiménez ([@Rimander](https://github.com/Rimander))
- Pablo Pérez-Aradros ([@pabpereza](https://github.com/pabpereza))