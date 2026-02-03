# Project Context & Architectural Standards

**Project Name:** Toolkitbox 

**Description:** Modular Docker image registry for DevOps/SysAdmin tools based on Alpine Linux.

**Architecture Pattern:** Dynamic Injection & Hybrid Assembly.

## 1. Core Philosophy

This repository operates on a **"Component-Based"** architecture to solve the dependency hell of monolithic Dockerfiles while allowing the creation of efficient bundles.

* **Modern Tools (Latest):** Defined via **Shell Scripts (`install.sh`)**. They are dynamically injected into a base `alpine:latest` image.
* **Legacy Tools (Old Versions):** Defined via **Standalone Dockerfiles**. They are isolated in their own containers to preserve old libraries (glibc/musl compatibility).

## 2. Directory Structure

All agents must strictly adhere to this hierarchy:

```text
ops-toolchain-assembly/
├── build-mega-image.sh          # Orchestrator for bundles (Do not modify logic without approval)
├── build-single.sh              # Builder for single components (Template based)
├── Dockerfile.bundle            # The generic template for the mega-image
├── components/                  # THE SOURCE OF TRUTH
│   ├── [tool-name]/             # Kebab-case naming (e.g., postgres-client)
│   │   ├── install.sh           # REQUIRED for modern versions.
│   │   └── [version]-legacy/    # OPTIONAL for legacy.
│   │       └── Dockerfile       # Standalone Dockerfile for legacy.

```

## 3. Development Rules (Strict)

### A. The `install.sh` Standard (For Latest Versions)

When asked to add a new tool, you must create a shell script, not a Dockerfile.

#### Mandatory Structure

Every `install.sh` must follow this exact structure:

```bash
#!/bin/sh
# [Tool Name] - Brief description of what it installs
set -e

echo ">> Installing [Tool Name]..."
apk add --no-cache [package-name]
```

#### Format Rules

1. **Shebang:** Must be `#!/bin/sh` (Alpine standard, NOT `#!/bin/bash`).
2. **Comment Header:** Second line must be `# [Tool Name] - Brief description`.
3. **Error Handling:** Must have `set -e` immediately after comment.
4. **Logging:** Use `echo ">> ..."` prefix for all log messages.
5. **Package Manager:** Use `apk add --no-cache`. Never leave cache files.
6. **Cleanup:** If downloading external files, always cleanup with `rm -rf /tmp/*`.

#### Example: Simple APK Install

```bash
#!/bin/sh
# Redis Client - Installs Redis CLI tools
set -e

echo ">> Installing Redis Client..."
apk add --no-cache redis
```

#### Example: External Download (when APK unavailable)

```bash
#!/bin/sh
# MongoDB Client - Installs MongoDB Shell (mongosh)
set -e

VERSION="2.3.0"

echo ">> Installing MongoDB Client..."
apk add --no-cache curl

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)  ARCH_NAME="x64" ;;
    aarch64) ARCH_NAME="arm64" ;;
    *)       echo ">> ERROR: Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Download and install
echo ">> Downloading mongosh ${VERSION}..."
curl -fsSL "https://example.com/tool-${VERSION}-${ARCH_NAME}.tgz" -o /tmp/tool.tgz
tar -xzf /tmp/tool.tgz -C /tmp
cp /tmp/tool-*/bin/tool /usr/local/bin/
chmod +x /usr/local/bin/tool

# Cleanup
rm -rf /tmp/tool*
```

### B. The Legacy Standard (For Old Versions)

When asked to support an old version (e.g., MongoDB 3.6), do not use `install.sh`.

1. Create a subfolder: `components/[tool]/v[x]`.
2. Create a `Dockerfile`.
3. **Base Image:** Use a specific, frozen Alpine version (e.g., `FROM alpine:3.9`).
4. **Isolation:** This image will NOT be part of the Mega-Bundle.

### C. Build scripts

* **`build-allinone.sh`**: Scans `components/` for `install.sh` files, copies them to a build context, and builds `Dockerfile.bundle`.
* **`build-single.sh`**: Takes a component name, creates a dynamic Dockerfile on the fly injecting the specific `install.sh`, and builds a single image.

## 4. Workflows for Agents

**Scenario 1: "Add a new tool like Terraform"**

* Create directory `components/terraform/`.
* Create `components/terraform/install.sh`.
* Write the `apk add` or `wget` logic (for Alpine).
* Verify permissions (`chmod +x`).

**Scenario 2: "Update the PostgreSQL client"**

* Modify `components/postgres/install.sh`.
* Do NOT modify `Dockerfile.bundle`.

**Scenario 3: "Add support for an old Python 2 tool"**

* Create `components/python-tools/v2-legacy/Dockerfile`.
* Use `FROM python:2.7-alpine`.

## 5. Technical Constraints

* **OS Base:** Always `alpine` (unless strictly impossible, then `debian-slim` but warn user).
* **Shell:** Prefer `sh` over `bash` for installers to ensure portability.
* **User:** Operations run as `root` during build, but images may switch to non-root at the end if required by the tool.

## 6. README Documentation Standard

Every component in `components/[tool-name]/` must have a `README.md` file in English. The structure must follow this exact order:

### Mandatory Structure

```markdown
# [Tool Name]

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/pabpereza/toolkitbox)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolkitbox/[tool-name]?logo=docker)](https://hub.docker.com/r/toolkitbox/[tool-name])

One-line description of the tool.

## Quick Start

### Docker
```bash
# Interactive mode
docker run -it --rm \
  ghcr.io/pabpereza/toolkitbox/[tool-name]:latest \
  [command]

# Run single command
docker run --rm \
  ghcr.io/pabpereza/toolkitbox/[tool-name]:latest \
  [command] [args]
```

### Kubernetes
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: [tool-name]-client
spec:
  containers:
  - name: [tool-name]-client
    image: ghcr.io/pabpereza/toolkitbox/[tool-name]:latest
    command: ["sleep", "infinity"]
    env:
    - name: [ENV_VAR]
      valueFrom:
        secretKeyRef:
          name: [tool-name]-credentials
          key: [key]
```

---

## Description

Detailed description of the tool.

## Installation

How the component installs the tool.

## Basic Usage

Common usage examples.

## Common Options

Table of common options.

## Available Legacy Versions (if applicable)

List of legacy versions.

## Official Documentation

Links to official docs.
```

### Key Rules

1. **Badges:** Include GitHub repository badge and Docker Hub pulls badge immediately after the title.
2. **Quick Start First:** Docker and Kubernetes examples MUST be the first sections after the badges and description.
3. **Image Registry:** Always use `ghcr.io/pabpereza/toolkitbox/[tool-name]:latest`.
4. **Separator:** Use `---` to separate Quick Start from detailed documentation.
5. **Language:** All documentation must be in English.
6. **Kubernetes Examples:** Always include a Pod manifest with `sleep infinity` for debugging and environment variables using Secrets.
7. **Docker Examples:** Include both interactive mode and single command execution.
