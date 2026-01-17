# Ops Toolchain Assembly

A modular Docker image build system using the **Dynamic Injection** pattern for assembling Alpine-based DevOps/SysAdmin toolchain images.

## Overview

This system allows you to dynamically build a "mega image" containing multiple tools without manually editing Dockerfiles. Simply add a new component directory with an `install.sh` script, and the orchestrator automatically includes it in the build.

## Architecture

The Dynamic Injection pattern works as follows:

1. **Component Discovery**: The orchestrator scans the `components/` directory for tools
2. **Script Collection**: Each component's `install.sh` is copied to a temporary build context
3. **Dynamic Installation**: The Dockerfile iterates through all collected scripts and executes them
4. **Clean Build**: Temporary files are removed to keep the final image lean

## Project Structure

```
ops-toolchain-assembly/
├── .gitignore                   # Ignores .build-context directory
├── build-mega-image.sh          # Orchestrator script (main entry point)
├── Dockerfile.bundle            # Generic Dockerfile for mega image
└── components/                  # Component library
    ├── postgres/
    │   ├── install.sh           # Latest PostgreSQL client installer
    │   └── v11-legacy/          # Legacy version (not included in bundle)
    │       └── Dockerfile       # Standalone Dockerfile for PG 11
    └── aws-cli/
        └── install.sh           # AWS CLI installer
```

##  Quick Start

### Building the Mega Image

```bash
cd ops-toolchain-assembly
./build-mega-image.sh
```

The script will:
- Discover all components with `install.sh` files
- Create a temporary `.build-context` directory
- Copy and rename component installers (e.g., `postgres.sh`, `aws-cli.sh`)
- Build the Docker image tagged as `ops-toolchain:latest`

### Custom Image Name

```bash
IMAGE_NAME=my-ops-tools:v1.0 ./build-mega-image.sh
```

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

3. Make it executable:
   ```bash
   chmod +x components/my-tool/install.sh
   ```

4. Rebuild the mega image:
   ```bash
   ./build-mega-image.sh
   ```

That's it! No Dockerfile editing required.

## Component Guidelines

### install.sh Requirements

- Must be executable (`chmod +x`)
- Should use `set -e` to fail fast on errors
- Should use `apk add --no-cache` to minimize image size
- Should verify installation success
- Should log progress for debugging

### Example Template

```bash
#!/bin/bash
# Component Name Installer for Alpine Linux
# Brief description of what this installs

set -e

echo "Installing component-name..."

# Install packages
apk add --no-cache package-name

# Verify installation
if command -v executable-name &> /dev/null; then
    version=$(executable-name --version 2>&1 || echo "installed")
    echo "Component installed: $version"
else
    echo "ERROR: Component installation failed"
    exit 1
fi

echo "Component installation complete"
```

## Legacy Versions

Components can maintain legacy versions in subdirectories (e.g., `v11-legacy/`). These are **not** automatically included in the mega image but can be built independently:

```bash
cd components/postgres/v11-legacy
docker build -t postgres:11-legacy .
```

## Base Image Details

- **Base**: `alpine:latest`
- **Pre-installed**: bash, curl, ca-certificates
- **Default Shell**: `/bin/bash`
- **Default CMD**: `/bin/bash`

## Benefits

- **Modularity**: Each component is self-contained
- **Flexibility**: Easy to add, remove, or update components
- **Maintainability**: No central Dockerfile to maintain
- **Reusability**: Components can be used in different combinations
- **Version Control**: Easy to track changes per component
- **CI/CD Friendly**: Automated discovery works in pipelines

## Advanced Usage

### Conditional Builds

You can conditionally include components by temporarily removing their `install.sh`:

```bash
mv components/aws-cli/install.sh components/aws-cli/install.sh.disabled
./build-mega-image.sh
mv components/aws-cli/install.sh.disabled components/aws-cli/install.sh
```

### Multi-Stage Builds

For components requiring build tools, create an `install.sh` that uses temporary packages:

```bash
#!/bin/bash
set -e

# Install build dependencies temporarily
apk add --no-cache --virtual .build-deps gcc musl-dev

# Build and install
# ... your build commands ...

# Remove build dependencies
apk del .build-deps
```

## Troubleshooting

### Component Not Found

If a component isn't being included:
- Verify `install.sh` exists in the component's root directory
- Check that `install.sh` is executable (`ls -l components/*/install.sh`)
- Ensure there are no syntax errors in `install.sh`

### Build Failures

If the Docker build fails:
- Check the component's `install.sh` for errors
- Verify package names are correct for Alpine Linux
- Review Docker build logs for specific error messages
- Test the `install.sh` script in an Alpine container manually

### Network Issues

If package downloads fail:
- Check internet connectivity
- Verify Alpine repository mirrors are accessible
- Consider using a local Alpine mirror

## Contributing

When adding new components:
1. Follow the component guidelines above
2. Test the installation script in isolation first
3. Verify the mega image builds successfully
4. Update documentation if adding complex components

## License

This infrastructure is designed for enterprise use and follows DevOps best practices.

## Author

Created by Senior DevOps Engineer / Container Architect
